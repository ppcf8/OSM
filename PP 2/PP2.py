# PP2 - using BFGS method
# Pedro Ferreira

from scipy.optimize import minimize
import numpy as np

def objective(x):
    return x[0]**2+x[1]**2+x[0]*x[1]-1


def rosen_der(x):
    der = np.zeros_like(x)
    der[0] = 2*x[0]+x[1]
    der[1] = 2*x[1]+x[0]
    return der

x0=[1,1]

sol = minimize(objective,x0,method='BFGS',jac=rosen_der,options={'disp': True})
print(sol)