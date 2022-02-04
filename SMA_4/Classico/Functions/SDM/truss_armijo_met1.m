%*********************************************************************************************
%                                 File: truss_armijo_met1.m                                  
%
% FUNCTION FILE: Armijo - para 1º método de verificação das restrições geométricas          
%*********************************************************************************************

function alfa = truss_armijo_met1(X,La,grad_La,d,lb,ub)

% Parametrização
c=0.8;
gama=0.5;
delta=0.5; 

% Definir passo inicial
alfa=c*abs(double(grad_La(X(1),X(2)))'*d)/(norm(d)^2);
X_new=X+alfa*d;

while any(lb > X_new) || any(ub < X_new)
    alfa=alfa*delta;
    X_new=X+alfa*d;
end

% Obter passo ótimo
while double(La(X_new(1),X_new(2))) > double(La(X(1),X(2))) + gama*alfa*double(grad_La(X(1),X(2)))'*d  && all(lb < X_new) && all(X_new < ub)
    alfa_old = alfa;
    alfa=alfa*delta;
    X_new=X+alfa*d; 
end

if any(lb > X_new) || any(X_new > ub)
    alfa =alfa_old;
end

