%*********************************************************************************************
%                                     File: mutation.m                                      
%
% FUNCTION FILE: Operador genético de mutação
%
% Operadores: 
% 1 - flip-bit
% 2 - twors mutation
% 3 - CIM
% 4 - RSM
% 5 - PSM
%*********************************************************************************************

function [offspring_pop] = mutation(offspring_pop,N_pop,l_c,mut)

% Flip-bit
if mut==1
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


% Twors mutation
elseif mut==2 
    for i=1:N_pop
        twors_position=randi([1 l_c],2, 1);
        offspring_pop(i,[twors_position(1) twors_position(2)])=offspring_pop(i,[twors_position(2) twors_position(1)]);
    end 


% Centre inverse mutation (CIM)
elseif mut==3 
    for i=1:N_pop
        prob_mut = rand();
        if prob_mut <= 0.4
            CIM_position=randi([1 l_c]);
            offspring_pop(i,1:CIM_position)=offspring_pop(i,CIM_position:-1:1);
            offspring_pop(i,CIM_position+1:end)=offspring_pop(i,end:-1:CIM_position+1);
        end
    end 

    
% Reverse sequence mutation (RSM)
elseif mut==4 
    for i=1:N_pop
        prob_mut = rand();
        if prob_mut <= 0.4
            RSM_position=sort(randi([1 l_c],2,1),'ascend');
            offspring_pop(i,RSM_position(1):RSM_position(2))=offspring_pop(i,RSM_position(2):-1:RSM_position(1));
        end
    end 


% Partial shuffle mutation (PSM)
else 
    for i=1:N_pop
        PSM_position=zeros(2,l_c);
        for j=1:l_c
            prob_mut = rand();
            if prob_mut <= 0.25 && any(j==PSM_position(2,1:j))==0
                PSM_position(1,j)=j;
                PSM_position(2,j)=randi([1,l_c]);
                while PSM_position(1,j)==PSM_position(2,j) || any(PSM_position(2,j)==PSM_position(2,1:j-1))==1 || (any(PSM_position(2,j)==PSM_position(1:j))==1 && j>1)
                     PSM_position(2,j)=randi([1,l_c]);
                end
            end
        end
         for k=1:l_c
            if PSM_position(1,k)~=0
                offspring_pop(i,[PSM_position(1,k) PSM_position(2,k)])=offspring_pop(i,[PSM_position(2,k) PSM_position(1,k)]);
            end
         end
    end
end