%%                        Exercise PP 5 - Main
%--------------------------------------------------------------------------
% Pedro Ferreira 2021
%--------------------------------------------------------------------------
clear
clc
close all    % Close open figures

for k=1:3
    PP5_data % Initialize Data

    fig = figure(k);  % Open Contour Plot Figure

    if k==1
        fig.Name='Newton Method';
        fprintf(['------------------------------------- \n', ...
                 'Newton Method \n \n'])
    elseif k==2
        cc=0;
        fig.Name='Quasi-Newton Method - DFP';
        fprintf(['------------------------------------- \n', ...
                 'Quasi-Newton Method - DFP \n \n'])
    elseif k==3
        cc=1;
        fig.Name='Quasi-Newton Method - BFGS';
        fprintf(['------------------------------------- \n', ...
                 'Quasi-Newton Method - BFGS \n \n'])
    end
    
    % Draw Conturs
    fcontour(f.fun,[0 4.5 4 8])
    xlabel('$x$','Interpreter','latex')
    ylabel('$y$','Interpreter','latex')
    title('$U(x,y) = 2x +\frac{20}{xy}$ + $\frac{y}{3}$','Interpreter','latex')
    hold on
    grid on
    axis equal
    
    % Search Cycle
    t=0;
    while t<tmax && norm(f.grad(x(1),x(2))) > precision
        t=t+1;        
        if k==1
            Newton_method % Computes the search direction
            alpha=armijo(f.fun,d,x,f.grad); % Step Length
        else
            Quasi_Newton % Computes the search direction
            alpha = strong_wolfe(f.fun,f.grad,x,f_obj,d); % Step Length
        end
    
        % New search point
        x_old=x;
        f_old=f_obj;
    
        x=x+alpha*d;
        f_obj=f.fun(x(1),x(2));
       
        % Plot the current search path
         plot([x_old(1),x(1)],[x_old(2),x(2)],'o-r')
    end
    % Plot point of minima in a different color
    plot(x(1),x(2),'ok',MarkerFaceColor='k')
    
    % Print the results
    fprintf([ ...
             'Number of Iterations: %d\n\n', ...
             'Point of Minima: [%d , %d]\n\n', ...
             'Objective Function Minimum Value after Optimization: %d\n\n'], ...
             t,x(1),x(2),round(f_obj,8))
end
