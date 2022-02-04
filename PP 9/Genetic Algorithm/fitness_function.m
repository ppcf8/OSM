function [fitness,X_pop,position_pop] = fitness_function(f,g,population,N_pop,b,Var_limits,t,l_c)
    
    % Decoding
    fitness=zeros(N_pop,1);
    X_pop=zeros(N_pop,2);
    for a=1:N_pop
        X_bin=zeros(2,1);
        X=zeros(2,1);
        for i=1:2
            for ii=1:b(1)
                if i==1
                    X_bin(i) = X_bin(i)+population(a,ii)*2^(ii-1);
                    X(i) = Var_limits(i,1) + (Var_limits(i,2)-Var_limits(i,1))/(2^b(i)-1)*X_bin(i);
                else
%                     X_bin(i) = X_bin(i)+population(a,ii+50)*2^(ii-1);
                    X_bin(i) = X_bin(i)+population(a,ii+l_c/2)*2^(ii-1);
                    X(i) = Var_limits(i,1) + (Var_limits(i,2)-Var_limits(i,1))/(2^b(i)-1)*X_bin(i);
                end
            end
        end
        
        % Dynamic penalties
        C_fitness = 0.5;
        alfa_fitness = 2;
        beta_fitness = 2;

        mu=zeros(length(g(X(1),X(2))),1);
        aux=(g(X(1),X(2)));
        for i=1:length(g(X(1),X(2)))
            if aux(i)>0
                mu(i)=aux(i);
            end
        end
        fitness(a) = 1/(f(X(1),X(2))+((C_fitness*t)^alfa_fitness)*sum(mu.^beta_fitness));
        X_pop(a,:) = X;
    end
    [~,position_pop]=sort(fitness,'descend');
end