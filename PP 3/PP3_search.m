%%                  Exercise PP 3 - Search Direction
%--------------------------------------------------------------------------
% Computes the search direction as defined in the Fletcher-Reeves and
% Polak-Ribiére Conjugate Gradient Methods.
%
% Pedro Ferreira 2021
%--------------------------------------------------------------------------


if t==1
    d=-grad_f(x(1),x(2));
elseif t>=2
    % Fletcher-Reeves
%     beta=norm(grad_f(x(1),x(2)))^2/(norm(grad_f(x_old(1),x_old(2)))^2);
    % Polak-Ribiére
    beta=(grad_f(x(1),x(2)))*(grad_f(x(1),x(2))-grad_f(x_old(1),x_old(2))).'/(norm(grad_f(x_old(1),x_old(2)))^2);
    d_old=d;
    d=-grad_f(x(1),x(2))+beta.*d_old;
end
