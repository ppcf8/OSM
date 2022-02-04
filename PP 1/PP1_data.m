%%                        Exercise PP 1 - Data
%--------------------------------------------------------------------------
% Pedro Ferreira 2021
%--------------------------------------------------------------------------

% Objective Function
f  = @(x1,x2) x1-x2 + 2.*x1.^2 + 2.*x1.*x2 + x2.^2;
grad_f = @(x1,x2) [1+2.*x2+4.*x1 -1+2.*x1+2.*x2];

% Maximum number of iterations
tmax = 2000;

% Initial Point
x = [0 0];
f_obj(1) = f(x(1),x(2));

% Precision
% (may not be achivied if the necessary number of iterations is greater 
% than the maximum defined above)
precision = 1E-10;