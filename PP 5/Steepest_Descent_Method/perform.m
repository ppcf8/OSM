delta=0.6512;
gamma=0.0968;
c=0.9672;
i=0;

while 0<=delta && delta<1
    i=i+1
    PP5_main
    delta_iter(i,:)=[t delta];
%     fprintf('Delta =  %d \n',delta)
%     fprintf('---------------------- \n')
    delta=delta+0.01;
end
[M,I]=min(delta_iter(:,1));
delta=delta_iter(I,2);