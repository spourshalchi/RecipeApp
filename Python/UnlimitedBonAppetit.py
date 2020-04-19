import time
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from bs4 import BeautifulSoup
import os

#Load website
print("Begin")
browser = webdriver.Chrome('./chromedriver') 
browser.get('https://www.bonappetit.com/recipes')
time.sleep(15)



#Click get more recipes
numIterations = 23
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
for tag in soup.find("ul", class_="cards"):
  if(tag.contents[0]['class'][0]=='card'):
    a = (tag.contents[0].contents[0].contents[0].contents[0]['href'])

    link = "http://bonappetit.com/" + a
    print(link)
