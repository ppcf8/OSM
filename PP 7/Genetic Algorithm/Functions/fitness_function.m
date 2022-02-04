%% fitness_function.m                                  
% Fitness Function
% Calls: decoding

function [fitness,X_real_ordered,population_ordered] = fitness_function(population,N_pop,lb,ub,l_c,f)

% Decoding
X_real = decoding(population,N_pop,lb,ub,l_c);

% Fitness evaluation
fitness=-f(X_real(:,1),X_real(:,2));

% Sorted Population (descend)
[fitness,position_pop]=sort(fitness,'descend');
X_real_ordered = X_real(position_pop,:);
population_ordered = population(position_pop,:);
end


