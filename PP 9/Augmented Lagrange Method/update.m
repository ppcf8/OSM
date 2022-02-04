function [miu,lambda,epsilon] = update(X,hx1x2,gx1x2,miu,lambda,epsilon,epsilon_min)

miu = miu+2/epsilon*hx1x2(X(1),X(2));
lambda = max([zeros(length(gx1x2(X(1),X(2))),1), lambda + (2/epsilon)*gx1x2(X(1),X(2))],[],2);
ro = 0.95;
epsilon_old = epsilon;
epsilon = epsilon*ro;

if epsilon < epsilon_min
    epsilon = epsilon_old;
end

