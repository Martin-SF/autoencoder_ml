# %%

import numpy as np
import matplotlib.pyplot as plt
import os
import random
import itertools
import json
import csv
from tqdm import tqdm
from scipy.io import wavfile
#%%

json_file = 'output/Versuch1_11.07.2023/hyperparamsearch/searchResults.json'

with open(json_file, 'r') as file:
    search_results = json.load(file)

parSet_sum = {}
for item in search_results:
    numDense = item['numDense']
    numConv = item['numConv']
    numConvLayer = item['numConvLayer']
    best_val_si_snr = item['best_val_si_snr']

    key = (numDense, numConv, numConvLayer)
    if key in parSet_sum:
       parSet_sum[key] += best_val_si_snr
    else:
        parSet_sum[key] = best_val_si_snr

keys = [k for k in parSet_sum.keys()]
si_snr_sum = [parSet_sum[k] for k in keys]
bestParSet = keys[np.argmax(si_snr_sum)]
print(f'best set : {bestParSet}')