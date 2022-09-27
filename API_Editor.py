#!/usr/bin/env python
# coding: utf-8

# In[1]:


import requests, json
import threading
import pandas as pd
import flask
from flask import Flask, request
import geopy
from geopy import Nominatim


# In[2]:


key = 'fsq3bR9nCSrR/WbzD82rlvh990Q70wuc8BuuRs0Ypm6fx+w='

# this method helps us get long and lat of certain city

def get_latlong(b):

    city = b

    geolocator = Nominatim(user_agent = 'Safra')

    loc = geolocator.geocode(city)

    return loc.latitude , loc.longitude


# In[3]:


# lat , long = get_latlong('egypt')
# lat , long


# In[4]:


def retrieve_places(a , c):

    """
    a : condition --- >  example : coffee , art gallery , etc ...
    c : city name
    
    """

    lat , long = get_latlong(c)


    if a != '':
        fields_url = f"https://api.foursquare.com/v3/places/search?ll={lat}%2C{long}&query={a}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation"

    else:
        fields_url = f"https://api.foursquare.com/v3/places/search?ll={lat}%2C{long}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation"


    url = fields_url

    headers = {
        "Accept": "application/json",
        "Authorization": key
    }

    response = requests.get(url, headers=headers)

    data = response.json()

    df = pd.json_normalize(data['results'])

    #deleting unnecessary columns
    
    df.drop(df.columns.difference(['fsq_id', 'name', 'price', 'rating', 'tel', 'location.country', 'location.region', 'description']),1,inplace=True)


    # renaming columns


    df.rename(columns = {'location.country':'country' , 'location.region':'region'}, inplace = True)

    

    # filling nan values

    df = df.fillna('Not Available')



    # changing datatypes
    df = df.astype({'price': str , 'rating': str})

    data = df.to_json(orient = 'records')
    return df , data


# In[5]:


df, data_json = retrieve_places('' , 'Cairo')
df


# In[ ]:




app = Flask(__name__)

@app.route('/api' , methods = ['GET'])

def index():
    userInputb = str(request.args['query'])
    df, data_json = retrieve_places('' , userInputb)

    return data_json




if __name__ == "__main__":
    app.run()


# In[ ]:




