%*********************************************************************************************
%                                     File: plot_pop_evolution2.m
%
% FUNCTION FILE: Plot evolução dos parâmetros das gerações
%*********************************************************************************************

function [fig] = plot_pop_evolution2(std_fitness,fobj_best,violation,fobj_best2,violation2,k,f)

% Abrir figura
fig = figure(3);
set(gcf, 'Position',  [100, 100, 1400, 400])

% Desvio padrão
subplot(1,3,1) 
semilogy(0:k, std_fitness,'color','#84cb56','LineWidth',2)
xlim([0 k])
title('Todos os indiv\''iduos','Interpreter','latex')
xlabel('Gera\c{c}\~ao','Interpreter','latex')
legend('Desvio Padr\~ao do M\''erito','Interpreter','latex','Location', 'northeast')


% Melhor indivíduo
subplot(1,3,2)
colororder({'#465bf9','#ed2a2a'})
yyaxis left
plot(0:k,fobj_best,'color','#465bf9','LineWidth',2) % Plot função objetivo
if f == 1
    ylim([0 (max(fobj_best)+3)])
end

yyaxis right
semilogy(0:k,violation,'color','#ed2a2a','LineWidth',2) % Plot violação das restrições
xlim([0 k])
title('Melhor indiv\''iduo','Interpreter','latex')
xlabel('Gera\c{c}\~ao','Interpreter','latex')
legend('Fun\c{c}\~ao Objetivo','Viola\c{c}\~ao Restri\c{c}\~oes','Interpreter','latex','Location','northeast')


% Média 5 melhores indivíduos
subplot(1,3,3) 
colororder({'#465bf9','#ed2a2a'})
yyaxis left
plot(0:k,fobj_best2,'color','#465bf9','LineWidth',2) % Plot função objetivo
if f == 1
    ylim([0 (max(fobj_best)+3)])
end

yyaxis right
semilogy(0:k,violation2,'color','#ed2a2a','LineWidth',2) % Plot violação das restrições
xlim([0 k])
title('M\''edia - 5 melhores indiv\''iduos','Interpreter','latex')
xlabel('Gera\c{c}\~ao','Interpreter','latex')
legend('Fun\c{c}\~ao Objetivo','Viola\c{c}\~ao Restri\c{c}\~oes','Interpreter','latex','Location','northeast')












