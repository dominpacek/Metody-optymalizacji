# Ćwiczenie 1 zadanie 1
# Nina Łabęcka 311339 grupa czwartek 14:15
# Dominika Pacek 311378 grupa czwartek 18:15

import cvxpy as cp
import scipy

x1 = cp.Variable() 
x2 = cp.Variable()
x3 = cp.Variable()
objective = cp.Minimize(300 * x1 + 500 * x2 + 800 * x3)
constraints = [
    x1 >= 0,
    x2 >= 0,
    x3 >= 0,
    0.80 * x1 + 0.3 * x2 + 0.1 * x3 >= 0.3,
    0.01 * x1 + 0.4 * x2 + 0.7 * x3 >= 0.7,
    0.15 * x1 + 0.1 * x2 + 0.2 * x3 >= 0.1
]
p1 = cp.Problem(objective, constraints)
p1.solve(solver=cp.ECOS_BB)
print("--------------")
print(f"x1 = {x1.value:.4f}")
print(f"x2 = {x2.value:.4f}")
print(f"x3 = {x3.value:.4f}")
print("--------------")
