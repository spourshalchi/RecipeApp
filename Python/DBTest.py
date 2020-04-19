
import firebase_admin
from firebase_admin import credentials, firestore
from bs4 import BeautifulSoup
import requests
import urllib.request

#Firestore database initalization
cred = credentials.Certificate("./recipeapp-144f5-firebase-adminsdk-50rmy-a53443deb1.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

#Print a recipe from the db
doc_ref = db.collection(u'recipes').document(u'9yqc4egj8UQ4LqDYQJvI')
try:
    doc = doc_ref.get()
    print(u'Document data: {}'.format(doc.to_dict()))
except:
  print("An exception occurred")
print("")

#Store a recipe to databse
doc_ref = db.collection(u'recipes').document(u'test')
doc_ref.set({
    u'recipeURLString': u'https://www.bonappetit.com/recipe/escarole-caesar-with-sardines-and-hazelnuts',
    u'imageURLString': u'https://assets.bonappetit.com/photos/5e5e921c58c694000852fc4a/16:9/w_5120,c_limit/Escarole-Caesar-lede.jpg', 
    u'steps': [u'step 1', u'step 2'], 
    u'ingredients': [u'apple', u'lettuce'], 
    u'title': u'Escarole Caesar With Sardines and Hazelnuts'
})
print("Recipe stored!")


##Web scraping
#https://www.bonappetit.com/recipes


#Print the recipe from the db
url = 'https://www.bonappetit.com/recipes'
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

tags = soup.find("ul", class_="cards")
print(tags.contents[0].contents[0].contents[0].contents[0].contents[0]['href'])
print()

for tag in tags:
  if(tag.contents[0]['class'][0]=='card'):
    a = (tag.contents[0].contents[0].contents[0].contents[0]['href'])

    link = "bonappetit.com/" + a
    print(link)