# PP8 - using SLSQP
# Pedro Ferreira 2021

from scipy.optimize import minimize
import numpy as np

def objective(x):
    return 2*(x[0]-2)**2+4*(x[1]-1)**2


ineq_cons = {'type': 'ineq',
             'fun' : lambda x: np.array([6-2*x[0]-8*x[1],
                                         2*x[0]-2*x[1]])}

x0 = [2,2]
print(objective(x0))


sol = minimize(objective,x0,method='SLSQP',constraints=ineq_cons)
print(sol)