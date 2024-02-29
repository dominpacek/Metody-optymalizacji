import csv
from matplotlib import pyplot as plt
import numpy as np

# Wczytaj dane z pliku CSV
dataPoints = []
with open('data.csv', mode='r') as file:
    csvFile = csv.reader(file)
    for line in csvFile:
        dataPoints.append((float(line[0]), float(line[1])))

x, y = zip(*dataPoints)

coefficients = np.polyfit(x, y, 1)

a_optimal = coefficients[0]
b_optimal = coefficients[1]

print(f'Optymalne parametry prostej: a = {a_optimal}, b = {b_optimal}')

fig, ax = plt.subplots()
ax.plot(x, y, 'o', markersize=1.5, label='Punkty ze zbioru danych')
ax.plot(x, a_optimal * np.array(x) + b_optimal, label='Dopasowana prosta')
ax.set(xticks=np.arange(x[0], x[-1], 5),
       xlim=(x[0], x[-1]))
ax.legend()
plt.show()
