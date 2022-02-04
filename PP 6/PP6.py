# PP6 - using BFGS method
# Pedro Ferreira

from scipy.optimize import minimize
import numpy as np

def objective(x):
    return x[0]*x[1]+1/(x[0]*x[2])-16*x[1]**2+x[2]


def rosen_der(x):
    der = np.zeros_like(x)
    der[0] = x[1]-1/(x[0]**2*x[2])
    der[1] = x[0]-32*x[1]
    der[2] = 1-1/(x[0]*x[2]**2)
    return der

x0=[1,0.5,0.5]

sol = minimize(objective,x0,method='BFGS',jac=rosen_der,options={'disp': True})
print(sol)

# The function tends to infinity in the second coordinate (x[1])