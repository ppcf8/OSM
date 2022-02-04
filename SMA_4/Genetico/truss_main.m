%*********************************************************************************************
%                                     File: truss_main.m
%
% Main script file
% CALLS: genetic
%*********************************************************************************************

addpath([pwd,'\Functions';],[pwd,'\Functions\Plot'],[pwd,'\Functions\Operadores_Geneticos']);
clc
clear
close all

% Selecionar a função objetivo: 1(f1), 2(f2), 3(f3)
f=1; 

% Seleção de mecanismos/operadores genéticos
    % Selecionar o mecanismo de seleção de pais: 1 - roleta, 2 - amostragem estocástica universal, 3 - truncagem, 4 - ordenamento linear, 5 - ordenamento exponencial
    parent_selection=1; 
    
    % Selecionar crossover: 1 - UX Crossover, 2 - 1PX Crossover, 3 - MPX Crossover (definir o número de pontos de corte em cross_points), 4 - SX Crossover
    cross_type=1;
    cross_points=10;
    
    % Selecionar o tipo de mutação: 1 - flip-bit, 2 - twors mutation, 3 - CIM, 4 - RSM, 5 - PSM
    mut=1; 
    
    % Selecionar mecanismos de seleção de sobreviventes: 1 - seleção μ+λ, 2 - seleção(μ,λ) com μ<λ, 3 - substituição do pior, 4 - base na idade
    survivor=1; 

time_total = 0;
X_total = [0,0];
f_total = 0;
fitness_total = 0;
k_total = 0;

for m=1:10
    
    [time,X_best, best_fitness, ff,k,E,rho,h,Aref,P] = genetic(m,f,survivor,mut,parent_selection,cross_type,cross_points);
    time_total = time_total + time;
    X_total = X_total + X_best;
    fitness_total = fitness_total + best_fitness(1);
    k_total = k_total + k;

    if f==1
        error2(m) = abs(ff(X_best(1),X_best(2))-ff(0.657298119464238,0.53356592111935))/ff(0.657298119464238,0.53356592111935);
    elseif f==2
        error2(m) = abs(ff(X_best(1),X_best(2))-ff(0.864531809938658,2.5))/ff(0.864531809938658,2.5);
    elseif f==3
        error2(m) = abs(ff(X_best(1),X_best(2))-ff(0.767953038212338,0.554592449179834))/ff(0.767953038212338,0.554592449179834);
    end
end

time_average = time_total/m;
X_average = X_total/m;
fitness_average = fitness_total/m;
k_average = k_total/m;

if f==1
    f_average = ff(X_average(1),X_average(2));
    error = abs(f_average-ff(0.657298119464238,0.53356592111935))/ff(0.657298119464238,0.53356592111935);
    accuracy = (1-error)*100;
    desvio_padrao = std(error2);

    fprintf([ ...
             'Média de resultados de %d populações iniciais diferentes: \n', ...
             'Número de gerações: %.0f\n', ...
             'Solução Aproximada: [%.5f , %.5f]\n', ...
             'Valor da função objetivo após otimização: %.4f kg \n', ...
             'Valor máximo do Mérito: %.4f \n\n', ...
             'Parâmetros de performance:\n', ...
             'Precisão: %.5f%% \n', ...
             'Desvio Padrão: %.5f \n', ...
             'Elapsed time: %.5fs\n'], ...
             m, k_average, X_average(1),X_average(2),f_average, fitness_average, accuracy, desvio_padrao, time_average)
elseif f==2
    f_average = ff(X_average(1),X_average(2));
    error = abs(f_average-ff(0.864531809938658,2.5))/ff(0.864531809938658,2.5);
    accuracy = (1-error)*100;
    desvio_padrao = std(error2);

    fprintf([ ...
             'Média de resultados de %d populações iniciais diferentes: \n', ...
             'Número de gerações: %.1f\n', ...
             'Solução Aproximada: [%.5f , %.5f]\n', ...
             'Valor da função objetivo após otimização: %.4fE-4 m \n', ...
             'Valor máximo do Mérito: %.4f \n\n', ...
             'Parâmetros de performance:\n', ...
             'Precisão: %.5f%% \n', ...
             'Desvio Padrão: %.5f \n', ...
             'Elapsed time: %.5fs\n'], ...
             m, k_average, X_average(1),X_average(2),f_average*(1E4), fitness_average, accuracy, desvio_padrao, time_average)
elseif f==3
    f11 = 2*rho*h*X_average(2)*sqrt(1+X_average(1)^2)*Aref;
    f22 = (P*h*(1+X_average(1)^2)^1.5*sqrt(1+X_average(1)^4))/(2*sqrt(2)*E*X_average(1)^2*X_average(2)*Aref);
    f_average = ff(X_average(1),X_average(2));
    error = abs(f_average-ff(0.767953038212338,0.554592449179834))/ff(0.767953038212338,0.554592449179834);
    accuracy = (1-error)*100;
    desvio_padrao = std(error2);

    fprintf([ ...
             'Média de resultados de %d populações iniciais diferentes: \n', ...
             'Número de gerações: %d\n', ...
             'Solução Aproximada: [%.5f , %.5f]\n', ...
             'Valor da função objetivo 1 após otimização: %.4f kg \n', ...
             'Valor da função objetivo 2 após otimização: %.4fE-4 m \n', ...
             'Valor máximo do Mérito: %.4f \n\n', ...
             'Parâmetros de performance:\n', ...
             'Precisão: %.5f%% \n', ...
             'Desvio Padrão: %.5f \n', ...
             'Elapsed time: %.5fs\n'], ...
             m, k_average, X_average(1),X_average(2),f11, f22*(1E4), fitness_average, accuracy, desvio_padrao, time_average)
end