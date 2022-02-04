%*********************************************************************************************
%                                  File: fitness_function.m                                  
%
% FUNTION FILE: Definição da função de mérito
% CALLS: decoding
%*********************************************************************************************

function [fitness,X_real_ordered,population_ordered,u_ordered] = fitness_function(population,N_pop,lb,ub,l_c,f,g,k)

% Parametrização
C = 0.5;
alfa = 3;
beta = 2;

% Descodificação das variáveis
X_real = decoding(population,N_pop,lb,ub,l_c);

% Medida da violação das restrições
u=max(0,g(X_real(:,1),X_real(:,2)));

% Avaliação das iterações
Aval = f(X_real(:,1),X_real(:,2)) + ((C*(k))^alfa)*sum(u.^beta,2);
fitness = 1./Aval;

% Ordenação decrescente da população
[fitness,position_pop]=sort(fitness,'descend');
X_real_ordered = X_real(position_pop,:);
population_ordered = population(position_pop,:);
u_ordered=u(position_pop);

end


