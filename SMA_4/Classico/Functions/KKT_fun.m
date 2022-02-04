%*********************************************************************************************
%                                 File: truss_KKT_function.m                                 
%
% FUCNTION FILE: Condições Karush-Kuhn-Tucker
%*********************************************************************************************

function [KKT, KKT_norm,flag]=KKT_fun(X,lambda,difx1_f1,difx2_f1,difx1_c,difx2_c,c_x1x2)

flag = false;
KKT_x1 = difx1_f1(X(1),X(2)) + lambda'*difx1_c(X(1),X(2));
KKT_x2 = difx2_f1(X(1),X(2)) + lambda'*difx2_c(X(1),X(2));
KKT = double([KKT_x1; KKT_x2]);
KKT_norm =norm(KKT);

if KKT_norm<1e-06 && lambda'*c_x1x2(X(1),X(2))<1e-06
    flag = true;
end