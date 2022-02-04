clc
clear
close all
tic
GA_data
constraints

Population = randi([0 1], N_pop, l_c);
t=0;
[fitness,X_pop] = fitness_function(f,g,Population,N_pop,b,Var_limits,t,l_c);

figure(1)
fcontour(f,[Var_limits(1,:) Var_limits(2,:)])
title('$f(x_1,x_2)=x_1^4-2*x_1*x_2+x_1^2+x_1*x_2^2-2*x_1+4$',Interpreter='latex')
xlabel('$x_1$',Interpreter='latex')
ylabel('$x_2$',Interpreter='latex')
dim =[0.15, 0.8, 0.1, 0.1];
const_str = {'Constraints:', '$x_1^2+x_2^2-2=0$', ...
             '$0.25x_1^2 + 0.75x_2^2 - 1 \leq 0 $',...
             '$0 \leq x_1 \leq 4$','$0 \leq x_2 \leq 4$'};
annotation('textbox',dim,'String', const_str,Interpreter='latex',BackgroundColor='w')
grid on
hold on

while t<tmax && std(fitness)>tol
    X_pop_old = X_pop;
    t=t+1;

    [fitness,X_pop,position_pop] = fitness_function(f,g,Population,N_pop,b,Var_limits,t,l_c);

    % Genetic_operators
    selected_pop = selection(fitness,position_pop,size(Population,1),Population,l_c);
    Offsprings_population = crossover(selected_pop,l_c,size(selected_pop,1));
    Offsprings_population = mutation(Offsprings_population,size(Offsprings_population,1),l_c);

    [fitness_offsprings,X_offsprings] = fitness_function(f,g,Offsprings_population,N_pop,b,Var_limits,t+1,l_c);
    [Population_new,Ordered_fitness] = Evolutionary_cycle(Population,N_pop,Offsprings_population,fitness,fitness_offsprings);

    Population = Population_new;
    plot([X_pop_old(1,1),X_pop(1,1)],[X_pop_old(1,2),X_pop(1,2)],'o-r');
    drawnow
end

plot([X_pop_old(1,1),X_pop(1,1)],[X_pop_old(1,2),X_pop(1,2)],'o-k',MarkerFaceColor='k')

[A,I]=sort(fitness,1,'descend');
[fitness,X_pop] = fitness_function(f,g,Population,N_pop,b,Var_limits,t,l_c);

approximate_solution = X_pop(I(1),:)
toc