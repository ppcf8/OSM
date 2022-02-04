# PP5 - using BFGS method
# Pedro Ferreira

from scipy.optimize import minimize
import numpy as np

def objective(x):
    return 2*x[0]+20/(x[0]*x[1])+x[1]/3


def rosen_der(x):
    der = np.zeros_like(x)
    der[0] =2-20/(x[0]**2*x[1])
    der[1] = 1/3-20/(x[0]*x[1]**2)
    return der

x0=[1,1]

sol = minimize(objective,x0,method='BFGS',jac=rosen_der,options={'disp': True})
print(sol)
