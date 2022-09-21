

import requests , json
import threading
import pandas as pd
import flask
from flask import Flask
import geopy
from geopy import Nominatim




key = 'fsq3bR9nCSrR/WbzD82rlvh990Q70wuc8BuuRs0Ypm6fx+w='

# this method helps us get long and lat of certain city

def get_latlong(a , b):

    country = a
    city = b

    geolocator = Nominatim(user_agent = 'Safra')

    loc = geolocator.geocode(city+','+country)

    return loc.latitude , loc.longitude





lat , long = get_latlong('Saudi Arabia' , 'Riyadh')



def retrieve_places(a , b , c):

    """
    a : condition --- >  example : coffee , art gallery , etc ...
    b : country name
    c : city name
    """

    lat , long = get_latlong(b , c)


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
    df.drop(['location.address','location.cross_street','location.formatted_address' , 'location.postcode','location.locality']
            ,
            axis = 1 , inplace = True)



    # renaming columns


    df.rename(columns = {'location.country':'country' , 'location.region':'region'}, inplace = True)



    # filling nan values

    df = df.fillna('n/a')



    # changing datatypes
    df = df.astype({'price': str , 'rating': str})

    data = df.to_json(orient = 'records')
    return df , data













df , data_json = retrieve_places('' , 'Saudi Arabia' , 'Riyadh')





app = Flask(__name__)

@app.route('/' , methods = ['GET'])

def index():
    return data_json




if __name__ == "__main__":
    app.run()