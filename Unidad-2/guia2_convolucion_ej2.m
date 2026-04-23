clc;  clear all;

% Definicion de señales de ejemplo (N muestras)
x = [1, 2, 2];
h = [2, 1, 0.5];

% Llamada a la función
resultado = convolucion_circular(x, h);

disp("Señal x:"); disp(x);
disp("Señal h:"); disp(h);
disp("Resultado Manual Circular:"); disp(resultado);

% Grafico
figure(1);
% En convolución circular, la salida tiene exactamente el mismo largo N
vector_n = 0 : length(x)-1;

subplot(1,1,1);
stem(vector_n, resultado, 'b', 'filled');
title('Convulucion Circular'); grid on;

% -------------------------------------------------------------------------------
% Paso 1: k = 1
% h fija: [2,  1,  0.5]
% x rotada 0: [1,  2,  2]
% y[1] = (2 * 1) + (1 * 2) + (0.5 * 2)
% y[1] = 2 + 2 + 1 = 5

% Paso 2: k = 2
% h fija: [2,  1,  0.5]
% x rotada 1: [2,  1,  2] (el ultimo 2 de x pasa al frente)
% y[2] = (2 * 2) + (1 * 1) + (0.5 * 2)
% y[2] = 4 + 1 + 1 = 6

% Paso 3: k = 3
% h fija: [2,  1,  0.5]
% x rotada 2: [2,  2,  1] (vuelve a rotar el ultimo al frente)
% y[3] = (2 * 2) + (1 * 2) + (0.5 * 1)
% y[3] = 4 + 2 + 0.5 = 6.5

% RESULTADO FINAL:
% y_circular = [5, 6, 6.5]
