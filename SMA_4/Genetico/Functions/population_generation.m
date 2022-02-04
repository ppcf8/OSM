%*********************************************************************************************
%                                File: population_generation.m                                
%
% SCRIPT FILE: Gerar população inicial de soluções
%*********************************************************************************************

function [Population,Age]=population_generation(N_pop,l_c,survivor,m)

%rng(m)
Population1 = randi([0 1], N_pop, l_c);
Age=0;

% eliminar clones
Population = unique(Population1,'rows'); 

while size(Population1,1) > size(Population,1)
    difference = size(Population1,1) - size(Population,1);
    Population_add = randi([0 1], difference, l_c);
    Population1 = [Population; Population_add];
    Population = unique(Population1,'rows');
end

if survivor == 4
    Age = randi([1 10], N_pop, 1);
end