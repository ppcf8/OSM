%% plot_pop_evolution2.m
% Generation Evolution plot - stantdard deviation and mean 

function [fig] = plot_pop_evolution2(std_fitness,mean_fitness,best_fitness,k)

fig = figure(3);

plot(0:k,std_fitness,"blue",'LineWidth',2) % Plot standard deviation
hold on

plot(0:k,mean_fitness,"red",'LineWidth',2) % Plot mean
hold on

plot(0:k,best_fitness,"green",'LineWidth',2) % Plot best fitness

title('Fitness','Interpreter','latex')
xlabel('Generation','Interpreter','latex')
xlim([0 k])

legend('Standard Deviation','Mean','Best Fitness','Interpreter', ...
       'latex','Location', 'northeast')