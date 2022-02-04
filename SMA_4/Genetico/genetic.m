%*********************************************************************************************
%                                     File: genetic.m
%
% FUNCTION FILE: genetic algorithm
% CALLS: truss_data, population_generation, fitness_function, crossover, mutation, Evolutionary_cycle, plot_bestfitness, plot_bestfitness_path, plot_pop_evolution, plot_pop_evolution2
%*********************************************************************************************

function [time,X_best,fitness,ff,k,E,rho,h,Aref,P] = genetic(m,f,survivor,mut,parent_selection,cross_type,cross_points)
tic

% Inicializar dados
truss_data

% Gerar população inicial de soluções
[Population, Age]=population_generation(N_pop,l_c,survivor,m);
k=0;

% Cálculo do mérito
pop_final=0; % variável auxiliar de sinalização da última geração
[fitness,X_pop,Population,u_ordered] = fitness_function(Population,N_pop,lb,ub,l_c,ff,g,k);

if m == 1
    % Plot - individuo com melhor fitness em cada geração
    plot_bestfitness(f,ff,lb,ub);
end

while k<kmax && std(fitness)>tol
    
    k=k+1;

    % Guardar geração atual
    X_pop_old = X_pop;

    if m == 1
        pop_evolution(:,:,k) = X_pop;
        std_fitness(k) = std(fitness);
        fobj_best(k) = ff(X_pop(1,1),X_pop(1,2));
        fobj_best2(k) = mean(ff(X_pop(1:5,1),X_pop(1:5,2)));
        violation(k) = u_ordered(1);
        violation2(k) = mean(u_ordered(1:5));
    end
    
    % Operadores genéticos
    Offsprings_population = crossover(l_c,N_pop,fitness,Population,survivor,parent_selection,cross_type,cross_points);
    Offsprings_population = mutation(Offsprings_population,size(Offsprings_population,1),l_c,mut);
    
    %Cálculo do mérito dos indivíduos na população de filhos
    [fitness_offsprings,~,Offsprings_population,u_ordered_offsprings] = fitness_function(Offsprings_population,size(Offsprings_population,1),lb,ub,l_c,ff,g,k+1);

    [fitness,~,Population,u_ordered] = fitness_function(Population,N_pop,lb,ub,l_c,ff,g,k);

    %Seleção de sobreviventes
    [Population_new,fitness_new,Age_new,u_ordered] = Evolutionary_cycle(Population,N_pop,Offsprings_population,fitness,fitness_offsprings,Age,survivor,u_ordered, u_ordered_offsprings);
    Population = Population_new;
    fitness = fitness_new;
    Age = Age_new;

    % Decoding
    X_pop = decoding(Population,N_pop,lb,ub,l_c);

    if m == 1
        % Plot - geração atual
        plot_bestfitness_path(X_pop,X_pop_old,pop_final)
    end

end

% Indivíduo mais "fit" na população final
X_best = X_pop(1,:);

time = toc;

if m == 1
    % Plot - população final
    pop_final=1;
    plot_bestfitness_path(X_pop,X_pop_old,pop_final);
    
    % Plot - evolução das gerações
    pop_evolution(:,:,k+1) = X_pop;
    plot_pop_evolution(pop_evolution,X_pop,k,ff,lb,ub);
    
    % Plot - evolução das gerações - desvio padrão e média
    std_fitness(k+1) = std(fitness);
    fobj_best(k+1) = ff(X_pop(1,1),X_pop(1,2));
    fobj_best2(k+1) = mean(ff(X_pop(1:5,1),X_pop(1:5,2)));
    violation(k+1) = u_ordered(1);
    violation2(k+1) = mean(u_ordered(1:5));
    plot_pop_evolution2(std_fitness,fobj_best,violation,fobj_best2,violation2,k,f);
    
    % Resultados
    if f==1
        fobj=ff(X_best(1),X_best(2));
        fprintf([ ...
                 'Número de gerações: %d\n', ...
                 'Solução Aproximada: [%.5f , %.5f]\n', ...
                 'Valor da função objetivo após otimização: %.4f kg \n\n\n'], ...
                 k,X_best(1),X_best(2),fobj)
    elseif f==2
        fobj=ff(X_best(1),X_best(2));
        fprintf([ ...
                 'Número de gerações: %d\n', ...
                 'Solução Aproximada: [%.5f , %.5f]\n', ...
                 'Valor da função objetivo após otimização: %.4fE-4 m \n\n\n'], ...
                 k,X_best(1),X_best(2),fobj*(1E4))
    elseif f==3
        fobj_1=double(f11(X_best(1),X_best(2)));
        fobj_2=double(f22(X_best(1),X_best(2)));
    
        fprintf([ ...
                 'Número de gerações: %d\n', ...
                 'Solução Aproximada: [%.5f , %.5f]\n', ...
                 'Valor da função objetivo 1 após otimização: %.4f kg \n', ...
                 'Valor da função objetivo 2 após otimização: %.4fE-4 m \n\n\n'], ...
                 k,X_best(1),X_best(2),fobj_1,fobj_2*(1E4))
    end
end