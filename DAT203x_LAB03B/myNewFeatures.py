# -*- coding: utf-8 -*-
"""
Created on Sun Oct 18 21:46:09 2015

@author: tedscott
"""

# add new features to EE
def azureml_main(frame1):
    sqrList=["Relative Compactness","Surface Area","Wall Area"]
    sqredList = ["Relative Compactness Sqred", "Surface Area Sqred",
        "Wall Area Sqred"]
    frame1[sqredList]=frame1[sqrList]**2
    cubeList = ["Relative Compactness 3", "Surface Area 3",
        "Wall Area 3"]
    frame1[cubeList]=frame1[sqrList]**3

    # Return value must be of a sequence of pandas.DataFrame
    return frame1