%%                        Exercise PP 5 - Data
%--------------------------------------------------------------------------
% Pedro Ferreira 2021
%--------------------------------------------------------------------------

% Objective Function
syms x1 x2
f.fun  = matlabFunction(2*x1+20/(x1*x2)+x2/3);
f.grad = matlabFunction(gradient(f.fun, [x1 x2]));
f.hess = matlabFunction(hessian(f.fun, [x1 x2]));

% Maximum number of iterations
tmax = 2000;

% Initial Point
x = [1;5];
f_obj = f.fun(x(1),x(2));

% Precision
% (may not be achivied if the necessary number of iterations is greater 
% than the maximum defined above)
precision = 1E-8;