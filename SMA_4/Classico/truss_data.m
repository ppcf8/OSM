%*********************************************************************************************
%                                     File: truss_data.m
%
% SCRIPT FILE: Inicialização dos dados
% CALLS: truss_constrains_met2, truss_constrains_met13
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
    f1(x1,x2) = 2*rho*h*x2*sqrt(1+x1^2)*Aref; %f1

elseif f==2
    f1(x1,x2) = (P*h*(1+x1^2)^1.5*sqrt(1+x1^4))/(2*sqrt(2)*E*x1^2*x2*Aref)*10^3; %f2

elseif f==3
    f11(x1,x2) = 2*rho*h*x2*sqrt(1+x1^2)*Aref;
    f11_min = double(f11(0.6573, 0.5336));
    f11_max = double(f11(2, 2.5));
    f22(x1,x2) = (P*h*(1+x1^2)^1.5*sqrt(1+x1^4))/(2*sqrt(2)*E*x1^2*x2*Aref);
    f22_min = double(f22(0.8645, 2.5));
    f22_max = double(f22(0.1, 1.9549));
    
    weight(1:2)=0.5; % definição dos pesos
    f1(x1,x2) = weight(1)*(f11 - f11_min)/(f11_max-f11_min) + weight(2)*(f22 - f22_min)/(f22_max-f22_min); %f3
end

difx1_f1 = diff(f1,x1);
difx2_f1 = diff(f1,x2);
f1_x1x2 = matlabFunction(f1);

% Ponto inicial (k=0)
k = 0; % Contador das iterações
X = [1; 1]; 

% Número máximo de iterações
kmax = 500;

% Contadores da estagnação da convergência 
k3 = 0;
k3max = 10;

% Contadores do nº de iterações na minimizçaõ da função lagrangeana
if searchd == 2 % método da direção de pesquisa
    counters = zeros(kmax,2); % armazenar contadores
    counterg=0;  % contar nº resets de direção
    countert=0; % contar nº total 
elseif searchd == 4 % método da direção de pesquisa
    counters = zeros(kmax,2); % armazenar contadores
    counterg=0;  % contar nº de vezes que é utilizada a direção do gradiente 
    countert=0; % contar nº total 
else
    counters = zeros(kmax,1); % armazenar contadores
    countert=0; % contar nº total 
end

% Restrições
if method == 1 || method == 3
    truss_constrains_met13 % Definição das restrições geométricas - métodos 1 e 3
elseif method == 2
    truss_constrains_met2 % Definição das restrições geométricas - método 2
end

% Definição da função máximo
syms x y
Max(x,y) = piecewise(x>y,x,y);

% Definição da primiera aproximação da matriz hessiana - método de Newton
H=eye(2);

