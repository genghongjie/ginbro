package main

import (
	_ "github.com/genghongjie/ginbro/boilerplate/config"
	"github.com/genghongjie/ginbro/boilerplate/handlers"
	"github.com/genghongjie/ginbro/boilerplate/tasks"
	"github.com/spf13/viper"
)

func main() {
	if viper.GetBool("app.enable_cron") {
		go tasks.RunTasks()
	}
	defer handlers.Close()
	handlers.ServerRun()
}
