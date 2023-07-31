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

import matplotlib.pyplot as plt

# Data
composers = ['Schubert', 'Ravel', 'Mozart', 'Haydn', 'Faure', 'Dvorak', 'Cambini', 'Brahm', 'Beethoven', 'Bach']
num_compositions = [30, 4, 24, 3, 4, 8, 9, 24, 157, 67]

# Sort the data in descending order based on the number of compositions
sorted_data = sorted(zip(num_compositions, composers), reverse=True)
num_compositions, composers = zip(*sorted_data)

# Create the histogram plot
plt.figure(figsize=(10, 6))
bars = plt.bar(composers, num_compositions, color='skyblue')

# Customize the plot
plt.xlabel('Composers')
plt.ylabel('Number of Compositions')
plt.title('Number of Compositions by Composer in MusicNet Dataset')
plt.xticks(rotation=45, ha='right')

# Annotate the plot with numbers above the bars
for bar, num in zip(bars, num_compositions):
    plt.text(bar.get_x() + bar.get_width() / 2, bar.get_height(), num, ha='center', va='bottom', fontsize=9)

# Show the plot
plt.tight_layout()
plt.savefig('plot_number_of_compositions.pdf')
plt.show()

