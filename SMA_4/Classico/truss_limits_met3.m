%*********************************************************************************************
%                                File: truss_limits_met3.m                                 
%
% SCRIPT FILE: Definição do 3º método de verificação das restrições geométricas
%*********************************************************************************************

if X(1)<lb(1)
    X(1)= lb(1);
elseif X(1)>ub(1)
    X(1)=ub(1);
end

if X(2)<lb(2) 
    X(2)= lb(2);
elseif X(2)>ub(2) 
    X(2)=ub(2);
end

