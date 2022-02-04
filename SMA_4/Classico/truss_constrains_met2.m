%*********************************************************************************************
%                                File: truss_constrains_met2.m                                 
%
% SCRIPT FILE: Definição das restrições para o 2º método de verificação das restrições geométricas 
%*********************************************************************************************

ceq = [ ];   % Não há restrições de igualdade
c(1,1) = abs((P*(1+x1)*sqrt(1+x1^2)) / (2*sqrt(2)*x1*x2*Aref))/stress0 - 1;
c(2,1) = abs((P*(x1-1)*sqrt(1+x1^2)) / (2*sqrt(2)*x1*x2*Aref))/stress0 - 1;
c(3,1)= lb(1) - x1;
c(4,1) = -ub(1) + x1;
c(5,1) = lb(2) - x2;
c(6,1) = -ub(2) + x2;
c_x1x2 = matlabFunction(c);

grad_c = cell(1,length(c));
for i=1:size(c,1)
    grad_c{i}=gradient(c(i),[x1 x2]);
end
grad_cc = cell2sym(grad_c);
difx1_c(x1,x2) = grad_cc(1,:)';
difx2_c(x1,x2) = grad_cc(2,:)';

n = numel(c); % número de restrições de desigualdade