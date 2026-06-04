clc; clear all; close all;
pkg load signal

% Definimos el numerador (b) directamente de los coeficientes:
b = [1, -2, 2, -1];

% Definimos el denominador (a).
% Como esta factorizado, creamos cada binomio y usamos 'conv' para multiplicarlos
p1 = [1, -1];    % (1 - z^-1)
p2 = [1, -0.5];  % (1 - 0.5z^-1)
p3 = [1, -0.2];  % (1 - 0.2z^-1)

% Multiplicamos p1 * p2 * p3
a = conv(conv(p1, p2), p3);

% El comando roots encuentra las raices de los polinomios (ceros y polos)
ceros_del_sistema = roots(b);
polos_del_sistema = roots(a);

modulos = abs(polos_del_sistema);
all(modulos < 1);
normaPolos = sqrt(sum(polos_del_sistema.^2));

fprintf('--- ANALISIS DE RAICES ---\n');
disp('Ceros del sistema (Raices del Numerador):'); disp(ceros_del_sistema);
disp('Polos del sistema (Raices del Denominador):'); disp(polos_del_sistema);
disp('Norma Polos: '); disp(normaPolos);

% =========================================================================
% GRAFICOS
figure('Name', 'Analisis del Sistema LTI', 'Position', [100 100 900 450]);

% Grafico 1: Diagrama de Polos y Ceros
subplot(1,2,1);
zplane(b, a);
title('Diagrama de Polos y Ceros');

% Grafico 2: Respuesta al Impulso h[n]
% impz --> calcula y grafica la respuesta al impulso automaticamente
subplot(1,2,2);
impz(b, a, 20); % Calculamos los primeros 20 valores de h[n]
title('Respuesta al Impulso h[n]');
xlabel('Muestras (n)'); ylabel('Amplitud');
grid on;
