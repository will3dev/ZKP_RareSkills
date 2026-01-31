from py_ecc.bn128 import neg, add, multiply, G1, G2

# input values
a = 2
b = 13
c = 4

x_1 = 1
x_2 = 2
x_3 = 3

# hard coded values
alpha = 2
beta = 3
gamma = 2
delta = 2

# Generator points
print("G1:", G1)
print("G2:", G2)
print()

# negate G1 * a to make the equation sum up to 0
print(neg(multiply(G1, a)))

print(multiply(G2, b))

print(multiply(G1, alpha))

print(multiply(G2, beta))

# calculate X_1 
X_1 = add(add(multiply(G1, x_1), multiply(G1, x_2)), multiply(G1, x_3))
print(X_1)

print(multiply(G2, gamma))

print(multiply(G1, c))

print(multiply(G2, delta))




