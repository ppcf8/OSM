%% crossover.m                                      
% Crossover operator
% Calls: selection

function [offspring_pop] = crossover(l_c,N_pop,fitness,population)

offspring_pop = zeros(N_pop,l_c);
son1 = zeros(1,l_c);
son2 = zeros(1,l_c);
roulette=0;

for i=1:N_pop/2
    % Parent Selection
    [parent1, parent2,roulette] = selection(fitness,N_pop,population,i,roulette);

    % Mask
    mask = randi([0,1],1,l_c); 
    
    for j=1:l_c
        if mask(j) == 0
            son1(j) = parent1(j);
            son2(j) = parent2(j);
        else
            son1(j) = parent2(j);
            son2(j) = parent1(j);
        end
    end

    offspring_pop(i*2-1,:) = son1; % Son 1
    offspring_pop(i*2,:) = son2;   % Son 2
end

