%*********************************************************************************************
%                                     File: plot_bestfitness.m
%
% FUNCTION FILE: Plot do individuo com melhor fitness em cada geração
%*********************************************************************************************

function [fig] = plot_bestfitness(f,ff,lb,ub)

% Abrir figura
fig = figure(1);
movegui(fig,'center');

fcontour(ff,[lb(1) ub(1) lb(2) ub(2)],Fill='on')

xlabel('$x_1$',Interpreter='latex')
ylabel('$x_2$',Interpreter='latex')

if f==1
    title('$$\bf{f_1(x) = 2 \, {\rho} \, h \, x_2 \, \sqrt{1+x_1^2} \, A_{ref}}$$','Interpreter','latex')
elseif f==2
    title('$$\bf{f_2(x) = \frac{{\rho} \, h \, (1+x_1^2)^{1,5} \, \sqrt{1+x_1^4}}{2 \, \sqrt{2} \, E \, x_1^2 \, x_2 \, A_{ref}} }$$','Interpreter','latex')
elseif f==3
    title('$$\bf{F(x) = (f_2(x),f_1(x))}$$','Interpreter','latex')
end

colorbar
grid on
hold on



