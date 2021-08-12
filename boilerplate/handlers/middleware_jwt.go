package handlers

import (
	"strings"

	"github.com/genghongjie/ginbro/boilerplate/models"
	"github.com/gin-gonic/gin"
)

var jwtMiddleware = jwtCheck()

const tokenPrefix = "Bearer "

func jwtCheck() gin.HandlerFunc {
	return func(c *gin.Context) {
		token := strings.Replace(c.GetHeader("Authorization"), tokenPrefix, "", 1)
		user, err := models.JwtParseUser(token)
		if err != nil {
			handleError(c, err)
			//c.Abort has been called
			return
		}
		//store the user Model in the context
		c.Set("user", user)
		c.Next()
		// after request
	}
}
