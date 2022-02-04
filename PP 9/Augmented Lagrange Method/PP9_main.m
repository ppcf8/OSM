clear
clc
close(figure(1))

PP9_data

% Open Contour Plot Figure
figure(1)
fcontour(fx1x2,[0 5 0 5])
xlabel('$x_1$','Interpreter','latex')
ylabel('$x_2$','Interpreter','latex')
title('$f(x_1,x_2) = x_1^4 - 2x_1^2 x_2 + x_1^2 +x_1 x_2^2 -2x_1 +4$', ...
      'Interpreter','latex')
dim =[0.15, 0.8, 0.1, 0.1];
const_str = {'Constraints:', '$x_1^2+x_2^2-2=0$',' ', ...
             '$0.25x_1^2+0.75x_2^2-1 \leq 0$',' ', '$0 \leq x_1 \leq 4$',...
             ' ', '$0 \leq x_2 \leq 4$'};
annotation('textbox',dim,'String', const_str,'Interpreter','latex','BackgroundColor','w')
grid on
hold on

epsilon_min = 0.0001;
epsilon = 0.1;
miu = zeros(length(hx1x2(X(1),X(2))),1);
lambda = zeros(length(gx1x2(X(1),X(2))),1);

% Search Cycle
k=0;
while k<kmax
    k=k+1;
    [Lx1x2,gradL] = auglag(X,f,g,gx1x2,h,epsilon,miu,lambda);
    [X,X_old] = minimize(X,Lx1x2,gradL,lb,ub,tmax);

    
    % Plot Search Path
    plot([X_old(1) X(1)],[X_old(2) X(2)],'o-r')
    
    % KKT Conditions
    [KKT, KKT_norm,flag]=KKT_fun(X,lambda,miu,grad_f,grad_h,grad_g,gx1x2);

    if flag
        break
    end

    [miu,lambda,epsilon] = update(X,hx1x2,gx1x2,miu,lambda,epsilon,epsilon_min);
end
f_obj = fx1x2(X(1),X(2));

% Plot point of minima in a different color
plot(X(1),X(2),'ok',MarkerFaceColor='k')

% Print the results
fprintf([ ...
         'Number of Iterations: %d\n\n', ...
         'Point of Minima: [%.4f , %.4f]\n\n', ...
         'Objective Function Minimum Value after Optimization: %.4f\n\n'], ...
         k,X(1),X(2), f_obj)


