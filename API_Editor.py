#!/usr/bin/env python
# coding: utf-8

# In[1]:


import requests
import threading
import pandas as pd
import flask
from flask import Flask, request
import geopy
from geopy import Nominatim
from translate import Translator
from langdetect import detect
from iso639 import languages
from textblob import TextBlob


# In[2]:


key = 'fsq3bR9nCSrR/WbzD82rlvh990Q70wuc8BuuRs0Ypm6fx+w='

# this method helps us get long and lat of certain city

def get_latlong(b):

    
    try:
    
        city = b

        geolocator = Nominatim(user_agent = 'Safra')
    
        loc = geolocator.geocode(city)
         
        # by default
    except: return 'No results found' , f'{b}'
    
    return loc.latitude , loc.longitude


# In[3]:


# this is a test
lat , long = get_latlong('jeddah')


# In[4]:


lat , long


# In[5]:


def translate(array):
        
    # this list contains new translated descriptions
    tlds = []
    
    for desc in array:
        try:
            # Specifying the language for
            # detection
            # dbt : detection before translation
            dbt = detect(desc)

            # saving desc into text to translate
            if desc != 'Not Available':
                text = desc

                blob = TextBlob(text)

                # tat : text after translation
                tat = blob.translate(from_lang = detect(desc) , to = 'en')
                 # if description is already in english ---> save original description
                if dbt != 'en':
                    tlds.append(str(tat))

            # if not --> save translated description
            else:
                tlds.append(desc)
        except: tlds.append(desc)
        
    return tlds


# In[6]:


def extract_categories(array):
    templist = [array[i][0]['name'] for i in range(len(array))]
    
    return templist
    


# In[7]:


def add_photos(array):
    
    return


# In[8]:


def retrieve_places(a , c):

    """
    a : condition --- >  example : coffee , art gallery , etc ...
    c : city name
    """
    
    
    lat , long = get_latlong(c)
    if type(lat) != str:

        if a != '':
            fields_url = f"https://api.foursquare.com/v3/places/search?ll={lat}%2C{long}&query={a}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Ccategories%2Cphotos"

        else:
            fields_url = f"https://api.foursquare.com/v3/places/search?ll={lat}%2C{long}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Ccategories%2Cphotos"


        url = fields_url

        headers = {
            "Accept": "application/json",
            "Authorization": key
        }

        response = requests.get(url, headers=headers)

        data = response.json()

        df = pd.json_normalize(data['results'])

        #deleting unnecessary columns

        try:
            df.drop(df.columns.difference(['fsq_id', 'name', 'price', 'rating', 'tel'
                                           ,'location.country', 'location.region'
                                           , 'description' , 'categories']),1,inplace=True)

        except: df = df
            
        
        
        """
        in this phase we add empty columns if columns are not available already
        
        ============== remember to change range when changing number of retrieved rows ==============
        """
        if 'price' not in df.columns:
            df.insert(len(df.columns) , 'price' , ['Not Available' for i in range(10)] )
        
        if 'description' not in df.columns:
            df.insert(len(df.columns) , 'description' , ['Not Available' for i in range(10)])
        
        if 'rating' not in df.columns:
            df.insert(len(df.columns) , 'rating' , ['Not Available' for i in range(10)])

        
#         # renaming columns
        if 'location.country' in df.columns and 'location.region' in df.columns:
            df.rename(columns = {'location.country':'country' , 'location.region':'region'}, inplace = True)
    
        


        # filling nan values

        df = df.fillna('Not Available')


        # translating process starts here
        # error handling
        if 'description' in df.columns:

            # extracting
            array = df['description'].to_list()

            # tdl : translated descriptions list

            """
            in this line we call function to translate all descriptions as following

            other than english ---> translate

            Not Available ---> keep it as it is

            english description ---> keep it as it's
            """ 
            
            tdl = translate(array)

            # insert it into last 
            df.insert(df.columns.get_loc('description')+1  , 'translated_description' , tdl)

        
        
        if 'region' in df.columns:
            array_r = df['region'].to_list()
            
            trl = translate(array_r)
            
            df.insert(df.columns.get_loc('region')+1 , 'translated_region' , trl)

        if 'categories' in df.columns:
            templist = df['categories'].to_list()
            templist = extract_categories(templist)
            
            df.drop(['categories'] , inplace = True , axis = 1)
            df.insert(len(df) , 'categories' , templist)
            
        try:
            # changing datatypes
            df = df.astype({'price': str , 'rating': str})
        except: df = df


        data = df.to_json(orient = 'records')
        return df , data
    else:
        return lat , long 
    


# In[ ]:





# In[9]:


'''

test field


'''


# In[10]:


df, data_json = retrieve_places('coffee' , 'riyadh')
df


# In[13]:


app = Flask(__name__)


@app.route('/api' , methods = ['GET'])

def index():
    userInputb = str(request.args['query'])
    userInputa = str(request.args['query'])
    df, data_json = retrieve_places(userInputa , userInputb)

    return data_json


if __name__ == "__main__":
    app.run()


# In[ ]:




