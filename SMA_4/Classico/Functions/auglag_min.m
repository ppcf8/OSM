%*********************************************************************************************
%                                    File: auglag_min.m                                    
%
% FUNCTION FILE: Minimização da função Lagrangiana
% CALLS: gradient, gradient_conj, quasi_newton, newton, truss_armijo_met23, truss_armijo_met1
%*********************************************************************************************

function [X,k2,counterg] = auglag_min(X,X_old,H,La,grad_La,hessian_La,method,searchd,lb,ub,kmax,k4max)

% Ciclo de pesquisa
k2 = 0;
k3 = 0;
k4 = 0;
counterg=0; % contar nº de vezes que é utilizada a direção do gradiente   

d=0; % inicialização da direção para o método do Gradiente Conjugado

while k2<kmax && norm(double(grad_La(X(1),X(2))))>1e-06 && k4<k4max
    k2 = k2+1;
    k3 = k3+1;

    % Guardar ponto
    X_old4=X;

    % Seleção da direção de pesquisa
    if searchd==1
       d = gradiente(X,grad_La);
    elseif searchd==2
       d = gradiente_conj(X,X_old4,d,k3,grad_La);
    elseif searchd==3 
       [d,H] = quasi_newton(grad_La,X,X_old,H,k2);
    else
       [d,counterg] = newton(X,grad_La,hessian_La,counterg);
    end

    % Determinar o passo ótimo
    if method == 2 || method == 3
        alfa = truss_armijo_met23(X,La,grad_La,d); % armijo para os métodos 2 e 3 das restrições geométricas 
    elseif method == 1
        alfa = truss_armijo_met1(X,La,grad_La,d,lb,ub); % armijo para o método 1 das restrições geométricas 
    end
    
    X = X+alfa*d;

    if X_old4 == X
        k4=k4+1;
    end

    if searchd==2 && k3>1 % Teste à perda de conjugação das direções - reset das direções (método do gradiente conjugado)
        delta=0.6; % parametrização
        if abs(double(grad_La(X(1),X(2)))'*double(grad_La(X_old(1),X_old(2)))) > delta*norm(grad_La(X_old(1),X_old(2)))^2
            k3 = 0;
            counterg =  counterg + 1;
        end
    end
end
