% Data
syms x1 x2

%Objective function
f(x1,x2) = x1^4 - 2*x1*x2 + x1^2 + x1*x2^2 - 2*x1 + 4;
f= matlabFunction(f);

%Population
N_pop = 100; %number of individuals
l_c = 50; %length of the chromossom
b = [l_c/2 l_c/2]; % Allels per gene

%Encoding/decoding
Var_limits=[0 4;0 4];


%Fitness function parameters


%Parameters for genetic operators



%Number of maximum iterations
tmax = 1000;

% Tolerance
tol = 1e-6;