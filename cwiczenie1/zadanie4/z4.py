import csv
from matplotlib import pyplot as plt
import numpy as np

dataPoints = []
with open('data.csv', mode='r') as file:
    csvFile = csv.reader(file)

    for line in csvFile:
        dataPoints.append((float(line[0]), float(line[1])))

x, y = zip(*dataPoints)

fig, ax = plt.subplots()
ax.plot(x, y, 'o', markersize=1.5, label='Punkty ze zbioru danych')
ax.set(xticks=np.arange(x[0], x[-1], 5),
       xlim=(x[0], x[-1]))
ax.legend()
plt.show()
