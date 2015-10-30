# -*- coding: utf-8 -*-
"""
Created on Tue Oct 27 12:13:08 2015

@author: tedscott
"""

import urllib
# If you are using Python 3+, import urllib instead of urllib2

import json 


data =  {

        "Inputs": {

                "input1":
                {
                    "ColumnNames": ["Relative Compactness", "Surface Area", "Wall Area", "Roof Area", "Overall Height", "Orientation", "Glazing Area", "Glazing Area Distribution", "Heating Load", "Cooling Load"],
                    "Values": [ [ "0", "0", "0", "0", "0", "0", "0", "0", "0", "0" ], [ "0", "0", "0", "0", "0", "0", "0", "0", "0", "0" ], ]
                },        },
            "GlobalParameters": {
            }
    }

body = str.encode(json.dumps(data))

url = 'https://ussouthcentral.services.azureml.net/workspaces/23b9610d5eaf4025811841f4755a738c/services/203ac6065f3b4023a5294359d7133836/execute?api-version=2.0&details=true'
api_key = '3oKiDkf7zjOeHJJDmEgApIi6B9gb9uEC14Qs4lRLEzhDrj25y2Hb2Oeu6TIFZWwN09d0qwhMi3cxwws2RSx37w==' # Replace this with the API key for the web service
headers = {'Content-Type':'application/json', 'Authorization':('Bearer '+ api_key)}

req = urllib.request.Request(url, body, headers) 

try:
    response = urllib.request.urlopen(req)

    # If you are using Python 3+, replace urllib2 with urllib.request in the above code:
    # req = urllib.request.Request(url, body, headers) 
    # response = urllib.request.urlopen(req)

    result = response.read()
    print(result) 
except urllib.error.HTTPError as err:
    print("The request failed with status code: " + str(err.code))

    # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
    print(err.info())

    print(json.loads(err.read()))                 