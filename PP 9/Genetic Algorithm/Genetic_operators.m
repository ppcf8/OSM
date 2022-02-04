function Offsprings_population = Genetic_operators(fitness,N_pop,Population,l_c)
%Selection (Roulette)
Selection_prob = fitness/sum(fitness);
roulette=zeros(N_pop,1);
Offsprings_population = zeros(N_pop,l_c);

roulette(1) = Selection_prob(1);
for i=2:N_pop
    roulette(i)=roulette(i-1) + Selection_prob(i);
end

selection = zeros(2,1);
counter=0;


while counter<N_pop
    for i=1:2
        rand_prob = rand;
        parent_position = find(rand_prob<roulette,1);
        if i==1
            selection(i)=parent_position;
        else
            rand_prob = rand;
            parent_position = find(rand_prob<roulette,1);
            selection(i)=parent_position;
            while parent_position==selection(1) %check if there is no repetition for crossover
                rand_prob = rand;
                parent_position = find(rand_prob<roulette,1);
                selection(i)=parent_position;
            end
        end
    end
    %single-point crossover
        parents=[Population(selection(1),:);Population(selection(2),:)];
        k = randi([1 l_c-1]); 
        s=[parents(1,1:k) , parents(2,k+1:l_c); parents(2,1:k) , parents(1,k+1:l_c)]; %offsprings
        counter = counter+1;
        Offsprings_population(counter,:)=s(1,:);
        counter=counter+1;
        Offsprings_population(counter,:)=s(2,:);
end

%Mutation
for i=1:N_pop
    mutation=randi([1,l_c],8,1); %number of mutations and local
    for ii=1:8
        if Offsprings_population(i,mutation(ii))==0
            Offsprings_population(i,mutation(ii)) = 1;
        else
            Offsprings_population(i,mutation(ii)) = 0;
        end
    end
end

