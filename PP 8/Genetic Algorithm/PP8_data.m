%% PP8_data.m
% Problem Data
% Calls: truss_constraints

% Data
lb = [0; 0];   % Lower limits
ub = [2; 0.5]; % Upper limits

% Objective Function
f = @(x1,x2) 2.*(x1-2).^2 + 4.*(x2-1).^2;

% Constraints
syms x1 x2
c(1,1) = 2*x1+8*x2-6;
c(1,2) = -2*x1+2*x2;
g = matlabFunction(c);

% Population Parameters
N_pop = 100;       % Number of individuals
l_c = 50;         % Chromossome Length
b = [l_c/2 l_c/2]; % Number of alleles per gene

% Max number of iterations
kmax = 1000;

% Tolerance
tol = 1e-6;