%% GA_main.m
% Main script of the GA
% Calls: genetic

addpath([pwd,'\Functions';],[pwd,'\Functions\Plot'],[pwd,'\Functions\Genetic_Operators']);
clc
clear
close all

time_total = 0;
X_total = [0,0];
f_total = 0;
fitness_total = 0;
k_total = 0;

for m=1:10
    [time,X_best, best_fitness,f,k] = genetic(m);
    time_total = time_total + time;
    X_total = X_total + X_best;
    fitness_total = fitness_total + best_fitness(1);
    k_total = k_total + k;

end

time_average = time_total/m;
X_average = X_total/m;
fitness_average = fitness_total/m;
k_average = k_total/m;


% Results Print
f_average = f(X_average(1),X_average(2));
error = abs((f_average-f(5/3,1/3))/f(5/3,1/3));
accuray = (1-error)*100;

fprintf([ ...
         'Average results of %i different initial  populations: \n', ...
         'Number of generations: %.0f\n', ...
         'Approximate Solution: [%.5f , %.5f]\n', ...
         'Objective function value: %.4f \n', ...
         'Maximum fitness value: %.4f \n', ...
         'Precision: %.5f%% \n', ...
         'Average time: %.4fs\n'], ...
         m, k_average, X_average(1),X_average(2),f_average, fitness_average, accuray, time_average)