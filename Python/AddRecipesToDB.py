import firebase_admin
from firebase_admin import credentials, firestore
from bs4 import BeautifulSoup
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
import time

#Read file of recipe links
f = open('recipeLinks.txt', 'r')
recipeLinks = f.readlines()
f.close()

#Firestore database initalization
cred = credentials.Certificate("./recipeapp-144f5-firebase-adminsdk-50rmy-a53443deb1.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

for url in recipeLinks:
    browser = webdriver.Chrome('./chromedriver') 
    browser.get(url)
    time.sleep(5)
    soup = BeautifulSoup(browser.page_source, 'html.parser')
    browser.quit()

    #Find title
    title = (soup.findAll("a", class_="top-anchor"))[0].string
    #print(title)

    #Find picture URL
    pictureURL = (soup.findAll("img", class_="ba-picture--fit"))[0]['srcset'].split()[0]
    #Note - taking the smaller one, can come back and get the bigger 2x one if needed
    #print(pictureURL)

    #Find contributor
    contributor = ""
    try:
        contributor = (soup.findAll("span", class_="contributor-name"))[0].string
    except:
        print("No contributor")
    #print(contributor)

    #Find ingredients
    ingredients = soup.findAll("div", class_="ingredients__text")
    # ingredientsStrings = [x.string for x in ingredients]
    ingredientStrings = []
    for x in ingredients:
        if(x.string == None):
            ingredientStrings.append(x.contents[0].string + x.contents[1].string)
        else:
            ingredientStrings.append(x.string)
    # print(ingredientStrings)

    #Find steps
    steps = soup.findAll("li", class_="step")
    stepsStrings = [x.contents[0].contents[0].get_text() for x in steps]
    #print(stepsStrings)

    #Datachacks

    assert(title != None)
    assert(pictureURL != None)
    assert(contributor != None)
    assert(any(x is None for x in ingredientStrings)==False)
    assert(any(x is None for x in stepsStrings)==False)


    #Store to database
    new_recipe_ref = db.collection(u'recipes').document(title)
    new_recipe_ref.set({
        u'recipeURLString': url,
        u'imageURLString': pictureURL, 
        u'steps': stepsStrings, 
        u'ingredients': ingredientStrings, 
        u'title': title,
        u'contributor': contributor,
        u'publisher': "Bon Appetit"
    })
    print(f"Recipe: {title} stored!")
