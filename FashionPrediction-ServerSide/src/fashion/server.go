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
    "strconv"
    "gopkg.in/mgo.v2"
    "gopkg.in/mgo.v2/bson"
    "math/rand"
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
	mx.HandleFunc("/v1/addLike", addLikeHandler(formatter)).Methods("POST")
	mx.HandleFunc("/v1/addCart", addCartHandler(formatter)).Methods("POST")
	mx.HandleFunc("/v1/userLike", userLikeHandler(formatter)).Methods("GET")
	mx.HandleFunc("/v1/userCart", userCartHandler(formatter)).Methods("GET")
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

		var race Race
		json.Unmarshal(body, &race)
		/**
			Choose modelid from race
		**/
		var modelId string
		raceId := race.Race
		if raceId == "Asian" {
			modelId = "modelx1_1561818531"
		}
		/**
			Get clothid from MongoDB modelid
		**/
		/**
			Mongo server setup
		**/
		session, err := mgo.Dial(mongodb_server)
        if err != nil {
                fmt.Println("mongoserver panic")
        }
        defer session.Close()
        session.SetMode(mgo.Monotonic, true)
        m := session.DB(mongodb_database).C("model")
        c := session.DB(mongodb_database).C("cloth")
        ss := session.DB(mongodb_database).C("score")
		/**
			Get clothid from MongoDB model table
		**/
        var clothIdResults []bson.M
		err = m.Find(bson.M{"modelId": modelId}).All(&clothIdResults)
		if err != nil {
			fmt.Println("findquery panic")
		}

		index := rand.Intn(4)
		clothIdResult := clothIdResults[index]

		clothId := clothIdResult["clothesId"].(string) 
		/**
			Get cloth information from MongoDB cloth table
		**/
		var clothInfoResult bson.M
		err = c.Find(bson.M{"clothesId": clothId}).One(&clothInfoResult)
		if err != nil {
			fmt.Println("findquery panic")
		}

	    var returnResponse Predict
		returnResponse.ClothId = clothId
		returnResponse.Url = clothInfoResult["url"].(string)
		returnResponse.Name = clothInfoResult["name"].(string)
		returnResponse.Price = clothInfoResult["price"].(string)

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

	    if err := DownloadFile("test.jpg", returnResponse.Url); err != nil {
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
		      ClassifierIds: []string{modelId},
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
		  //fmt.Println("likeResponse", likeResponse)
		   
		  likefloat, likefloatErr := strconv.ParseFloat(likeResponse, 32)
		  if likefloatErr != nil {
		  	 fmt.Println("likefloatErr", likefloatErr)
		  }

		  likefloat *= 100.00
		  likeReturnResponse := fmt.Sprintf("%.2f", likefloat)

		  returnResponse.Score = likeReturnResponse
		  /**
		  	Store score in score table
		  **/
	  	var scoreTable Score
		scoreTable.Id = clothId
		scoreTable.Score = likeReturnResponse 
		ss.Insert(scoreTable)
	
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

// API Post AddLike Handler 
func addLikeHandler(formatter *render.Render) http.HandlerFunc {
	return func(w http.ResponseWriter, req *http.Request) {
		/**
			Mongo server setup
		**/
		session, err := mgo.Dial(mongodb_server)
        if err != nil {
                fmt.Println("mongoserver panic")
        }
        defer session.Close()
        session.SetMode(mgo.Monotonic, true)
        c := session.DB(mongodb_database).C("userLike")
		/**
			Get Post body
		**/        
        body, err := ioutil.ReadAll(req.Body)
		if err != nil {
			log.Fatalln(err)
		}

		var like UserLike
		json.Unmarshal(body, &like)
		c.Insert(like)
		
		var response Success
		response.Success = true
        
		formatter.JSON(w, http.StatusOK, response)
	}
}

// API Post AddCart Handler
func addCartHandler(formatter *render.Render) http.HandlerFunc {
	return func(w http.ResponseWriter, req *http.Request) {
		/**
			Mongo server setup
		**/
		session, err := mgo.Dial(mongodb_server)
        if err != nil {
                fmt.Println("mongoserver panic")
        }
        defer session.Close()
        session.SetMode(mgo.Monotonic, true)
        c := session.DB(mongodb_database).C("cart")
        
		/**
			Get Post body
		**/        
        body, err := ioutil.ReadAll(req.Body)
		if err != nil {
			log.Fatalln(err)
		}

		var cart Cart
		json.Unmarshal(body, &cart)
		c.Insert(cart)
		
		var response Success
		response.Success = true
        
		formatter.JSON(w, http.StatusOK, response)
	}
}

// API Post AddLike Handler 
func userLikeHandler(formatter *render.Render) http.HandlerFunc {
	return func(w http.ResponseWriter, req *http.Request) {
		/**
			Mongo server setup
		**/
		// session, err := mgo.Dial(mongodb_server)
  //       if err != nil {
  //               fmt.Println("mongoserver panic")
  //       }
  //       defer session.Close()
  //       session.SetMode(mgo.Monotonic, true)
  //       c := session.DB(mongodb_database).C("userLike")
		/**
			Get Post body
		**/        
        body, err := ioutil.ReadAll(req.Body)
		if err != nil {
			log.Fatalln(err)
		}
		fmt.Println(body)

		// var postResult PostContent
		// json.Unmarshal(body, &postResult)

		// /**
		// 	Hard code userid for testing
		// **/   
		// var userId = "888888"
		// var action = postResult.Action
		// var postId = postResult.Id

		// if action == "question" {
		// 	var question MUserQuestion
		// 	question.UserId = userId
		// 	question.Uquestions = postId 
		// 	uq.Insert(question)
		// }

		// if action == "answer" {
		// 	var answer MUserAnswer
		// 	answer.UserId = userId
		// 	answer.UAnswers = postId 
		// 	ua.Insert(answer)
		// }
		
		var response Success
		response.Success = true
        
		formatter.JSON(w, http.StatusOK, response)
	}
}

// API Post AddCart Handler
func userCartHandler(formatter *render.Render) http.HandlerFunc {
	return func(w http.ResponseWriter, req *http.Request) {
		/**
			Mongo server setup
		**/
		// session, err := mgo.Dial(mongodb_server)
  //       if err != nil {
  //               fmt.Println("mongoserver panic")
  //       }
  //       defer session.Close()
  //       session.SetMode(mgo.Monotonic, true)
  //       uq := session.DB(mongodb_database).C("uQuestion")
  //       ua := session.DB(mongodb_database).C("uAnswer")
		/**
			Get Post body
		**/        
        body, err := ioutil.ReadAll(req.Body)
		if err != nil {
			log.Fatalln(err)
		}
		fmt.Println(body)

		// var postResult PostContent
		// json.Unmarshal(body, &postResult)

		// /**
		// 	Hard code userid for testing
		// **/   
		// var userId = "888888"
		// var action = postResult.Action
		// var postId = postResult.Id

		// if action == "question" {
		// 	var question MUserQuestion
		// 	question.UserId = userId
		// 	question.Uquestions = postId 
		// 	uq.Insert(question)
		// }

		// if action == "answer" {
		// 	var answer MUserAnswer
		// 	answer.UserId = userId
		// 	answer.UAnswers = postId 
		// 	ua.Insert(answer)
		// }
		
		var response Success
		response.Success = true
        
		formatter.JSON(w, http.StatusOK, response)
	}
}



















