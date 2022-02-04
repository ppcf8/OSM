% Objective function
syms x1 x2
f(x1,x2) = x1^4 - 2*x1^2*x2 + x1^2 + x1*x2^2 - 2*x1 + 4;
df = gradient(f,[x1,x2]);
fx1x2 = matlabFunction(f);
grad_f = matlabFunction(df);

% Initial point (k=0)
X = [3;2];
f_obj = fx1x2(X(1),X(2));

% Maximum number of iterations
kmax = 2000;
tmax = 2000;

% Constraints
h = x1^2 + x2^2-2;
g = 0.25*x1^2 + 0.75*x2^2-1;
hx1x2 = matlabFunction(h);
grad_h = matlabFunction(gradient(hx1x2, [x1 x2]));
gx1x2 = matlabFunction(g);
grad_g = matlabFunction(gradient(gx1x2, [x1 x2]));
lb=[0; 0];
ub=[4; 4];
   


