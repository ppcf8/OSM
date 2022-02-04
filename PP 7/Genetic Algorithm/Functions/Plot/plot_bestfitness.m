%% File: plot_bestfitness.m
% Plot fittest indivual for each generation

function [fig] = plot_bestfitness(ff,lb,ub)

fig = figure(1);
fcontour(ff,[lb(1) ub(1) lb(2) ub(2)])
title('$f(x_1,x_2)=100(x_2-x_1^2)^2+(1-x_1)^2$','Interpreter','latex')
xlabel('$x_1$',Interpreter='latex')
ylabel('$x_2$',Interpreter='latex')
grid on
hold on