function [alpha]=armijo(f,d,x,grad_f)
%%                        Armijo Linear Search
%--------------------------------------------------------------------------
% 
% f - objective function
% d - search direction
% x - search point
% grad_f - gradient of the objective function
% 
%
% Pedro Ferreira 2021
%--------------------------------------------------------------------------


delta=0.2967;
gamma=0.1;
c=0.9921;

% Initial guess for the step size α
a=c*abs(grad_f(x(1),x(2))*d.')/(norm(d))^2;

% Application of the Armijo Condition
while true
    if f(x(1)+a*d(1),x(2)+a*d(2))<=f(x(1),x(2))+gamma*a*grad_f(x(1),x(2))*d.'
        break
    else
        a=delta*a;
    end
end
alpha=a;