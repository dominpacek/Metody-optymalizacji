import cvxpy as cp

###############################
## method 1
###############################
x1 = cp.Variable()
x2 = cp.Variable()
l1 = cp.Variable()
l2 = cp.Variable()
objective = cp.Minimize(100 * x1 + 199.90 * x2 + 700 * l1 + 800 * l2 - (6500 * l1 + 7100 * l2))
constraints = [
    0.01 * x1 + 0.02 * x2 - 0.5 * l1 - 0.6 * l2 >= 0,
    x1 + x2 <= 1000,
    90 * l1 + 100 * l2 <= 2000,
    40 * l1 + 50 * l2 <= 800,
    100 * x1 + 199.90 * x2 + 700 * l1 + 800 * l2 <= 100000,
    x1 >= 0,
    x2 >= 0,
    l1 >= 0,
    l2 >= 0
]
p1 = cp.Problem(objective, constraints)
p1.solve(solver=cp.ECOS_BB)
print("--------------")
print(f"Lek 1: {l1.value:.4f}")
print(f"Lek 2: {l2.value:.4f}")
print(f"Surowiec 1: {x1.value:.4f}")
print(f"Surowiec 2: {x2.value:.4f}")
print("--------------")
