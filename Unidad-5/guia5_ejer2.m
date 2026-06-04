clc; clear all; close all;
pkg load signal

fm = 10000; % Frecuencia de muestreo (10 kHz)
N_puntos = 1024; % Resolucion del grafico

% Mismos coeficientes del Ejercicio 1
b1 = [1];
a1 = [1, -0.5, 0.25];

b2 = [0, 1];
a2 = [1, -1, -1];

b3 = [7];
a3 = [1, -2, 6];

b4 = (0.5).^(0:7);
a4 = [1];

% Calculamos la respuesta en frecuencia [h = magnitud compleja, f = vector de frecuencias]
[h1, f] = freqz(b1, a1, N_puntos, fm);
[h2, ~] = freqz(b2, a2, N_puntos, fm);
[h3, ~] = freqz(b3, a3, N_puntos, fm);
[h4, ~] = freqz(b4, a4, N_puntos, fm);

% =======================================================
% GRAFICOS
figure('Name', 'Respuesta en Frecuencia |H(f)|', 'Position', [100 100 900 700]);

% Sistema 1
subplot(2,2,1);
plot(f, abs(h1), 'b', 'LineWidth', 1.5);
title('Sistema 1 (Estable)');
xlabel('Frecuencia (Hz)'); ylabel('Magnitud |H(f)|');
xlim([0 fm/2]); grid on;

% Sistema 2
subplot(2,2,2);
plot(f, abs(h2), 'r', 'LineWidth', 1.5);
title('Sistema 2 (Inestable - Curva Teórica)');
xlabel('Frecuencia (Hz)'); ylabel('Magnitud |H(f)|');
xlim([0 fm/2]); grid on;

% Sistema 3
subplot(2,2,3);
plot(f, abs(h3), 'r', 'LineWidth', 1.5);
title('Sistema 3 (Inestable - Curva Teórica)');
xlabel('Frecuencia (Hz)'); ylabel('Magnitud |H(f)|');
xlim([0 fm/2]); grid on;

% Sistema 4 (Filtro FIR Pasa-Bajos)
subplot(2,2,4);
plot(f, abs(h4), 'g', 'LineWidth', 1.5);
title('Sistema 4 (Filtro FIR Pasa-Bajos)');
xlabel('Frecuencia (Hz)'); ylabel('Magnitud |H(f)|');
xlim([0 fm/2]); grid on;

% Comparacion Circulo Unitario
figure('Name', 'Comparacion de Estabilidad', 'Position', [150 150 800 400]);

% Gráfico a la izquierda (Posición 1 de una grilla de 1x2)
subplot(1, 2, 1);
zplane(b1, a1);
title('Sistema 1 (Estable: Polos adentros)');

% Gráfico a la derecha (Posición 2 de una grilla de 1x2)
subplot(1, 2, 2);
zplane(b3, a3);
title('Sistema 3 (Inestable: Polos afuera)');
