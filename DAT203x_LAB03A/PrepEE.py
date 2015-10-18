# -*- coding: utf-8 -*-
"""
Created on Sat Oct 17 18:54:10 2015

@author: tedscott
"""

# visualization of the energy efficiency data set
def azureml_main(frame1):
    # load the data
    import pandas as pd
    import os
    from sklearn import preprocessing
    
    pathName = "c:/git/EdX-DataSci/DAT203x_LAB03A/"
    fileName ="EnergyEfficiencyRegressiondata.csv"
    filePath=os.path.join(pathName,fileName)
    eeframe=pd.read_csv(filePath)
    
    # remove columns we're not going to use (CoolingLoad and HeatingLoad are correlated)
    eeframe=eeframe.drop("Cooling Load",1)
    
    # scale numeric features
    scaleList=["Relative Compactness","Surface Area",
               "Wall Area", "Roof Area","Glazing Area",
               "Glazing Area Distribution"]
    arry = eeframe[scaleList].as_matrix()
    eeframe[scaleList]=preprocessing.scale(arry)