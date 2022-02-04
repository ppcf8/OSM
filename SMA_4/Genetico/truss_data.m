%*********************************************************************************************
%                                     File: truss_data.m
%
% SCRIPT FILE: Inicialização dos dados
% CALLS: truss_constraints
%*********************************************************************************************

% Dados
% x1 = A/Aref
% x2 = x/h
E = 206.843E9;
rho = 7833.372;
h = 2.54;
Aref = 6.452*10^-4;
P = 44500;
stress0 = 137.895*10^6;
lb = [0.1; 0.1]; % limites inferiores
ub = [2; 2.5]; % limites superiores

% Definição das funções objetivo
syms x1 x2

if f==1 
    ff = @(x1,x2) 2.*rho.*h.*x2.*sqrt(1+x1.^2).*Aref; %f1

elseif f==2
    ff = @(x1,x2) (P.*h.*(1+x1.^2).^1.5.*sqrt(1+x1.^4))./(2.*sqrt(2).*E.*x1.^2.*x2.*Aref); %f2

elseif f==3
    f11(x1,x2) = 2*rho*h*x2*sqrt(1+x1^2)*Aref;
    f11_min = double(f11(0.6573, 0.5336));
    f11_max = double(f11(2, 2.5));
    f22(x1,x2) = (P*h*(1+x1^2)^1.5*sqrt(1+x1^4))/(2*sqrt(2)*E*x1^2*x2*Aref);
    f22_min = double(f22(0.8645, 2.5));
    f22_max = double(f22(0.1, 1.9549));    
    weight(1:2)=0.5; % definição dos pesos
    f3(x1,x2) = weight(1)*(f11 - f11_min)/(f11_max-f11_min) + weight(2)*(f22 - f22_min)/(f22_max-f22_min); %f3
    ff = matlabFunction(f3); 
end

% Restrições
truss_constraints

% População
N_pop = 40; % Número de indivíduos
l_c = 20; % Comprimento do cromossoma
b = [l_c/2 l_c/2]; % Alelos por gene

% Número máximo de iterações
kmax = 500;

% Tolerância
tol = 1e-6;