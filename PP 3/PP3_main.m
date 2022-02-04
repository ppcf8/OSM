%%                         Exercise PP 3 - Main 
%--------------------------------------------------------------------------
% Main file for the resolution of the exercise PP 3 from the book 
% "OPTIMIZATION OF MECHANICAL SYSTEMS: optimal design applications" 
% by Carlos Conceição António and Gonçalo das Neves Carneiro.  
%
% Calls: PP3_data.m, PP3_search, armijo, PP3_plot
%
% Pedro Ferreira 2021
% -------------------------------------------------------------------------

clear
clc
close(figure(1))    % Close open figure

% Initialize Data
PP3_data

% Open Contour Plot Figure
figure(1)
% Draw Conturs at increments of 0.3
fcontour(f)
xlabel('x_1')
ylabel('x_2')
title('f(x_1,x_2) = x_1-x_2-2x_1x_2-x_1^2-2x_2^2')
hold on

X=zeros(tmax,2); % Optional, uncomment if you want the table of iterations below

% Search Cycle
t=0;
while t<tmax && norm(grad_f(x(1),x(2))) > precision
    t=t+1;
    X(t,:)=x; % Optional, uncomment if you want the table of iterations below

    % Select the search direction
    PP3_search

    % Determine the step size
    alpha=armijo(f,d,x,grad_f);

    % New search point
    x_old=x;
    f_old=f_obj;

    x=x+alpha*d;
    f_obj=-f(x(1),x(2));

    % Plot the current search path
    PP3_plot
end
% X=X(1:t,:);

% % Table of Iterations (optional)
% Iterations = 1:t;
% T = table(Iterations.',X(:,1),X(:,2));
% T.Properties.VariableNames={'Iterations','x1','x2'};
% disp(T)

% Results
fprintf(['Number of Iterations: %d\n\n', ...
         'Point of Minima: [%1.10f , %1.10f]\n\n', ...
         'Objective Function Minimum Value after Optimization: %d\n\n'], ...
         t,x(1),x(2),f_obj)