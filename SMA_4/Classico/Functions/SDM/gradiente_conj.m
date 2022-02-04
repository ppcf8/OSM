%*********************************************************************************************
%                               File: gradiente_conj.m                             
%
% FUNCTION FILE: Direção de pesquisa - Método do Gradiente Conjugado
%*********************************************************************************************

function [d] = gradiente_conj(X,X_old,d,k3,grad_La)

if k3 == 1
    d = -double(grad_La(X(1),X(2)));
else
    % Polack_Ribiére
    beta = (double(grad_La(X(1),X(2)))'*(double(grad_La(X(1),X(2)))-double(grad_La(X_old(1),X_old(2))))) / norm(grad_La(X_old(1),X_old(2)))^2;
    d=double(-grad_La(X(1),X(2))+beta*d);
end
