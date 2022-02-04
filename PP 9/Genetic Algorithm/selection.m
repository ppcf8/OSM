%*********************************************************************************************
%                                     File: selection.m                                      
%
% FUNTION FILE: Operador genético de seleção
%*********************************************************************************************

function [selected_pop] = selection(Mer,position_pop,N_pop,population,l_c)

% Probabilidade de seleção de cada indíviduo
selection_prob = Mer/sum(Mer);

% Definição dos respetivos intervalos na roleta
roulette=zeros(N_pop,1);
roulette(1) = selection_prob(1);
for i=2:N_pop
    roulette(i)=roulette(i-1) + selection_prob(i);
end

% Seleção dos índiviuos
selected_pop=zeros(N_pop,l_c);
for i=1:N_pop
    selection_value = rand();
    parent_position = find(selection_value<roulette,1);
    selected_pop(i,:) = population(position_pop(parent_position),:);
end
