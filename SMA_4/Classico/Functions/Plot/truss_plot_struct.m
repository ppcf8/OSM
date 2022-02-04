%*********************************************************************************************
%                                  File: truss_plot_struct.m                                  
%
% FUNCTION FILE: Plot - geometria da estrutura
%*********************************************************************************************

function [xCenter] = truss_plot_struct(X)
% Abrir figura
figure(2);
set(gcf, 'Position',  [100, 100, 1200, 500])

% Plot - estrutura
subplot(1,2,1)
hold on
title('Geometria da Estrutura')
xlabel('$$\bf{x}$$','Interpreter','latex')
ylabel('$$\bf{y}$$','Interpreter','latex')
xlim([-6.35 6.35])
ylim([0 2.54])

fplot(@(x)abs(1/0.1*x),[-6.35 6.35],'r') % limite superior
fplot(@(x)abs(1/2.5*x),[-6.35 6.35],'r') % limite inferior
fplot(@(x)abs(1/X(2)*x),[-6.35 6.35], 'black') % 1º ponto


% Plot - área (secção quadrada)
subplot(1,2,2)
hold on
title('Área da Barra (secção quadrada)')

width = 6.452*10^-4*2; 
xCenter = width/2;  
xLeft = xCenter - width/2;
rectangle('Position', [xLeft, xLeft, width, width], 'EdgeColor', 'red'); % limite superior

width = 6.452*10^-4*0.1; 
xLeft = xCenter - width/2;
rectangle('Position', [xLeft, xLeft, width, width], 'EdgeColor', 'red'); % limite inferior

width = 6.452*10^-4*X(1); 
xLeft = xCenter - width/2;
rectangle('Position', [xLeft, xLeft, width, width], 'EdgeColor', 'black'); % 1º ponto
