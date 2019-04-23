/**
	Insert Data 
**/

/**  Model Table -- Store model id (raceinfo) and clothes ids
**/

db.model.insert(
	{
		modelId: "asain",
		clothesId: "H446634235"
	},

	{
		modelId: "asain",
		clothesId: "H156322778"
	},

	{
		modelId: "asain",
		clothesId: "HM284851890"
	},

	{
		modelId: "asain",
		clothesId: "HM2019820449"
	}

);

/**  Cloth Table -- Store cloth id (raceinfo) and clothes name, description, 
	 price
**/
db.cloth.insert(
	{
		clothesId: "H446634235",
		name: "SEQUINNED SWEATER",
		description: "Knit sweater with a round neckline, long sleeves and ribbed trims.",
	    url: "https://static.zara.net/photos///2018/I/0/1/p/9598/139/401/3/w/2048/9598139401_1_1_1.jpg?ts=1538652771990"
		price: "49.00"
	},

	{
		clothesId: "H156322778",
		name: "QUILTED PARKA WITH HOOD",
		description: "High neck parka with hood and detachable contrast faux fur trim. Featuring long sleeves, ribbed inner cuffs, front welt pockets with snap buttons and zip pockets.",
		url: "https://static.zara.net/photos///2018/I/0/1/p/3305/240/505/3/w/2048/3305240505_1_1_1.jpg?ts=1538655870099"
		price: "99.00"
	},

	{
		clothesId: "HM284851890",
		name: "PRINTED MIDI DRESS",
		description: "Flowing round neck dress with a front slit. Featuring a relaxed A-line silhouette, long sleeves, gathered seam at the waist and button fastening on the front.",
		url: "https://static.zara.net/photos///2018/I/0/1/p/8179/741/621/2/w/1024/8179741621_1_1_1.jpg?ts=1538500438348"
		price: "74.00"
	},

	{
		clothesId: "HM2019820449",
		name: "PATCHWORK PRINT SHIRT",
		description: "Flowing collared shirt with long sleeves. Featuring a chest patch pocket, an asymmetric hem and a button-up front. ",
		url: "https://static.zara.net/photos///2018/I/0/1/p/6895/274/330/2/w/1024/6895274330_1_1_1.jpg?ts=1538496437770"
		price: "62.00"
	},

	{
		clothesId: "HM1787836479",
		name: "FLORAL PRINT BLOUSE",
		description: "Blouse with a smocked elastic high neck and yoke. Featuring long cuffed sleeves, a relaxed A-line silhouette with gathered details, and a buttoned opening in the back.",
		url: "https://static.zara.net/photos///2018/I/0/1/p/8147/673/712/2/w/1024/8147673712_1_1_1.jpg?ts=1538500376801"
		price: "62.00"
	}
);

/**  Score Table -- Store cloth id (raceinfo) and clothes score
**/
db.score.insert(
	{
		clothesId: "123",
		score: "0.026"
	}
);

/**  Like Table -- Store user id (raceinfo) and clothes id
**/
db.userLike.insert(
	{
		userId: "123"
		clothesId: "123"	
	}
);

/**  Cart Table -- Store user id (raceinfo) and clothes id
**/
db.cart.insert(
	{
		userId: "123"
		clothesId: "123"	
	}
);