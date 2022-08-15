%% population_generation.m                                
% Initial population generation

function [Population]=population_generation(N_pop,l_c)

Population1 = randi([0 1], N_pop, l_c);

% Eliminate Clones
Population = unique(Population1,'rows'); 

while size(Population1,1) > size(Population,1)
    difference = size(Population1,1) - size(Population,1);
    Population_add = randi([0 1], difference, l_c);
    Population1 = [Population; Population_add];
    Population = unique(Population1,'rows');
end