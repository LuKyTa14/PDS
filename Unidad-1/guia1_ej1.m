clc; clear all;

% Parámetros
fm = 100;
t_inicial = 0;
t_final = 1;
phi = 6;

% Frecuencia de la señal (Hz)
fs_sen = 5;
fs_sinc = 2;
fs_cuad = 3;

% Generar señales llamando a nuestras funciones
[t1, y_sen]  = generar_senoidal(t_inicial, t_final, fm, fs_sen, phi);
[t2, y_sinc] = generar_sinc(t_inicial-1 , t_final, fm, fs_sinc);
[t3, y_cuad] = generar_cuadrada(t_inicial, t_final, fm, fs_cuad, phi);

% Graficar los resultados
figure('name', 'Ejercicio 1');

subplot(3, 1, 1);
stem(t1, y_sen, 'filled', 'MarkerSize', 4);
title('Ejercicio 1.1: Senoidal (fs=5, fm=100)');
grid on;

subplot(3, 1, 2);
stem(t2, y_sinc, 'filled', 'MarkerSize', 4);
title('Ejercicio 1.2: Sinc (fs=2, fm=100)');
grid on;

subplot(3, 1, 3);
stem(t3, y_cuad, 'filled', 'MarkerSize', 4);
title('Ejercicio 1.3: Cuadrada (fs=3, fase=pi/4)');
grid on;
