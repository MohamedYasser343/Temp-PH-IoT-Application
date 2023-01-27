package Routes

import (
	"github.com/gin-gonic/gin"
	"GolangServer/Controllers"
)

func RouteConfig() {
	router := gin.Default()
	router.GET("/Data", Controllers.GetAllData)
	router.GET("/Data/:id", Controllers.GetReadingsById)
	router.POST("/Data", Controllers.AddData)
	router.Run(":9999")
}
