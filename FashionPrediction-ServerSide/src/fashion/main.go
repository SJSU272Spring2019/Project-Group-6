/*
	Project 6 Fashion Prediction API in Go 
	Uses MongoDB for database
*/
package main

import (
	"os"
)

func main() {

	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = "4000"
	}

	server := NewServer()
	server.Run(":" + port)
}