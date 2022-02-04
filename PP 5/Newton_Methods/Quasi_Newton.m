%%                       Quasi Newton Methodgrad_La
%--------------------------------------------------------------------------
% cc = 0  - DFP
% cc = 1  - BFGS
%
% Pedro Ferreira 2021
%--------------------------------------------------------------------------
if t==1
    H=eye(2);
else
    deltak = x-x_old;
    yk = f.grad(x(1),x(2))-f.grad(x_old(1),x_old(2));
    vk = deltak/(deltak.'*yk) - (H*yk)/(yk.'*H*yk);
    deltaH = (deltak*deltak.')/(deltak.'*yk) - (H*yk*(H*yk).')/(yk.'*H*yk) + cc*yk.'*H*yk*vk*(vk.');
    H = H+deltaH;
end

d=-H*f.grad(x(1),x(2));