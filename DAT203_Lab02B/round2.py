# -*- coding: utf-8 -*-
"""
Created on Mon Oct  5 17:06:40 2015

@author: tedscott
"""

def round2(df):
    # take in a dataframe df and return values rounded to two decimal places
    import numpy as np
    return df.apply(lambda x: np.round(x,2))
    