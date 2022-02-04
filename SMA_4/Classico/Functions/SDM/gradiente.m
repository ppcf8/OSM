%*********************************************************************************************
%                               File: gradiente.m                             
%
% FUNCTION FILE: Direção de pesquisa - Método do Gradiente
%*********************************************************************************************

function [d] = gradiente(X,grad_La)

d = -double(grad_La(X(1),X(2)));