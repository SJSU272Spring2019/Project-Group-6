/*
	Project 6 Fashion Prediction API in Go 
	Uses MongoDB for database
*/
package main

import (	
	"net/http"
	"github.com/codegangsta/negroni"
	"github.com/gorilla/mux"
	"github.com/unrolled/render"
)

// MongoDB Config
var mongodb_server = "mongodb:27017"
var mongodb_database = "cmpe272"
var mongodb_collection = "fashion"



// NewServer configures and returns a Server.
func NewServer() *negroni.Negroni {
	formatter := render.New(render.Options{
		IndentJSON: true,
	})
	n := negroni.Classic()
	mx := mux.NewRouter()
	initRoutes(mx, formatter)
	n.UseHandler(mx)
	return n
}

// API Routes
func initRoutes(mx *mux.Router, formatter *render.Render) {
	mx.HandleFunc("/v1/prediction/{raceid}", predictionHandler(formatter)).Methods("GET")

}

// API Prediction Handler
func predictionHandler(formatter *render.Render) http.HandlerFunc {
	return func(w http.ResponseWriter, req *http.Request) {
		params := mux.Vars(req)
		var raceid string = params["raceid"]

		// 1. make request to Waston prediction model
		// Wastion studio model id endpoint with auth token
		resp, err := http.Get("")
		if err != nil {
			log.Fatalln(err)
		}

		// 2. get Waston prediction 
		body, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			log.Fatalln(err)
		}
		
		formatter.JSON(w, http.StatusOK, raceid)
	}
}



