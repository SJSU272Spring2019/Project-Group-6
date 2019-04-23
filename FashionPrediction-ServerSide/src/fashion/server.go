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
	"log"
	"io/ioutil"
	"io"
	"github.com/watson-developer-cloud/go-sdk/visualrecognitionv3"
	"os"
	"github.com/IBM/go-sdk-core/core"
	"encoding/json"
    "fmt"
    "strings"
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
	mx.HandleFunc("/v1/prediction", predictionHandler(formatter)).Methods("POST")

}

// API Prediction Handler
func predictionHandler(formatter *render.Render) http.HandlerFunc {
	return func(w http.ResponseWriter, req *http.Request) {
	    /**
			Get Post body
		**/        
        body, err := ioutil.ReadAll(req.Body)
		if err != nil {
			log.Fatalln(err)
		}
		fmt.Println(body)

		var clothUrl Clothes
		json.Unmarshal(body, &clothUrl)
	    /**
			Connect to Waston
		**/  
		visualRecognition, visualRecognitionErr := visualrecognitionv3.NewVisualRecognitionV3(&visualrecognitionv3.VisualRecognitionV3Options{
	  		Version: "2018-03-19",
			IAMApiKey: "54qjyFj9ESmM9rKUMnJk0uL2EEs26arlX9ukgdhVoROA",
		})

		if visualRecognitionErr != nil {
		   //panic(visualRecognitionErr)
			fmt.Println("visualRecognitionErr")
		}
		/**
			Get image from frontend
		**/
		//fileUrl := "https://tineye.com/images/widgets/mona.jpg"

	    if err := DownloadFile("test.jpg", clothUrl.ClothesUrl); err != nil {
	        fmt.Println("DownloadFile")
	    }
		fmt.Println("DownloadFile-Success")

		imageFile, imageFileErr := os.Open("test.jpg")

		if imageFileErr != nil {
			fmt.Println("image file error")
		}
		defer imageFile.Close()
		fmt.Println("Open image-Success")

		  response, responseErr := visualRecognition.Classify(
		    &visualrecognitionv3.ClassifyOptions{
		      ImagesFile: imageFile,
		      Threshold: core.Float32Ptr(0.0),
		      ClassifierIds: []string{"modelx1_1561818531"},
		    },
		  )
		  fmt.Println("response-Success")

		  if responseErr != nil {
		  	fmt.Println("response file error")
		    //panic(responseErr)
		  }

		  result := visualRecognition.GetClassifyResult(response)
		  b, _ := json.MarshalIndent(result, "", "  ")
		  s := strings.Split(string(b), ":")
		  likeBody := s[len(s)-1]
		  /**
		  	 Get prediction like number
		  **/
		  likeResult := strings.Split(string(likeBody), "}")[0]
		  likeResponse := strings.TrimSpace(likeResult)
		  fmt.Println("likeResponse", likeResponse)

		  var returnResponse Predict
		  returnResponse.Class = "like"
		  returnResponse.Score = likeResponse
	
		formatter.JSON(w, http.StatusOK, returnResponse)
	}
}

/* Get the resource from Stackoverflow */
func DownloadFile(filepath string, url string) error {

    // Get the data
    resp, err := http.Get(url)
    if err != nil {
        //return err
        fmt.Println("Get the data")
    }
    defer resp.Body.Close()

    // Create the file
    out, err := os.Create(filepath)
    if err != nil {
        fmt.Println("Create the file")
    }
    defer out.Close()

    // Write the body to file
    _, err = io.Copy(out, resp.Body)
    return err
}



