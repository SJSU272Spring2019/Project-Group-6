/**
	Insert Data 
**/

/**  Model Table -- Store Formal model id (raceinfo) and clothes ids
**/
/** Deprecated
db.model.insert(
	{
		modelId: "ModelxFormal_164737949",
		clothesId: "H446634235"
	}
);
db.model.insert(
	{
		modelId: "ModelxFormal_164737949",
		clothesId: "H156322778"
	}
);
db.model.insert(
	{
		modelId: "ModelxFormal_164737949",
		clothesId: "HM284851890"
	}
);
db.model.insert(
	{
		modelId: "ModelxFormal_164737949",
		clothesId: "HM2019820449"
	}
);
**/
db.model.insert(
	{
		modelId: "ModelxFormal_164737949",
		clothesId: "H10785422"
	}
);
db.model.insert(
	{
		modelId: "ModelxFormal_164737949",
		clothesId: "H140634225"
	}
);
db.model.insert(
	{
		modelId: "ModelxFormal_164737949",
		clothesId: "H167374003"
	}
);
db.model.insert(
	{
		modelId: "ModelxFormal_164737949",
		clothesId: "H250470684"
	}
);
db.model.insert(
	{
		modelId: "ModelxFormal_164737949",
		clothesId: "H462883249"
	}
);
db.model.insert(
	{
		modelId: "ModelxFormal_164737949",
		clothesId: "H556199130"
	}
);

/**  Model Table -- Store Casual model id (raceinfo) and clothes ids
**/
db.model.insert(
	{
		modelId: "ModelxCasual_1981535576",
		clothesId: "H8645717"
	}
);
db.model.insert(
	{
		modelId: "ModelxCasual_1981535576",
		clothesId: "H48874151"
	}
);
db.model.insert(
	{
		modelId: "ModelxCasual_1981535576",
		clothesId: "H156322778"
	}
);
db.model.insert(
	{
		modelId: "ModelxCasual_1981535576",
		clothesId: "H361458554"
	}
);
db.model.insert(
	{
		modelId: "ModelxCasual_1981535576",
		clothesId: "H402037076"
	}
);
db.model.insert(
	{
		modelId: "ModelxCasual_1981535576",
		clothesId: "H449967941"
	}
);
db.model.insert(
	{
		modelId: "ModelxCasual_1981535576",
		clothesId: "HM2019820449"
	}
);
db.model.insert(
	{
		modelId: "ModelxCasual_1981535576",
		clothesId: "HM284851890"
	}
);
db.model.insert(
	{
		modelId: "ModelxCasual_1981535576",
		clothesId: "H446634235"
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
	    url: "https://static.zara.net/photos///2018/I/0/1/p/9598/139/401/3/w/2048/9598139401_1_1_1.jpg?ts=1538652771990",
		price: "49.00"
	}
);
db.cloth.insert(	
	{
		clothesId: "H156322778",
		name: "QUILTED PARKA WITH HOOD",
		description: "High neck parka with hood and detachable contrast faux fur trim. Featuring long sleeves, ribbed inner cuffs, front welt pockets with snap buttons and zip pockets.",
		url: "https://static.zara.net/photos///2018/I/0/1/p/3305/240/505/3/w/2048/3305240505_1_1_1.jpg?ts=1538655870099",
		price: "99.00"
	}
);
db.cloth.insert(
	{
		clothesId: "HM284851890",
		name: "PRINTED MIDI DRESS",
		description: "Flowing round neck dress with a front slit. Featuring a relaxed A-line silhouette, long sleeves, gathered seam at the waist and button fastening on the front.",
		url: "https://static.zara.net/photos///2018/I/0/1/p/8179/741/621/2/w/1024/8179741621_1_1_1.jpg?ts=1538500438348",
		price: "74.00"
	}
);
db.cloth.insert(
	{
		clothesId: "HM2019820449",
		name: "PATCHWORK PRINT SHIRT",
		description: "Flowing collared shirt with long sleeves. Featuring a chest patch pocket, an asymmetric hem and a button-up front. ",
		url: "https://static.zara.net/photos///2018/I/0/1/p/6895/274/330/2/w/1024/6895274330_1_1_1.jpg?ts=1538496437770",
		price: "62.00"
	}
);
db.cloth.insert(
	{
		clothesId: "HM1787836479",
		name: "FLORAL PRINT BLOUSE",
		description: "Blouse with a smocked elastic high neck and yoke. Featuring long cuffed sleeves, a relaxed A-line silhouette with gathered details, and a buttoned opening in the back.",
		url: "https://static.zara.net/photos///2018/I/0/1/p/8147/673/712/2/w/1024/8147673712_1_1_1.jpg?ts=1538500376801",
		price: "62.00"
	}
);
/** Insert new cloth data
**/
db.cloth.insert(
	{
		clothesId: "H10785422",
		name: "ANIMAL PRINT ASYMMETRIC SHIRT",
		description: "",
	    url: "https://static.zara.net/photos///2018/I/0/1/p/9878/168/075/2/w/2048/9878168075_1_1_1.jpg?ts=1538124799018",
		price: "37.00"
	}
);

db.cloth.insert(
	{
		clothesId: "H140634225",
		name: "TWEED BLAZER WITH BUTTONS",
		description: "",
	    url: "https://static.zara.net/photos///2018/I/0/1/p/7700/679/800/2/w/2048/7700679800_1_1_1.jpg?ts=1538588516158",
		price: "99.00"
	}
);

db.cloth.insert(
	{
		clothesId: "H167374003",
		name: "TROUSERS WITH BELT",
		description: "",
	    url: "https://static.zara.net/photos///2018/I/0/1/p/8372/255/800/2/w/2048/8372255800_1_1_1.jpg?ts=1538557054398",
		price: "37.00"
	}
);

db.cloth.insert(
	{
		clothesId: "H250470684",
		name: "BELTED SKIRT WITH CONTRAST TOPSTITCHING",
		description: "",
	    url: "https://static.zara.net/photos///2018/I/0/1/p/1971/173/401/3/w/2048/1971173401_1_1_1.jpg?ts=1538128778612",
		price: "37.75"
	}
);

db.cloth.insert(
	{
		clothesId: "H462883249",
		name: "DRESS WITH ANIMAL PRINT PIPED SEAMS",
		description: "",
	    url: "https://static.zara.net/photos///2018/I/0/1/p/9878/171/800/2/w/2048/9878171800_1_1_1.jpg?ts=1538124883790",
		price: "49.93"
	}
);

db.cloth.insert(
	{
		clothesId: "H556199130",
		name: "SOFT-TOUCH HOUNDSTOOTH TROUSERS",
		description: "",
	    url: "https://static.zara.net/photos///2018/I/0/1/p/8372/264/084/2/w/2048/8372264084_1_1_1.jpg?ts=1538669272438",
		price: "37.75"
	}
);

db.cloth.insert(
	{
		clothesId: "H8645717",
		name: "TURTLENECK SWEATER",
		description: "",
	    url: "https://static.zara.net/photos///2018/I/0/1/p/1509/113/800/2/w/2048/1509113800_1_1_1.jpg?ts=1537957408304",
		price: "32.43"
	}
);

db.cloth.insert(
	{
		clothesId: "H48874151",
		name: "ROUND NECK CASHMERE SWEATER",
		description: "",
	    url: "https://static.zara.net/photos///2018/I/0/1/p/5536/128/811/2/w/2048/5536128811_1_1_1.jpg?ts=1537953066049",
		price: "124.93"
	}
);

db.cloth.insert(
	{
		clothesId: "H361458554",
		name: "LIMITED EDITION CABLE-KNIT SWEATER",
		description: "",
	    url: "https://static.zara.net/photos///2018/I/0/1/p/2488/106/305/2/w/2048/2488106305_1_1_1.jpg?ts=1538481867765",
		price: "74.93"
	}
);
db.cloth.insert(
	{
		clothesId: "H402037076",
		name: "SOFT-TOUCH T-SHIRT",
		description: "",
	    url: "https://static.zara.net/photos///2018/I/0/1/p/1165/675/500/2/w/2048/1165675500_1_1_1.jpg?ts=1538129610243",
		price: "24.93"
	}
);
db.cloth.insert(
	{
		clothesId: "H449967941",
		name: "SOFT-FEEL SWEATER",
		description: "",
	    url: "https://static.zara.net/photos///2018/I/0/1/p/6254/200/800/2/w/2048/6254200800_1_1_1.jpg?ts=1535654609147",
		price: "24.93"
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