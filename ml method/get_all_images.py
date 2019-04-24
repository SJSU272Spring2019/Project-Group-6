import pandas as pd
from pandas import ExcelWriter
from pandas import ExcelFile


from PIL import Image
import requests
from io import BytesIO


 
df = pd.read_excel('/Users/jing/Downloads/00002_NEW IN_WOMAN_excel.xlsx', sheetname='Products')
print("Column headings:")


print(len(df['Urls to images (spaced)']))

images = df['Urls to images (spaced)']
sku = df['Sku']

print(len(images))
print(len(sku))


for i in range(len(images)):
	url = images[i].split()[0]
	name = sku[i]
	print(i, name, url)
	
	response = requests.get(url)
	img = Image.open(BytesIO(response.content))
	img.save("/Users/jing/Desktop/skuimages/" + name + ".png", "png")


