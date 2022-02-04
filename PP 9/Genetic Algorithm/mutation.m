%*********************************************************************************************
%                                     File: mutation.m                                      
%
% FUNTION FILE: Operador genético de mutação
%*********************************************************************************************

function [offspring_pop] = mutation(offspring_pop,N_pop,l_c)

for i=1:N_pop
    for j=1:l_c
        prob_mut = rand();
        if prob_mut <= 0.01
            
            if offspring_pop(i,j)==0
                offspring_pop(i,j) = 1;
            else
                offspring_pop(i,j) = 0;
            end
        end
    end
end