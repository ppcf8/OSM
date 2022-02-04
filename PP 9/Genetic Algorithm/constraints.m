syms x1 x2
c(1,1) = x1^2+x2^2-2;
c(2,1) = -c(1,1);
c(3,1) = 0.25*x1^2 + 0.75*x2^2 - 1;
g = matlabFunction(c);

