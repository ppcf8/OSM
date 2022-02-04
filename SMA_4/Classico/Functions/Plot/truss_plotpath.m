%*********************************************************************************************
%                                   File: truss_plotpath.m                                   
%
% FUNCTION FILE: Plot - direção de pesquisa atual
%*********************************************************************************************

function [fig] = truss_plotpath(X,X_old,f1_x1x2)
fig = figure(1);

% Coordenadas da direção de pesquisa
x_coord = [X_old(1) X(1)];
y_coord = [X_old(2) X(2)];

% Plot 2D
subplot(1,2,1)
plot(x_coord, y_coord,'black-*',LineWidth=1)

% Plot 3D
subplot(1,2,2)
plot3(x_coord, y_coord,f1_x1x2(x_coord,y_coord),'black-*',LineWidth=2)