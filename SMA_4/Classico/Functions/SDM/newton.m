%*********************************************************************************************
%                               File: newton.m                             
%
% FUNCTION FILE: Direção de pesquisa - Método de Newton
%*********************************************************************************************

function [d,counterg] = newton(X,grad_La,hessian_La,counterg)

% Parametrização
c_1=1;
c_2=2;
p=3;
q=4;

d_N = -(double(hessian_La(X(1),X(2))))\(double(grad_La(X(1),X(2))));

if double(grad_La(X(1),X(2)))'*d_N <= -c_1*norm(double(grad_La(X(1),X(2))))^q && norm(d_N)^p <= c_2*norm(double(grad_La(X(1),X(2))))
    d=d_N;

else
    d = -double(grad_La(X(1),X(2)));
    counterg = counterg + 1; % contar nº de vezes que é utilizada a direção do gradiente
end
