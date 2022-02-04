%%                        Exercise PP 2 - Data
%--------------------------------------------------------------------------
% Pedro Ferreira 2021
%--------------------------------------------------------------------------

% Objective Function
f  = @(x1,x2) x1.^2+x2.^2-x1.*x2-1;
grad_f = @(x1,x2) [2.*x1+x2 x1+2.*x2];

% Maximum number of iterations
tmax = 2000;

% Initial Point
x = rand(1,2); % The inital point is not given so one will be randomized
f_obj(1) = f(x(1),x(2));

% Precision
% (may not be achivied if the necessary number of iterations is greater 
% than the maximum defined above)
precision = 1E-10;