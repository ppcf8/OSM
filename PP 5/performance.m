tic
clc
clear
delta_1=linspace(1-0.01,0.01,500);
gamma_1=0.1;
c_1=linspace(1,0.01,500);

comb=cartprod(delta_1,gamma_1,c_1);

iter_table=zeros(size(comb,1),4);
for i=1:size(comb,1)
    delta = comb(i,1);
    gamma = comb(i,2);
    c     = comb(i,3);

    PP5_main
    iter_table(i,:)=[t comb(i,:)];
    i
end

[M,I]=min(iter_table(:,1))
disp(comb(I,:))
toc