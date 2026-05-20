clear; close all; clc;
fm = 100; % frecuencia de muestreo
fs = 10;   % frecuencia senoide
n0 = 10;   % retardo en muestras

tini = 0;
tfin = 1 - 1/fm; % Para tener exactamente N=100 muestras
[t, x] = generar_senoidal(tini, tfin, fm, fs, 0);
N = length(t);

% FFT
X = fft(x);

% Vector k (índices de frecuencia discretos)
k = 0:N-1;

% PROPIEDAD DE RETARDO TEMPORAL
% formula es: X[k] * e^(-j * 2*pi * k * n0 / N)
X_ret = X .* exp(-1j*2*pi*k*n0/N);

%  Antitransformada para volver al tiempo
x_ret = ifft(X_ret);

% =========================================================
% GRAFICOS
% Vector de frecuencias para el eje X (resolución fm/N1 = 1 Hz)
f_vec1 = (0:N-1) * (fm/N);
figure('Name', 'Propiedad de Retardo en TDF', 'Position', [100 100 800 600]);

subplot(2,2,1)
stem(t, x, 'b', 'filled', 'MarkerSize', 4)
title('Señal Original en el Tiempo')
xlabel('Tiempo (s)');
grid on

subplot(2,2,2)
stem(f_vec1, abs(X), 'b', 'filled', 'MarkerSize', 4)
title('Magnitud |X[k]| Original')
xlabel('Frecuencia (Hz)');
grid on

subplot(2,2,3)
stem(t, x_ret, 'r', 'filled', 'MarkerSize', 4)
title('Señal Retardada (10 muestras)')
xlabel('Tiempo (s)');
grid on

subplot(2,2,4)
stem(f_vec1, abs(X_ret), 'r', 'filled', 'MarkerSize', 4)
title('Magnitud |X_{ret}[k]|')
xlabel('Frecuencia (Hz)');
grid on

