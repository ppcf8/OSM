%*********************************************************************************************
%                                     File: crossover.m                                      
%
% FUNTION FILE: Operador genético de cruzamento
%*********************************************************************************************

function [offspring_pop] = crossover(selected_pop,l_c,N_pop)

for i=1:N_pop/2
     % Escolher progenitores
    select_p1 = randi([1,N_pop]); % Escolher progenitor 1
    select_p2 = randi([1,N_pop]); % Escolher progenitor 2

    %while select_p1 == select_p2 % Escolher progenitor 1 diferente do progenitor 2
    %    select_p2 = randi([1,N_pop]);
    %end

    parent1 = selected_pop(select_p1,:);
    parent2 = selected_pop(select_p2,:);
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

    offspring_pop(i*2-1,:) = son1;
    offspring_pop(i*2,:) = son2;
end

