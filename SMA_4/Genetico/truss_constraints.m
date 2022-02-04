%*********************************************************************************************
%                                File: truss_constraints.m                                 
%
% SCRIPT FILE: Definição das restrições 
%*********************************************************************************************

ceq = [ ];  % Não há restrições de igualdade
c(1,1) = abs((P*(1+x1)*sqrt(1+x1^2)) / (2*sqrt(2)*x1*x2*Aref))/stress0 - 1;
c(1,2) = abs((P*(x1-1)*sqrt(1+x1^2)) / (2*sqrt(2)*x1*x2*Aref))/stress0 - 1;
g = matlabFunction(c);

