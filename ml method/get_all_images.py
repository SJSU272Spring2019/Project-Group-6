import pandas as pd
from pandas import ExcelWriter
from pandas import ExcelFile


from PIL import Image
import requests
from io import BytesIO


 
df = pd.read_excel('/Users/jing/Downloads/00002_NEW IN_WOMAN_excel.xlsx', sheetname='Products')
print("Column headings:")

print(df['Urls to images (spaced)'][0].split()[0])
print(len(df['Urls to images (spaced)']))

d = df['Urls to images (spaced)']

all_urls = set()

for i in range(len(d)):
	url = d[i].split()[0]
	all_urls.add(url)


print(len(all_urls))
index = 0

for url in all_urls:
	print(index)
	response = requests.get(url)
	img = Image.open(BytesIO(response.content))
	img.save("/Users/jing/Desktop/images/" + str(index) + ".png", "png")
	index += 1

