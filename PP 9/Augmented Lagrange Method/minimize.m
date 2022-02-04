function [X,X_old] = minimize(X,Lx1x2,gradL,lb,ub,tmax)

t=0;
X_old = X;
while t<tmax && norm(gradL(X(1),X(2)))>10^-6
    t=t+1;

    % Search Direction
    d = -gradL(X(1),X(2));

    c = 0.01;
    gama = 0.01;
    delta = 0.5;

    % Define initial step value
    alfa = c*abs(gradL(X(1),X(2))'*d)/(norm(d)^2);
    X_new = X+alfa*d;
    

    while any(lb > X_new) || any(ub < X_new)
        alfa = alfa*delta;
        X_new = X+alfa*d; 
    end

    % Find optimal step
    while Lx1x2(X_new(1),X_new(2)) > Lx1x2(X(1),X(2)) + gama*alfa*gradL(X(1),X(2))'*d && all(lb < X_new) && all(X_new < ub)
        alfa = alfa*delta;
        X_new = X+alfa*d;
    end

    X = X+alfa*d;
end