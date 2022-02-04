%*********************************************************************************************
%                                  File: truss_al_function.m                                   
%
% FUNCTION FILE: % Definição da função Lagrangiana e seu gradiente e matriz hessiana
%*********************************************************************************************

function [La, grad_La, hessian_La]=auglag(f1,c,Max,lambda,epsilon,searchd)

syms x1 x2
% Função Lagrangiana
La = f1 + lambda'*Max(c,-epsilon/2*lambda) + 1/epsilon*norm(Max(c,-epsilon/2*lambda))^2; 

% Gradiente - Função Lagrangiana
grad_La(x1,x2) = gradient(La);

% Matriz Hessiana - Função Lagrangiana
if searchd==4 % só é necessária no método 3
hessian_La(x1,x2) = hessian(La);
else
hessian_La = 0;
end

