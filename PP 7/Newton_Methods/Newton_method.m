%%                  Newton Method
c1 = 1;     % c1>0
c2 = 2;     % c2>0
p  = 3;     % p>=2
q  = 4;     % q>=3

dn = -f.hess(x(1),x(2))\f.grad(x(1),x(2));

if f.grad(x(1),x(2)).'*dn<=-c1*norm(f.grad(x(1),x(2)))^q && norm(dn)^p<=c2*norm(f.grad(x(1),x(2)))
    d=dn;
else
    d=-f.grad(x(1),x(2));
end
