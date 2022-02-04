%*********************************************************************************************
%                                     File: crossover.m                                      
%
% FUNTION FILE: Operador genético de cruzamento
% CALLS: selection
%
% Operadores: 
% 1 - UX Crossover 
% 2 - 1PX Crossover
% 3 - MPX Crossover (definir o números de pontos de crossover em cross_points)
% 4 - SX Crossover
%*********************************************************************************************

function [offspring_pop] = crossover(l_c,N_pop,fitness,population,survivor,parent_selection,cross_type,cross_points)

% Selecionar número de filhos
if survivor == 1
    N_pop_offspring = N_pop;
elseif survivor == 4 || survivor == 3
    N_pop_offspring = 8;
elseif survivor == 2
    N_pop_offspring = N_pop*1.5;
end


% Inicializar variáveis
offspring_pop = zeros(N_pop_offspring,l_c);
son1 = zeros(1,l_c);
son2 = zeros(1,l_c);
roulette=0;
selection_values=0;

ps=0.5; %For CX crossover
    
for i=1:N_pop_offspring/2
    % Escolher progenitores
    [parent1, parent2,roulette,selection_values] = selection(fitness,N_pop,population,i,roulette,selection_values,parent_selection,N_pop_offspring);

    % UX Crossover
    if cross_type==1
        mask = randi([0,1],1,l_c); % Máscara

        for j=1:l_c
            if mask(j) == 0
                son1(j) = parent1(j);
                son2(j) = parent2(j);
            else
                son1(j) = parent2(j);
                son2(j) = parent1(j);
            end
        end


    % 1PX Crossover
    elseif cross_type==2
        k = randi([1, l_c-1]); % Ponto de Corte

        for j=1:k
            son1(j)=parent1(j);
            son2(j)=parent2(j);
        end

        for j=k+1:l_c
            son1(j)=parent2(j);
            son2(j)=parent1(j);
        end


    % MPX Crossover
    elseif cross_type==3
        k_rnd = randi([1, l_c-1],1,cross_points); % Pontos de Corte

        % eliminar clones
        k = unique(k_rnd); 
        while size(k_rnd,2) > size(k,2)
            difference = size(k_rnd,2) - size(k,2);
            k_add = randi([1, l_c-1],1, difference);
            k_rnd = [k k_add];
            k = unique(k_rnd);
        end
        k = sort(k);

        cutswitch=1;
        for j=1:l_c
            if any(k==j)
                cutswitch= -cutswitch;
            end

            if cutswitch==1
                son1(j)=parent2(j);
                son2(j)=parent1(j);
            else
                son1(j)=parent1(j);
                son2(j)=parent2(j);
            end
        end


    % SX Crossover
    elseif cross_type==4
        cutswitch=1;
        for j=1:l_c
            u = rand();
            if u<=ps
                cutswitch=-cutswitch;
            end

            if cutswitch==1
                son1(j)=parent2(j);
                son2(j)=parent1(j);
            else
                son1(j)=parent1(j);
                son2(j)=parent2(j);
            end
        end
    end

    offspring_pop(i*2-1,:) = son1; % Filho 1
    offspring_pop(i*2,:) = son2;   % Filho 2
end