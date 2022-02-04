%% PP7_data.m
% Problem Data
% Calls: truss_constraints

% Data
lb = [0; 0];   % Lower limits
ub = [2; 2]; % Upper limits

% Objective Function
f = @(x1,x2) 100.*(x2-x1.^2).^2+(1-x1).^2;

% Population Parameters
N_pop = 100;       % Number of individuals
l_c = 50;         % Chromosome Length
b = [l_c/2 l_c/2]; % Number of alleles per gene

% Max number of iterations
kmax = 1000;

% Tolerance
tol = 1e-6;