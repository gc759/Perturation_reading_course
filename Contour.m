clear
close all

u = linspace(-2, 2, 1000);
v = linspace(-2, 2, 500);
[U, V] = meshgrid(u, v);
T = U + 1i*V;

% Phi function 
x = 5;
phifunc = @(t) x*(t+1i*t-t.^2/2);
phi = phifunc(T);

[C, h] = contourf(real(T), imag(T), real(phi - phifunc(1/2)), 50);
hold on
[C, h] = contour(real(T), imag(T), imag(phi), 50);
[C, h] = contour(real(T), imag(T), imag(phi - phifunc(0)), [0, 0], 'g', 'LineWidth', 2);
[C, h] = contour(real(T), imag(T), imag(phi - phifunc(1/2)), [0, 0], 'm', 'LineWidth', 2);
[C, h] = contour(real(T), imag(T), imag(phi - phifunc(1)), [0, 0], 'b', 'LineWidth', 2);