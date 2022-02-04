%*********************************************************************************************
%                               File: quasi_newton.m                             
%
% FUNCTION FILE: Direção de pesquisa - Método de Quase_Newton BFGS inverso
%*********************************************************************************************

function [d,H] = quasi_newton(grad_La,x,x_old,H,t)

c=1; %fórmula BFGS

grad_La_x = double(grad_La(x(1),x(2)));
grad_La_x_old = double(grad_La(x_old(1),x_old(2)));

if t==1
    H=eye(2);

else
    deltak = x - x_old;
    yk = grad_La_x - grad_La_x_old;
    vk = deltak/(deltak.'*yk) - (H*yk)/((yk')*H*yk);
    deltaH = (deltak*(deltak'))/((deltak')*yk) - (H*yk*((H*yk)'))/((yk')*H*yk) + c*(yk')*H*yk*vk*(vk');
    H = H+deltaH;
end

d=-H*grad_La_x;
