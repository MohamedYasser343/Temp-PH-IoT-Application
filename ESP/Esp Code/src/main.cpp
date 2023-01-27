// include libraries
#include <Arduino.h>
#include <Arduino.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>

// defines for LM35
#define ADC_VREF_mV    3300.0 // in millivolt
#define ADC_RESOLUTION 4096.0
#define PIN_LM35       36 // ESP32 pin GIOP36 (ADC0) connected to LM35

// wifi config
const char *ssid = "soil cap";
const char *password = "12345678";
char jsonOutput[128];

void setup() {
  Serial.begin(9600);
  
  WiFi.begin(ssid, password);
  Serial.println("Connecting to wifi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(500);
  }
  Serial.println("\nConnected to the wifi network");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  Serial.println(F("LM35 Start"));
}

void loop() {
  // get temperature from LM35
  int adcVal = analogRead(PIN_LM35);
  float milliVolt = adcVal * (ADC_VREF_mV / ADC_RESOLUTION);
  float tempC = milliVolt / 10;

  // post data on the server
  if (WiFi.status() == WL_CONNECTED)
  {
    HTTPClient client;
    client.begin("http://92.205.60.182:9999/Data");
    client.addHeader("Content-Type", "application/json");
    const size_t CAPACITY = JSON_OBJECT_SIZE(2);
    StaticJsonDocument<CAPACITY> doc;

    JsonObject object = doc.to<JsonObject>();
    object["Temp"] = tempC;

    serializeJson(doc, jsonOutput);

    int httpCode = client.POST(String(jsonOutput));

    if (httpCode > 0)
    {
      String payload = client.getString();
      Serial.println("\nStatuscode: " + String(httpCode));
      Serial.println(payload);

      client.end();
    }
    else
    {
      Serial.println("Error on http request");
    }
  }

  delay(5000);
}
