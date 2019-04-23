package main


type Predict struct {
	Class	    string   `json:"class"` 
	Score		string   `json:"score"` 
}

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

type Clothes struct {
	ClothesUrl		string  `json:"clothUrl"`
}