/**
	Insert Data 
**/

/**  Model Table -- Store model id (raceinfo) and clothes ids
**/

db.model.insert(
	{
		modelId: "asain",
		clothesId: "H446634235"
	}
);

/**  Cloth Table -- Store cloth id (raceinfo) and clothes name, description, 
	 price
**/
db.cloth.insert(
	{
		clothesId: "H446634235",
		name: "",
		description: "",
		price: ""
	}
);

/**  Score Table -- Store cloth id (raceinfo) and clothes score
**/
db.score.insert(
	{
		clothesId: "H446634235",
		score: ""
	}
);

/**  Like Table -- Store user id (raceinfo) and clothes id
**/
db.userLike.insert(
	{
		userId: ""
		clothesId: "H446634235"	
	}
);

/**  Like Table -- Store user id (raceinfo) and clothes id
**/
db.cart.insert(
	{
		userId: ""
		clothesId: "H446634235"	
	}
);