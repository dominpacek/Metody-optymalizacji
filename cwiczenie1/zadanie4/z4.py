# Ćwiczenie 1 zadanie 4
# Nina Łabęcka 311339 grupa czwartek 14:15
# Dominika Pacek 311378 grupa czwartek 18:15

import csv
from matplotlib import pyplot as plt
import numpy as np
import cvxpy as cp
import scipy as sp

# Wczytaj dane z pliku CSV
datapoints = []
with open('data.csv', mode='r') as file:
    csvFile = csv.reader(file)
    for line in csvFile:
        datapoints.append((float(line[0]), float(line[1])))

x, y = zip(*datapoints)
x = np.array(x)
y = np.array(y)

# ----------------------------
# Rozwiązanie metodą najmniejszych kwadratów
# ----------------------------
coefficients = np.polyfit(x, y, 1)

a_sqrs = coefficients[0]
b_sqrs = coefficients[1]

# ----------------------------
# Rozwiązanie linprog
# ----------------------------
x = np.array(x)

fi = np.vstack((x, np.ones(len(x)))).T

identity = np.identity(len(fi))

a1 = np.hstack((fi, -identity))
a2 = np.hstack((-fi,  -identity))
A = np.vstack((a1, a2))
Y = np.hstack((y, -y))
print("A: ", A.shape)
print("Y: ", Y.shape)

c = np.vstack((
    [0], [0],
    np.ones((A.shape[1] - 2, 1))
))
print("c: ", c.shape)

lp_result = sp.optimize.linprog(c, A_ub=A, b_ub=Y, method='highs')
# ----------------------------
print("Uzyskane parametry:")
print(f"a={lp_result.x[0]:.4f}, b={lp_result.x[1]:.4f} - metoda LP")
print(f"a={a_sqrs:.4f}, b={b_sqrs:.4f} - metoda najmniejszych kwadratów")

fig, ax = plt.subplots(1, 2, figsize=(10, 5))
ax[0].plot(x, y, 'o', markersize=1.5, color='red')
ax[0].set(xticks=np.arange(x[0], x[-1], 5),
          xlim=(x[0], x[-1]))

ax[1].plot(x, y, 'o', markersize=1, label='Punkty ze zbioru danych', color='red')
ax[1].plot(x, a_sqrs * np.array(x) + b_sqrs, label='Dopasowana prosta (najm. kwadraty)', color='blue')
ax[1].plot(x, lp_result.x[0] * np.array(x) + lp_result.x[1], label='Dopasowana prosta (LP)', color='green')
ax[1].set(xlim=(0, 10), ylim=(2, 10))
ax[1].legend(loc='lower right')
plt.show()
