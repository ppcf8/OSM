%% plot_pop_evolution.m
% Generation evolution plot

function [fig] = plot_pop_evolution(pop_evolution,X_pop,k,ff,lb,ub)

fig = figure(2);
tiledlayout('flow')

a=round((k+1)/5);
for i=1:a:(1+4*a)
    nexttile
    fcontour(ff,[lb(1) ub(1) lb(2) ub(2)])
    xlabel('$x_1$','Interpreter','latex')
    ylabel('$x_2$','Interpreter','latex')
    hold on

    scatter(pop_evolution(:,1,i),pop_evolution(:,2,i),"red")
    title(['Generation ',num2str(i-1)],'Interpreter','latex')
end

nexttile
fcontour(ff,[lb(1) ub(1) lb(2) ub(2)])
xlabel('$x_1$','Interpreter','latex')
ylabel('$x_2$','Interpreter','latex')
hold on

scatter(X_pop(:,1),X_pop(:,2),"red")
title(['Generation  ',num2str(k)],'Interpreter','latex')








