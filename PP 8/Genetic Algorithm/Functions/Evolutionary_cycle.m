%% Evolutionary_cycle.m                                      
% Survivors Selection

function [Population_new,fitness_new] = Evolutionary_cycle(Population, ...
          N_pop,Offsprings_population,fitness,fitness_offsprings)

% Selection (Fitness)
Natural_selection = [Population; Offsprings_population];
Natural_selection_fitness = [fitness; fitness_offsprings];

[Ordered_fitness,I] = sort(Natural_selection_fitness,1,'descend');
Population_new=Natural_selection(I(1:N_pop),:);
fitness_new = Ordered_fitness(1:N_pop);


