%% File: plot_bestfitness.m
% Plot fittest indivual for each generation

function [fig] = plot_bestfitness(ff,lb,ub)

fig = figure(1);
fcontour(ff,[lb(1) ub(1) lb(2) ub(2)])
title('$f(x_1,x_2)=2(x_1-2)^2+4(x_2-1)^2$','Interpreter','latex')
xlabel('$x_1$',Interpreter='latex')
ylabel('$x_2$',Interpreter='latex')
dim =[0.15, 0.8, 0.1, 0.1];
const_str = {'Constraints:', '$2x_1+8x_2 \leq 6$',' ', ...
             '$2x_1 \geq 2x_2$',};
annotation('textbox',dim,'String', const_str,Interpreter='latex',BackgroundColor='w')
grid on
hold on



