import os
import firebase_admin
from firebase_admin import credentials, firestore
from bs4 import BeautifulSoup
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
import time
from datetime import datetime

def getBARecipeLinks():
    #Load website
    # print("Begin")
    browser = webdriver.Chrome('./chromedriver') 
    browser.get('https://www.bonappetit.com/recipes')
    time.sleep(15)

    #Click get more recipes
    numIterations = 1
    #Note saw this fail at 23 once, not sure if thats a constant or what
    for x in range(numIterations):
        #Try and get rid of popup
        try:
            element = browser.find_element_by_xpath('//*[@id="bx-element-1032221-80g5faK"]/button')
            element.click()
            time.sleep(3)
        except:
            print("No popup")
            
        print(f"Loading more recipes iteration {x} out of {numIterations}")
        element2 = browser.find_element_by_xpath('//*[@id="react-app"]/div/div/div[2]/div[1]/div/div/button')
        element2.click()
        time.sleep(3)

    #Get HTML 
    soup = BeautifulSoup(browser.page_source, 'html.parser')
    browser.quit()

    #Find and print recipes from the html
    links = []
    for tag in soup.find("ul", class_="cards"):
        if(tag.contents[0]['class'][0]=='card'):
            a = (tag.contents[0].contents[0].contents[0].contents[0]['href'])

            link = "http://bonappetit.com/" + a
            links.append(link)

    #Write to file
    file1 = open("recipeLinks.txt","w") 
    file1.writelines("%s\n" % l for l in links)
    file1.close()

def addBARecipesToDB():
        ##Add recipes to database
    #Read file of recipe links
    f = open('recipeLinks.txt', 'r')
    recipeLinks = f.readlines()
    f.close()

    #Firestore database initalization
    cred = credentials.Certificate("./recipeapp-144f5-firebase-adminsdk-50rmy-c7ebd65f01.json")
    firebase_admin.initialize_app(cred)
    db = firestore.client()

    #Track number of new recipes added
    numNewRecipes = 0

    for url in recipeLinks:
        #Check if already in the databse
        results = db.collection(u'recipes').where(u'recipeURLString', u'==', url).stream()
        _exhausted = object()
        if (not (next(results, _exhausted) is _exhausted)):
            # print(f"Skipping: {url}")
            continue

        #Set up webscraper
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

        #Find yield
        yieldText = (soup.findAll("span", class_="recipe__header__servings recipe__header__servings--basically"))[0].string
        if "empty" in yieldText:
            yieldText = ""
        # print(yieldText)
        
        #Find time to make
        #None for bon appetit
        timeToMake = ""

        #Datachacks
        assert(title != None)
        assert(pictureURL != None)
        assert(contributor != None)
        assert(any(x is None for x in ingredientStrings)==False)
        assert(any(x is None for x in stepsStrings)==False)
        assert(yieldText != None)
        assert(timeToMake != None)

        #Store to database
        new_recipe_ref = db.collection(u'recipes').document()
        new_recipe_ref.set({
            u'recipeURLString': url,
            u'imageURLString': pictureURL, 
            u'steps': stepsStrings, 
            u'ingredients': ingredientStrings, 
            u'title': title,
            u'contributor': contributor,
            u'publisher': "Bon Appetit",
            'created': firestore.firestore.SERVER_TIMESTAMP,
            u'yieldText': yieldText,
            u'timeToMake': timeToMake,
            u'avgRating': 0,
            u'numRatings': 0
        })
        # print(f"Recipe: {title} stored!")

        numNewRecipes += 1

    #Log new recipes 
    now = datetime.now()
    dt_string = now.strftime("%m/%d/%Y %H:%M:%S")
    log = f"{dt_string} {numNewRecipes} new recipes added\n"
    with open('NumNewRecipesLog.txt', 'a') as file:
        file.write(log)
    # print(log)

if __name__ == "__main__":
    # getBARecipeLinks()
    addBARecipesToDB()
    