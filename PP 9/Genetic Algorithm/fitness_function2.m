%*********************************************************************************************
%                                  File: fitness_function.m                                  
%
% FUNTION FILE: Definição da função de mérito
% CALLS: decoding
%*********************************************************************************************

function [Mer,position_pop] = fitness_function(population,N_pop,lb,ub,l_c,f1_x1x2,c_x1x2,k)

% Parametrização
C = 0.5;%%%%%%%%%%%%%%%%
alfa = 2;%%%%%%%%%%%%%%%%%%%%%%%
beta = 2;%%%%%%%%%%%%%%%%%%%%%%%%%

% Descodificação das variáveis
X_real = decoding(population,N_pop,lb,ub,l_c);

% Medida da violação das restrições
u=max(0,c_x1x2(X_real(:,1),X_real(:,2)));

% Avaliação das iterações
Aval = f1_x1x2(X_real(:,1),X_real(:,2)) + (C*k)*alfa*sum(u.^beta,2);
F = 1./Aval;

% Ordenação decresecente da população
[F_sorted,position_pop]=sort(F,'descend');

% Função de Mérito
Mer=zeros(N_pop,1);
for i=1:N_pop
    Mer(i) = F_sorted(end)+(F_sorted(1)-F_sorted(end))/(N_pop-1)*(N_pop-i);
end


