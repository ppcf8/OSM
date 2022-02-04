%*********************************************************************************************
%                                     File: plot_pop_evolution.m
%
% FUNCTION FILE: Plot evolução das gerações 
%*********************************************************************************************

function [fig] = plot_pop_evolution(pop_evolution,X_pop,k,ff,lb,ub)

% Abrir figura
fig = figure(WindowState='maximized');
tiledlayout('flow')

a=round((k+1)/5);
for i=1:a:(1+4*a)
    nexttile
    fcontour(ff,[lb(1) ub(1) lb(2) ub(2)],Fill='on')
    xlabel('$x_1$','Interpreter','latex')
    ylabel('$x_2$','Interpreter','latex')
    colorbar
    hold on

    scatter(pop_evolution(:,1,i),pop_evolution(:,2,i),"red")
    title(['Gera\c{c}\~ao ',num2str(i-1)],'Interpreter','latex')
end

nexttile
fcontour(ff,[lb(1) ub(1) lb(2) ub(2)],Fill='on')
xlabel('$x_1$','Interpreter','latex')
ylabel('$x_2$','Interpreter','latex')
colorbar
hold on

scatter(X_pop(:,1),X_pop(:,2),"red")
title(['Gera\c{c}\~ao ',num2str(k)],'Interpreter','latex')








