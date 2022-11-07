#!/usr/bin/env python
# coding: utf-8

# In[1]:


import requests
import threading
import concurrent.futures
from concurrent.futures import ThreadPoolExecutor
import pandas as pd
import flask
from flask import Flask, request
import geopy
from geopy import Nominatim
from textblob import TextBlob
import pycountry


# In[2]:


key = 'fsq3gnjDKSAUpKDth6dQU0ed3dHa0oRXeGtqnX06ipZ1vgw='

# this method helps us get long and lat of certain city

def get_latlong(b):

    
    try:
    
        city = b

        geolocator = Nominatim(user_agent = 'Safra1')
    
        loc = geolocator.geocode(city)
         
        # by default
    except: return 'No results found' , f'{b}'
    
    return loc.latitude , loc.longitude


# In[3]:


# this is a test
# lat , long = get_latlong('jeddah')


# In[4]:


# lat , long


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
                else:
                    tlds.append('')

            # if not --> save translated description
            else:
                tlds.append(desc)
        except: tlds.append(desc)
        
    return tlds


# In[6]:


def translate2(array):
        
    # this list contains new translated descriptions
    tlds = []
    
    for desc in array:
        
        # Specifying the language for
        # detection
        # dbt : detection before translation
        dbt = detect(desc)

        # saving desc into text to translate
        if desc == 'Not Available':
            tlds.append('Not Available')
            
        elif desc != 'Not Available' and dbt != 'en':

            blob = TextBlob(desc)

            # tat : text after translation
            tat = blob.translate(from_lang = detect(desc) , to = 'en')

             # if description is already in english ---> save original description
            tlds.append(str(tat))
        
        elif dbt == 'en':
            tlds.append('Not Available')

        # if not --> save translated description
    return tlds


# In[7]:


def extract_categories(array):
    
    """
    array: array of categories
    
    array[0] = json structure
    
    so this method extract only name of category out of json
    """
#     templist = []
#     for element in array:
        
#         category = ''
#         if element != []:
#             index = 0
#             for inner_element in element:
#                 index+=1

#                 if index < len(element):
#                     category += inner_element['name']+','

#                 else:
#                     category += inner_element['name']
#             templist.append(category)
#         else:
#             category+= 'Not Available'
#             templist.append(category)
#     return templist
                

def extract_category(element):
    
    category = ''
    index = 0
    if len(element) > 0:
        for inner_element in element:

            if index < len(element)-1:
                category+= inner_element['name'] + '--'
                index+=1
            else:
                category+= inner_element['name']
                index+=1
    else: 
        category = 'Not Available'
        return category
    
    category.replace(',' , ' ')
    return category
        
        


# In[8]:


default = 'https://images.unsplash.com/photo-1517816743773-6e0fd518b4a6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2803&q=80,https://images.unsplash.com/photo-1614109355930-7640f99a50ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1335&q=80,https://images.unsplash.com/photo-1563589425593-c17204c56f56?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1288&q=80'
def add_photos(array):
    headers = {
            "accept": "application/json",
            "Authorization": "fsq3bR9nCSrR/WbzD82rlvh990Q70wuc8BuuRs0Ypm6fx+w="
                }
    # list of links
    lol = []
    for fsq_id in array:
        links = ''
        url = f"https://api.foursquare.com/v3/places/{fsq_id}/photos?limit=5&sort=POPULAR"
        
        index = 0
        response = ''
        try:
            response = requests.get(url, headers=headers).json()
        
        
            if response != []:
                for element in response:

                    if index < len(response):
                        links += response[index]['prefix']+'original'+response[index]['suffix']+','
                        index+=1
                    else:
                        links += response[index]['prefix']+'original'+response[index]['suffix']
                        index+=1
                lol.append(links)
            else:
                lol.append(default)
        except: lol.append(default)
    return lol


# In[9]:


default = 'https://images.unsplash.com/photo-1517816743773-6e0fd518b4a6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2803&q=80,https://images.unsplash.com/photo-1614109355930-7640f99a50ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1335&q=80,https://images.unsplash.com/photo-1563589425593-c17204c56f56?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1288&q=80'

def sub_addPhoto(fsq_id):
    links = ''
    headers = {
            "accept": "application/json",
            "Authorization": "fsq3bR9nCSrR/WbzD82rlvh990Q70wuc8BuuRs0Ypm6fx+w="
                }
    
    url = f"https://api.foursquare.com/v3/places/{fsq_id}/photos?limit=5&sort=POPULAR"
    index = 0
    try:
        response = requests.get(url, headers=headers).json()

        if response != []:

            for element in response:
                if index < len(response)-1:
                    links += response[index]['prefix']+'original'+response[index]['suffix']+','
                    index+=1
                else:
                    links += response[index]['prefix']+'original'+response[index]['suffix']
                    index+=1
            return links
    except: return default
    else:
        return default
            
        
        
    


# In[10]:


# def rename_countries(array):
#     temp = []
#     for index in array:
        
#         name = pycountry.countries.get(alpha_2 = index)
#         temp.append(name.name)
    
#     return temp

def rename_country(regex):
    
    
    index = pycountry.countries.get(alpha_2 = regex)
    
    
    return index.name
    
    


# In[11]:


def extract_tastes(l1):
    
    if len(l1) > 0 and l1 != 'Not Available':
        t = ''
        index = 0
        for taste in l1:
            
            if index < len(l1)-1:
                t+= taste+'--'
                index+=1
            else:
                t+= taste
                index+=1
        return t
    else:
        return 'Not Available'
    


# In[12]:


def sortType(s):
#     Relevance by default ---> Places api only accept full cap letters
# #     ['Relevance', 'Rating', 'Popularity']

    temp = 'RELEVANCE'
    if s == 'Relevance':
        temp = 'RELEVANCE'
    elif s == 'Popularity':
        temp = 'POPULARITY'
    elif s == 'Rating':
        temp = 'RATING'
    return temp

    


# In[16]:


def retrieve_places(a , c , s , min_price , max_price):

    """
    a : condition --- >  example : coffee , art gallery , etc ...
    c : city name
    """
    
    ## website, formatted address in location , tastes, features, 
    
    lat , long = get_latlong(c)
#     if type(lat) != str:
# #         &min_price={min_price}&max_price={max_price}&
#         if min_price == '0' and max_price == '5':
        
#             if a != '':
#                 fields_url = f"https://api.foursquare.com/v3/places/search?query={a}&ll={lat}%2C{long}&&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Ccategories%2Chours%2Ctastes&limit=15&sort={s}"

#             else:
#                 fields_url = f"https://api.foursquare.com/v3/places/search?ll={lat}%2C{long}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Chours%2Ccategories%2Ctastes&limit=15&sort={s}"
#         elif min_price !='0' and max_price == '5':
#             if a != '':
#                 fields_url = f"https://api.foursquare.com/v3/places/search?ll={lat}%2C{long}&query={a}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Chours%2Ccategories%2Ctastes&min_price={min_price}&limit=15&sort={s}"

#             else:
#                 fields_url = f"https://api.foursquare.com/v3/places/search?ll={lat}%2C{long}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Chours%2Ccategories%2Ctastes&min_price={min_price}&limit=15&sort={s}"
#         elif min_price == '0' and max_price !='5':
            
#             if a != '':
#                 fields_url = f"https://api.foursquare.com/v3/places/search?ll={lat}%2C{long}&query={a}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Ccategories%2Chours%2Ctastes&max_price={max_price}&limit=15&sort={s}"

#             else:
#                 fields_url = f"https://api.foursquare.com/v3/places/search?ll={lat}%2C{long}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Chours%2Ccategories%2Ctastes&max_price={max_price}&limit=15&sort={s}"
    
#         else:
#             if a != '':
#                 fields_url = f"https://api.foursquare.com/v3/places/search?ll={lat}%2C{long}&query={a}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Chours%2Ccategories%2Ctastes&min_price={min_price}&max_price={max_price}&limit=15&sort={s}"

#             else:
#                 fields_url = f"https://api.foursquare.com/v3/places/search?ll={lat}%2C{long}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Chours%2Ccategories%2Ctastes&min_price={min_price}&max_price={max_price}&limit=15&sort={s}"
    if lat != 'No results found':
        
        
        if min_price == '0' and max_price == '5':
        
            if a != '':
                fields_url = f"https://api.foursquare.com/v3/places/search?query={a}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Ccategories%2Chours%2Ctastes&limit=15&sort={s}&near={c}"

            else:
                fields_url = f"https://api.foursquare.com/v3/places/search?fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Chours%2Ccategories%2Ctastes&limit=15&sort={s}&near={c}"
        elif min_price !='0' and max_price == '5':
            if a != '':
                fields_url = f"https://api.foursquare.com/v3/places/search?query={a}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Chours%2Ccategories%2Ctastes&min_price={min_price}&limit=15&sort={s}&near={c}"

            else:
                fields_url = f"https://api.foursquare.com/v3/places/search?fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Chours%2Ccategories%2Ctastes&min_price={min_price}&limit=15&sort={s}&near={c}"
        elif min_price == '0' and max_price !='5':
            
            if a != '':
                fields_url = f"https://api.foursquare.com/v3/places/search?query={a}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Ccategories%2Chours%2Ctastes&max_price={max_price}&limit=15&sort={s}&near={c}"

            else:
                fields_url = f"https://api.foursquare.com/v3/places/search?fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Chours%2Ccategories%2Ctastes&max_price={max_price}&limit=15&sort={s}&near={c}"
    
        else:
            if a != '':
                fields_url = f"https://api.foursquare.com/v3/places/search?query={a}&fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Chours%2Ccategories%2Ctastes&min_price={min_price}&max_price={max_price}&limit=15&sort={s}&near={c}"

            else:
                fields_url = f"https://api.foursquare.com/v3/places/search?fields=fsq_id%2Cname%2Ctel%2Cprice%2Crating%2Cdescription%2Clocation%2Chours%2Ccategories%2Ctastes&min_price={min_price}&max_price={max_price}&limit=15&sort={s}&near={c}"
            

        url = fields_url

        headers = {
            "Accept": "application/json",
            "Authorization": key,
            "Accept-Language": 'en'
        }

        response = requests.get(url, headers=headers)
        

        data = response.json()

        df = pd.json_normalize(data['results'])

        #deleting unnecessary columns
    # tastes , website , hours
        try:
            df.drop(df.columns.difference(['fsq_id', 'name', 'price', 'rating', 'tel'
                                           ,'location.country', 'location.region',
                                           'location.formatted_address', 'hours.display','tastes'
                                           , 'description' , 'categories']),axis = 1,inplace=True)

        except: df = df
            
        
        
        """
        in this phase we add empty columns if columns are not available already
        
        ============== remember to change range when changing number of retrieved rows =======================
        """
        if 'price' not in df.columns:
            df.insert(len(df.columns) , 'price' , ['Not Available' for i in range(df.shape[0])] )
        
        if 'description' not in df.columns:
            df.insert(len(df.columns) , 'description' , ['Not Available' for i in range(df.shape[0])])
        
        if 'rating' not in df.columns:
            df.insert(len(df.columns) , 'rating' , ['Not Available' for i in range(df.shape[0])])

        
#         # renaming columns
        if 'location.country' in df.columns and 'location.region' in df.columns:
            df.rename(columns = {'location.country':'country' , 'location.region':'region'}, inplace = True)
            if 'location.formatted_address' in df.columns:
                df.rename(columns = {'location.formatted_address':'address'}, inplace = True)
        
        if 'hours.display' in df.columns:
            df.rename(columns = {'hours.display':'open_hours'} , inplace = True)

        

        
        # filling nan values

        df = df.fillna('Not Available')

        

        # translating process starts here
        # error handling
        if 'description' in df.columns:
            
            df['description'] = [i.replace(',' , '') for i in df['description']]
        
        if 'open_hours' in df.columns:
            
            df['open_hours'] = [i.replace(',' , '-') for i in df['open_hours']]
            df['open_hours'] = [i.replace(';' , '\n') for i in df['open_hours']]

        
        if 'address' in df.columns:
            
            df['address'] = [i.replace(',' , '-') for i in df['address']]
            # extracting
#             array = df['description'].to_list()

#             # tdl : translated descriptions list

#             """
#             in this line we call function to translate all descriptions as following

#             other than english ---> translate

#             Not Available ---> keep it as it is

#             english description ---> keep it as it's
#             """ 
            
#             tdl = translate2(array)

#             # insert it into last 
#             df.insert(df.columns.get_loc('description')+1  , 'translated_description' , tdl)

#         if 'name' in df.columns:
#             array_n = df['name'].to_list()
            
#             tnl = translate(array_n)
            
#             df.insert(df.columns.get_loc('name')+1 , 'translated_name' , tnl)

        
#         if 'region' in df.columns:
#             array_r = df['region'].to_list()
            
#             trl = translate(array_r)
            
#             df.insert(df.columns.get_loc('region')+1 , 'translated_region' , trl)
#         if 'country' in df.columns:
#             templist = df['country'].to_list()
#             templist = rename_countries(templist)
            
#             df.drop(['country'] , inplace = True , axis = 1)
#             df.insert(len(df.columns), 'country' , templist)
        
#         if 'categories' in df.columns:
#             templist = df['categories'].to_list()
#             templist = extract_categories(templist)
            
#             df.drop(['categories'] , inplace = True , axis = 1)
#             df.insert(len(df.columns), 'categories' , templist)
        
            
        try:
            # changing datatypes
            df = df.astype({'price': str , 'rating': str})
        except: df = df
        
        
        '''
        adding photos to dataframe 
        
        ==== i suggest to make this function separately rather th
        lol : ---> list of links
        '''
        if 'fsq_id' in df.columns:
            lol = []
            with ThreadPoolExecutor() as executor:
                results = executor.map(sub_addPhoto , df['fsq_id'].to_list())
                for result in results:
                    lol.append(result)
            df.insert(len(df.columns) , 'photo_url' , lol)
            
            
        if 'tastes' in df.columns:
            
            
            lol = []
            
            with ThreadPoolExecutor() as executor:
                results = executor.map(extract_tastes, df['tastes'].to_list())
                
                for result in results:
                    lol.append(result)
            
            df.drop(['tastes'] , inplace = True , axis = 1)

            df.insert(len(df.columns) , 'tastes' , lol)
        
        if 'country' in df.columns:


            lol = []

            with ThreadPoolExecutor() as executor:
                results = executor.map(rename_country, df['country'].to_list())

                for result in results:
                    lol.append(result)

            df.drop(['country'] , inplace = True , axis = 1)

            df.insert(len(df.columns) , 'country' , lol)
        
        if 'categories' in df.columns:
            
            
            lol = []
            with ThreadPoolExecutor() as executor:
                results = executor.map(extract_category, df['categories'].to_list())
                
                for result in results:
                    lol.append(result)
            
            df.drop(['categories'] , inplace = True , axis = 1)

            df.insert(len(df.columns) , 'categories' , lol)
        

        
        data = df.to_json(orient = 'records')
        return df, data
    else:
        return lat , long 
    


# In[17]:


'''

test field


'''


# In[21]:


# index , regex = retrieve_places('' , 'london' , 'Relevance' , '0' , '5' )


# In[22]:


# index


# In[17]:


app = Flask(__name__)


@app.route('/api' , methods = ['GET'])

def index():
    userInputa = str(request.args['query2'])
    userInputb = str(request.args['query1'])
    userInputc = str(request.args['sortby'])
    userInputd = str(request.args['min_price'])
    userInpute = str(request.args['max_price'])
    
#     if userInputb == '':
#         return regex
    sb = sortType(userInputc)
    df, data_json = retrieve_places(userInputa , userInputb , sb , userInputd , userInpute)
    
    
    return data_json



if __name__ == "__main__":
    app.run()


# In[ ]:




