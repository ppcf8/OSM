%%                         Exercise PP 5 - Main 
%--------------------------------------------------------------------------
% Main file for the resolution of the exercise PP 5 from the book 
% "OPTIMIZATION OF MECHANICAL SYSTEMS: optimal design applications" 
% by Carlos Conceição António and Gonçalo das Neves Carneiro.  
%
% Calls: PP5_data.m, PP5_search, PP5_plot, armijo
%
% Pedro Ferreira 2021
% -------------------------------------------------------------------------

clear
clc
close(figure(1))    % Close open figure

% Initialize Data
PP5_data

% Open Contour Plot Figure
figure(1)
% Draw Conturs at increments of 0.3
fcontour(f,[0 3 3 8])
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
title('$f(x,y) = 2x +\frac{20}{xy}$ + $\frac{y}{3}$','Interpreter','latex')
hold on

% X=zeros(tmax,2); % Optional, uncomment if you want the table of iterations below

% Search Cycle
t=0;
while t<tmax && norm(grad_f(x(1),x(2))) > precision
    t=t+1;
%     X(t,:)=x;    % Optional, uncomment if you want the table of iterations below
    
    % Select the search direction
    PP5_search

    % Determine the step size
    alpha=armijo(f,d,x,grad_f);
%     alpha=armijo(f,d,x,grad_f,0.2971,0.1,0.99); % 218 iterations
%     alpha=armijo(f,d,x,grad_f,0.2956,0.1,0.9950); % 217 iterations
%     alpha=armijo(f,d,x,grad_f,0.2967,0.1,0.9921); % 215 iterations
    % New search point
    x_old=x;
    f_old=f_obj;

    x=x+alpha*d;
    f_obj=f(x(1),x(2));

    % Plot the current search path
    PP5_plot
end

% X=X(1:t,:); % Optional, uncomment if you want the table of iterations below

% % Table of Iterations (optional)
% Iterations = 1:t;
% T = table(Iterations.',X(:,1),X(:,2));
% T.Properties.VariableNames={'Iterations','x','y'};
% disp(T)

% Display the results
% 
fprintf([ ...
         'Number of Iterations: %d\n\n', ...
         'Point of Minima: [%d , %d]\n\n', ...
         'Objective Function Minimum Value after Optimization: %d\n\n'], ...
         t,x(1),x(2),f_obj)