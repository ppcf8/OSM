# PP9 - using SLSQP
# Pedro Ferreira 2021
from scipy.optimize import minimize

def objective(x):
    return x[0]**4-2*x[0]**2*x[1]+x[0]**2+x[0]*x[1]**2-2*x[0]+4

eq_cons={'type':'eq',
         'fun':lambda x: [x[0]**2+x[1]**2-2]}

ineq_cons={'type':'ineq',
          'fun': lambda x: -(0.25*x[0]**2+0.75*x[1]**2-1)}

x0 = [2,2]
print(objective(x0))

b = [0,4]
bnds = [b,b]

sol = minimize(objective,x0,method='SLSQP',bounds=bnds,
               constraints=[eq_cons,ineq_cons])
print(sol)