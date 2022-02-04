%*********************************************************************************************
%                                     File: selection.m                                      
%
% FUNCTION FILE: Operador genético de seleção dos progenitores
%
% Operadores: 
% 1 - roleta
% 2 - amostragem estocástica universal
% 3 - truncagem
% 4 - ordenamento linear
% 5 - ordenamento exponencial
%*********************************************************************************************

function [parent1, parent2, roulette, selection_values] = selection(fitness,N_pop,population,i, roulette, selection_values, parent_selection, N_pop_offspring)

% Roleta
if parent_selection==1
    if i == 1 % basta correr na 1º iteração
        % Probabilidade de seleção de cada indíviduo
        selection_prob = fitness/sum(fitness);
        
        % Definição dos respetivos intervalos na roleta
        roulette=zeros(N_pop,1);
        roulette(1) = selection_prob(1);
        for i=2:N_pop
            roulette(i)=roulette(i-1) + selection_prob(i);
        end
    end
    % Selecionar 1º progenitor
    selection_value = rand();
    parent_position1 = find(selection_value<roulette,1);
    parent1 = population(parent_position1,:);
    
    % Selecionar 2º progenitor
    selection_value = rand();
    parent_position2 = find(selection_value<roulette,1);
    
    while parent_position2==parent_position1
    selection_value = rand();
    parent_position2 = find(selection_value<roulette,1);
    end
    parent2 = population(parent_position2,:);


% Amostragem estocástica universal   
elseif parent_selection==2
    if i == 1 % basta correr na 1º iteração
        % Probabilidade de seleção de cada indíviduo
        selection_prob = fitness/sum(fitness);
            
        % Definição dos respetivos intervalos na roleta
        roulette=zeros(N_pop,1);
        roulette(1) = selection_prob(1);
        for j=2:N_pop
            roulette(j)=roulette(j-1) + selection_prob(j);
        end
    
        % Selecionar progenitores
        distribution = 1/N_pop_offspring;
        selection_values(1) = rand()*distribution;
        
        for j=1:N_pop_offspring-1
            selection_values(j+1) = selection_values(1) + distribution*j;
        end
    end

    % Selecionar 1º progenitor
    parent_position1 = find(selection_values(i*2-1)<roulette,1);
    parent1 = population(parent_position1,:);
    
    % Selecionar 2º progenitor
    parent_position2 = find(selection_values(i*2)<roulette,1);
    parent2 = population(parent_position2,:);


% Truncagem
elseif parent_selection==3
    T=0.4; %percentagem de truncamento
    parent_position=randi([1,round(T*N_pop)],1,2);

    % Selecionar 1º progenitor
    parent_position1 = parent_position(1);
    parent1 = population(parent_position1,:);

    % Selecionar 2º progenitor
    parent_position1 = parent_position(2);
    parent2 = population(parent_position1,:); 


% Ordenamento linear    
elseif parent_selection==4
    % Parametrização
    MAX=1.7;
    MIN=0.3;
    rank=(N_pop:-1:1);
    selection_prob = 1/N_pop*(MIN+(MAX-MIN)*(rank-1)/(N_pop-1));
    lin_ranking=zeros(N_pop,1);
        lin_ranking(1) = selection_prob(1);
        for i=2:N_pop
            lin_ranking(i)=lin_ranking(i-1) + selection_prob(i);
        end

    % Selecionar 1º progenitor
    selection_value = rand();
    parent_position1 = find(selection_value<lin_ranking,1);
    parent1 = population(parent_position1,:);
    
    % Selecionar 2º progenitor
    selection_value = rand();
    parent_position2 = find(selection_value<lin_ranking,1);
    
    while parent_position2==parent_position1
    selection_value = rand();
    parent_position2 = find(selection_value<lin_ranking,1);
    end
    parent2 = population(parent_position2,:);


% Ordenamento exponencial
else
    % Parametrização
    rank=(N_pop:-1:1);
    c=0.98;
    selection_prob = c.^(N_pop-rank)/(sum(c.^(N_pop-rank)));
    exp_ranking=zeros(N_pop,1);
    exp_ranking(1) = selection_prob(1);
    for i=2:N_pop
        exp_ranking(i)=exp_ranking(i-1) + selection_prob(i);
    end
    
    % Selecionar 1º progenitor
    selection_value = rand();
    parent_position1 = find(selection_value<exp_ranking,1);
    parent1 = population(parent_position1,:);
    
    % Selecionar 2º progenitor
    selection_value = rand();
    parent_position2 = find(selection_value<exp_ranking,1);
    
    while parent_position2==parent_position1
    selection_value = rand();
    parent_position2 = find(selection_value<exp_ranking,1);
    end
    parent2 = population(parent_position2,:);
end

