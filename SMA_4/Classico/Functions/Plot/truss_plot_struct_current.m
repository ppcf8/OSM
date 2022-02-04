%*********************************************************************************************
%                              File: truss_plot_struct_current.m                            
%
% FUNCTION FILE: Plot - geometria da estrutura atual
%*********************************************************************************************

function [fig] = truss_plot_struct_current(X,xCenter,last)
fig = figure(2);

% Plot - estrutura
subplot(1,2,1)
fplot(@(x)abs(1/X(2)*x),[-6.35 6.35], 'k--')

% Plot - área (secção quadrada)
subplot(1,2,2)
width = 6.452*10^-4*X(1); 
xLeft = xCenter - width/2;
rectangle('Position', [xLeft, xLeft, width, width], 'EdgeColor', 'black','LineStyle','--')

if last==1 % ponto ótimo
    % Plot - estrutura
    subplot(1,2,1)
    fplot(@(x)abs(1/X(2)*x),[-6.35 6.35], 'blue','linewidth',2)
    
    % Plot - área (secção quadrada)
    subplot(1,2,2)
    width = 6.452*10^-4*X(1); 
    xLeft = xCenter - width/2;
    rectangle('Position', [xLeft, xLeft, width, width], 'EdgeColor', 'blue','linewidth',2);
end