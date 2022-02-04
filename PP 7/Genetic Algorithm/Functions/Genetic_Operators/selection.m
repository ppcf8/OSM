%% selection.m                                      
% Selection Operator

function [parent1, parent2, roulette] = selection(fitness,N_pop,population,i, roulette)

if i == 1 
    % Selection probability for each individual
    selection_prob = fitness/sum(fitness);
    
    % Roulette intervals
    roulette=zeros(N_pop,1);
    roulette(1) = selection_prob(1);
    for i=2:N_pop
        roulette(i)=roulette(i-1) + selection_prob(i);
    end
end

% Select first parent
selection_value = rand();
parent_position1 = find(selection_value<roulette,1);
parent1 = population(parent_position1,:);

% Select second parent
selection_value = rand();
parent_position2 = find(selection_value<roulette,1);

while parent_position2==parent_position1
selection_value = rand();
parent_position2 = find(selection_value<roulette,1);
end

parent2 = population(parent_position2,:);
