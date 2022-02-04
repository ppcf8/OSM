%*********************************************************************************************
%                                     File: truss_plot.m
%
% FUNCTION FILE: Plot da função objetivo em 2D e 3D
%*********************************************************************************************

function [fig] = truss_plot(f,f1_x1x2)
% Abrir figura
fig = figure(1);
set(gcf, 'Position',  [100, 100, 1200, 500])

% Plot 2D
subplot(1,2,1)
fcontour(f1_x1x2,Fill='on')
xlabel('$$\bf{x_1}$$','Interpreter','latex')
ylabel('$$\bf{x_2}$$','Interpreter','latex')
xlim([0.1 2])
ylim([0.1 2.5])
if f==1
    title('$$\bf{f_1(x) = 2 \, {\rho} \, h \, x_2 \, \sqrt{1+x_1^2} \, A_{ref}}$$','Interpreter','latex')
elseif f==2
    title('$$\bf{f_2(x) = \frac{{\rho} \, h \, (1+x_1^2)^{1,5} \, \sqrt{1+x_1^4}}{2 \, \sqrt{2} \, E \, x_1^2 \, x_2 \, A_{ref}} }$$','Interpreter','latex')
end
colorbar
grid on
axis equal
hold on

% Plot 3D
x_limits = [0.1 2];
y_limits = [0.1 2.5];
subplot(1,2,2)
numPoints=100;
xPoints = linspace(x_limits(1),x_limits(2), numPoints);
yPoints = linspace(y_limits(1),y_limits(2), numPoints);
[x, y] = meshgrid(xPoints, yPoints);
z=f1_x1x2(x,y);
mesh(x, y, z);
xlabel('$$\bf{x_1}$$','Interpreter','latex')
ylabel('$$\bf{x_2}$$','Interpreter','latex')
xlim(x_limits)
ylim(y_limits)
if f==1
    title('$$\bf{f_1(x) = 2 \, {\rho} \, h \, x_2 \, \sqrt{1+x_1^2} \, A_{ref}}$$','Interpreter','latex')
elseif f==2
    title('$$\bf{f_2(x) = \frac{{\rho} \, h \, (1+x_1^2)^{1,5} \, \sqrt{1+x_1^4}}{2 \, \sqrt{2} \, E \, x_1^2 \, x_2 \, A_{ref}} }$$','Interpreter','latex')
end
hold on


