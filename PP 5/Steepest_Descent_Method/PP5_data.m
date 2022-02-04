%%                        Exercise PP 5 - Data
%--------------------------------------------------------------------------
% Pedro Ferreira 2021
%--------------------------------------------------------------------------

% Objective Function
f  = @(x,y) 2.*x+20./(x.*y)+y./3;
grad_f = @(x,y) [2-20./(x.^2.*y), -20./(x.*y.^2)+1/3];

% Maximum number of iterations
tmax = 2000;

% Initial Point
x = [1 4];
f_obj(1) = f(x(1),x(2));

% Precision
% (may not be achivied if the necessary number of iterations is greater 
% than the maximum defined above)
precision = 1E-8;
