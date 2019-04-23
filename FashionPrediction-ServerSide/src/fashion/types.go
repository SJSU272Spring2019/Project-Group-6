package main

/**
	response struct
**/
type Predict struct {
    ClothId   string     `json:"clothId" bson:"clothId"`
    Url       string     `json:"url" bson:"url"`
    Name      string     `json:"name" bson:"name"`
    Price        string  `json:"price" bson:"price"`
	Score		string   `json:"score" bson:"score"`
}
/** Deprecated
type Result struct {
	CustomClass		int  `json:"custom_classes"` 
	ProcessImage	int	 `json:"images_processed"` 
	Images			Images `json:"images"`
}

type Images struct {
	ImageName		string	`json:"image"`
	Classify		Classify	`json:"classifiers"`
}

type Classify struct {
	Name           string   `json:"name"`
	Id             string   `json:"classifier_id"`
	ClassResult    Predict  `json:"classes"`
}

type ClassResult struct {
	Class	    string   `json:"class"` 
	Score		float64   `json:"score"`      
}
**/

type Race struct {
	Race		string  `json:"race"`
}

/**
	post struct
**/
type ClothPostId struct {
	ClothId   string     `json:"clothId" bson:"clothId"`
}

/**
	mongo db struct
**/
// Model Table
type Model struct {
	ModelId    string    `json:"modelId" bson:"modelId"`
	ClothId   string     `json:"clothId" bson:"clothId"`
}
// Clothes Table
type ClothInfo struct {
	ClothId   string     `json:"clothId" bson:"clothId"`
	Name      string     `json:"name" bson:"name"`
	Url       string     `json:"url" bson:"url"`
	Description  string  `json:"description" bson:"description"`
	Price        string  `json:"price" bson:"price"`
}
// Score Table
type Score struct {
	Id 		string     `json:"id" bson:"id"`
	Score   string     `json:"score" bson:"score"`
} 
// Like Table
type UserLike struct {
	Id 		  string     `json:"id" bson:"id"`
	ClothId   string     `json:"clothId" bson:"clothId"`
}

// Cart Table
type Cart struct {
	Id 		  string     `json:"id" bson:"id"`
	ClothId   string     `json:"clothId" bson:"clothId"`
}

type Success struct {
	Success		 bool	`json:"success" bson:"success"`
}





