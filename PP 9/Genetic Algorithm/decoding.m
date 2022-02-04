%*********************************************************************************************
%                                       File: decoding.m                                       
%
% FUNTION FILE: Descodificação dos genótipos (bits) para os fenótipos (real)
%*********************************************************************************************


function [X_real] = decoding(population,N_pop,lb,ub,l_c)

X_bin=zeros(N_pop,2);
X_real=zeros(N_pop,2);

for i=1:N_pop
    for j=1:l_c/2
        %x1
        X_bin(i,1) = X_bin(i,1)+population(i,j)*2^(l_c/2-j);

        %x2
        X_bin(i,2) = X_bin(i,2)+population(i,j+l_c/2)*2^(l_c/2-j);
    end
end

for i=1:N_pop
    %x1
    X_real(i,1) = lb(1)+(ub(1)-lb(1))/(2^(l_c/2) - 1)*X_bin(i,1);

    %x2
    X_real(i,2) = lb(2)+(ub(2)-lb(2))/(2^(l_c/2) - 1)*X_bin(i,2);
end