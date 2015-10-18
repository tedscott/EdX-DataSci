# -*- coding: utf-8 -*-
"""
Created on Sat Oct 17 18:54:54 2015

@author: tedscott
"""

# do some visualizing of the energy efficiency data
import matplotlib
matplotlib.use("agg") # set backend - why do we do this?

from pandas.tools.plotting import scatter_matrix
import pandas.tools.rplot as rplot
import matplotlib.pyplot as plt
import numpy as np

# create a pair-wie scatter-plot

Azure = False
## if in Azure, frame1 is passed to function
if(Azure==False):
    frame1=eeframe
    
fig1=plt.figure(1,figsize=(10,10))
ax=fig1.gca()
scatter_matrix(frame1,alpha=0.3,diagonal='kde',ax=ax)
plt.show()
if(Azure==True): fig1.savefig("scatter1.png")

# create conditioned scatter plots
col_list = ["Relative Compactness","Surface Area",
               "Wall Area", "Roof Area","Glazing Area",
               "Glazing Area Distribution"]