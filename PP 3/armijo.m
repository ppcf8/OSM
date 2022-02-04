function [alpha]=armijo(f,d,x,df)
%%                        Armijo Linear Seacrh
%--------------------------------------------------------------------------
% Pedro Ferreira 2021
%--------------------------------------------------------------------------

% Defines δ∈(0,1), γ∈(0,1/2), c∈(0,1)
delta=rand(1);
gama=rand(1)*0.5;
c=rand(1);

% Maybe the best values for Fletcher-Reevs (needs better study)
% delta=0.5;
% gama=0.2;
% c=0.9;

% Initial guess for the step size α
a=c*abs(df(x(1),x(2))*d.')/(norm(d))^2;

% Application of the Armijo Condition
k=1;
while k>0
    if f(x(1)+a*d(1),x(2)+a*d(2))<=f(x(1),x(2))+gama*a*df(x(1),x(2))*d.'
        k=0;
    else
        a=delta*a;
        k=1;
    end
end
alpha=a;