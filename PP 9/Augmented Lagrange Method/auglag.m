function [Lx1x2,gradL] = auglag(X,f,g,gx1x2,h,epsilon,miu,lambda)

syms x1 x2
g_aux = gx1x2(X(1),X(2));
aux = zeros(length(gx1x2(X(1),X(2))),1);
aux = sym(aux);

for i=1:length(gx1x2(X(1),X(2)))
    if (-epsilon/2)*lambda(i)>g_aux(i)
        aux(i)=(-epsilon/2)*lambda(i);
    else
        aux(i)=g(i);
    end
end    

L(x1,x2) = f + miu'*h + lambda'*sym(aux) + (1/epsilon)*norm(h)^2 + (1/epsilon)*(norm(aux))^2;
dL = gradient(L,[x1,x2]);

Lx1x2 = matlabFunction(L);
gradL = matlabFunction(dL);