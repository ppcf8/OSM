%*********************************************************************************************
%                                     File: evolutionary_cycle.m                                      
%
% FUNTION FILE: Escolha dos sobreviventes
%
% Operadores: 
% 1 - seleção μ+λ
% 2 - seleção(μ,λ) com μ<λ
% 3 - substituição do pior
% 4 - base na idade
%*********************************************************************************************

function [Population_new,fitness_new,Age_new,u_new] = Evolutionary_cycle(Population,N_pop,Offsprings_population,fitness,fitness_offsprings,Age,survivor, u_ordered, u_ordered_offsprings)

Age_new=0;

%Seleção por substituição com base no mérito
% seleção μ+λ
if survivor == 1
    Natural_selection = [Population; Offsprings_population];
    Natural_selection_fitness = [fitness; fitness_offsprings];
    
    [Ordered_fitness,I] = sort(Natural_selection_fitness,1,'descend');
    Population_new = Natural_selection(I(1:N_pop),:);
    fitness_new = Ordered_fitness(1:N_pop);

    Natural_selection_u = [u_ordered; u_ordered_offsprings];
    u_new = Natural_selection_u(I(1:N_pop));

% seleção(μ,λ) com μ<λ (Elitismo - preservar 3 melhores)
elseif survivor == 2
    Population_new = Population;
    fitness_new = fitness;

    fitness_new(4:N_pop) = fitness_offsprings(1:N_pop-3);
    Population_new(4:N_pop,:) = Offsprings_population(1:N_pop-3,:);

    [Ordered_fitness,I] = sort(fitness_new,1,'descend');
    Population_new = Population_new(I(1:N_pop),:);
    fitness_new = Ordered_fitness(1:N_pop);

    u_new(4:N_pop) = u_ordered_offsprings(1:N_pop-3,:);
    u_new = u_new(I(1:N_pop));

% substituição do pior
elseif survivor == 3
    Population_new = Population;
    fitness_new = fitness;
    Offsprings_Size = size(Offsprings_population,1);

    Population_new((N_pop-Offsprings_Size+1):N_pop,:) = Offsprings_population;
    fitness_new((N_pop-Offsprings_Size+1):N_pop,:) = fitness_offsprings;

    [Ordered_fitness,I] = sort(fitness_new,1,'descend');
    Population_new = Population_new(I(1:N_pop),:);
    fitness_new = Ordered_fitness(1:N_pop);

    u_new = u_ordered;
    u_new((N_pop-Offsprings_Size+1):N_pop,:) = u_ordered_offsprings;
    u_new = u_new(I(1:N_pop));
    
% Seleção por substituição com base na idade
elseif survivor == 4
    [~,I] = sort(Age,1,'descend');
    Population_new = Population;
    fitness_new = fitness;
    Offsprings_Size = size(Offsprings_population,1);

    Population_new(I(1:Offsprings_Size),:) = Offsprings_population;
    fitness_new(I(1:Offsprings_Size)) = fitness_offsprings;
    Age_new(I(1:Offsprings_Size)) = 0;
    Age_new = Age + 1;

    [Ordered_fitness,I] = sort(fitness_new,1,'descend');
    Population_new = Population_new(I(1:N_pop),:);
    fitness_new = Ordered_fitness(1:N_pop);
    Age_new = Age_new(I(1:N_pop));
    
    % Elitismo - manter os 3 melhores pais
    Population_new(N_pop-2:N_pop,:) = Population(1:3,:);
    fitness_new(N_pop-2:N_pop) = fitness(1:3);
    Age_new(N_pop-2:N_pop) = 1;
    [Ordered_fitness,I] = sort(fitness_new,1,'descend');
    Population_new=Population_new(I(1:N_pop),:);
    fitness_new = Ordered_fitness(1:N_pop);
    Age_new = Age_new(I(1:N_pop));

    u_new = u_ordered;
    u_new(I(1:Offsprings_Size),:) = u_ordered_offsprings;
    u_new = u_new(I(1:N_pop));
    u_new(N_pop-2:N_pop) = u_ordered(1:3);
    u_new = u_new(I(1:N_pop));
end

