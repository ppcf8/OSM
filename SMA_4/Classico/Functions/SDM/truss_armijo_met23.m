%*********************************************************************************************
%                                 File: truss_armijo_met23.m                                  
%
% FUNCTION FILE: Armijo - para 2º e 3º métodos de verificação das restrições geométricas        
%*********************************************************************************************

function alfa = truss_armijo_met23(X,La,grad_La,d)

% Parametrização
c=0.8;
gama=0.5;
delta=0.5; 

% Definir passo inicial
alfa=c*abs(double(grad_La(X(1),X(2)))'*d)/(norm(d)^2);
X_new=X+alfa*d;

% Obter passo ótimo
while double(La(X_new(1),X_new(2))) > double(La(X(1),X(2))) + gama*alfa*double(grad_La(X(1),X(2)))'*d 
    alfa=alfa*delta;
    X_new=X+alfa*d;
end

