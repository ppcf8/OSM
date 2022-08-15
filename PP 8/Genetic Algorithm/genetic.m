%% genetic.m
% Genetic algorithm
% Calls: truss_data, population_generation, fitness_function, crossover, 
%        mutation, Evolutionary_cycle, plot_bestfitness, 
%        plot_bestfitness_path, plot_pop_evolution, plot_pop_evolution2

function [time,X_best,fitness,f,k] = genetic(m)
tic

% Data Initialization
PP8_data

% Initial Population of solutions generation
[Population]=population_generation(N_pop,l_c);
k=0;

% Fitness Evaluation
pop_final=0;
[fitness,X_pop,Population] = fitness_function(Population,N_pop,lb,ub,l_c,f,g,k);

if m == 1
    % Plot - Fittest Individual for each Generation
    plot_bestfitness(f,lb,ub);
end

while k<kmax && std(fitness)>tol
    
    k=k+1;

    % Save Current Generation
    X_pop_old = X_pop;

    if m == 1
        pop_evolution(:,:,k) = X_pop;
        std_fitness(k) = std(fitness);
        mean_fitness(k) = mean(fitness);
        best_fitness(k) = fitness(1);
    end

    % Genetic Operators
    Offsprings_population = crossover(l_c,N_pop,fitness,Population);
    Offsprings_population = mutation(Offsprings_population,size(Offsprings_population,1),l_c);
    
    % Fitness evaluation of the individuals in the sons' population
    [fitness_offsprings,~,Offsprings_population] = fitness_function(Offsprings_population,size(Offsprings_population,1),lb,ub,l_c,f,g,k+1);

    [fitness,~,Population] = fitness_function(Population,N_pop,lb,ub,l_c,f,g,k);

    % Survivors selection
    [Population_new,fitness_new] = Evolutionary_cycle(Population,N_pop,Offsprings_population,fitness,fitness_offsprings);
    Population = Population_new;
    fitness = fitness_new;
    
    % Decoding
    X_pop = decoding(Population,N_pop,lb,ub,l_c);

    if m == 1
        % Plot - Current Generation
        plot_bestfitness_path(X_pop,X_pop_old,pop_final)
    end

end

% Final Population Fittest Individual
X_best = X_pop(1,:);

time = toc;

if m == 1
    % Plot - Final Population
    pop_final=1;
    plot_bestfitness_path(X_pop,X_pop_old,pop_final);
    
    % Plot - Generations Evolution
    pop_evolution(:,:,k+1) = X_pop;
    plot_pop_evolution(pop_evolution,X_pop,k,f,lb,ub);
    
    % Plot - Generations Evolution - Standard Deviation and Mean
    std_fitness(k+1) = std(fitness);
    mean_fitness(k+1) = mean(fitness);
    best_fitness(k+1) = fitness(1);
    plot_pop_evolution2(std_fitness,mean_fitness,best_fitness,k);
    
    % Results
    fobj=f(X_best(1),X_best(2));
    fprintf(['First Initial Population: \n',...
             'Number of generations: %d\n', ...
             'Approximate Solution: [%.5f , %.5f]\n', ...
             'Objective function value: %.4f \n\n\n'], ...
             k,X_best(1),X_best(2),fobj)
end