function [KKT, KKT_norm,flag]=KKT_fun(X,lambda,miu,grad_f,grad_h,grad_g,gx1x2)
%*********************************************************************************************
%                                 File: truss_KKT_function.m                                 
%
% SCRIPT FILE: Define the Karush-Kuhn-Tucker function
%*********************************************************************************************
flag = false;
KKT = grad_f(X(1),X(2)) + miu.'*grad_h(X(1),X(2)) + lambda.'*grad_g(X(1),X(2));
KKT_norm = norm(KKT);

if KKT_norm<1e-06 && lambda'*gx1x2(X(1),X(2))<1e-06
    flag = true;
end