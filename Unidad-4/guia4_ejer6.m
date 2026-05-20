clc; clear all; close all;

fm = 360;
x = load('necg.txt');   % Cargar la señal
N = length(x);
t = (0:N-1) / fm;   % Vector de tiempo

% Calculamos FFT
X = fft(x);
% Vector de frecuencias exacto
f_vec = (0:N-1) * (fm/N);

X_filtrado = X;   % copia para no romper el original

% Buscamos donde esta la banda de ruido.
% Como la TDF es simétrica, borramos desde 40 Hz hasta 320 Hz
% (que es el reflejo de 40 Hz respecto a la frecuencia de muestreo).
indices_ruido = (f_vec >= 40 & f_vec <= (fm - 40));

% Hacemos cero toda la energia en esa banda
X_filtrado(indices_ruido) = 0;

% Antitransformada (volver al dominio del tiempo)
x_limpia = ifft(X_filtrado);

% ==============================================================
% GRAFICOS
figure('Name', 'Operacion de Filtrado ECG', 'Position', [100 100 1000 600]);

% --- DOMINIO DEL TIEMPO ---
% ECG Original
subplot(2,2,1);
plot(t, x, 'b');
title('1. ECG Original (Contaminado)');
xlabel('Tiempo (s)');
axis([0.5 2.5 min(x) max(x)]); % Hacemos un poco de zoom para ver el ruido
grid on;

% ECG Filtrado
subplot(2,2,3);
plot(t, x_limpia, 'r', 'LineWidth', 1.5);
title('3. ECG Filtrado (Ruido Anulado)');
xlabel('Tiempo (s)');
axis([0.5 2.5 min(x) max(x)]); % Mismo zoom para comparar
grid on;

% --- DOMINIO DE LA FRECUENCIA ---
% Espectro Original
subplot(2,2,2);
plot(f_vec, abs(X), 'b');
title('2. Espectro Original |X[k]|');
xlabel('Frecuencia (Hz)');
xlim([0 fm]); grid on;

% Espectro Filtrado
subplot(2,2,4);
plot(f_vec, abs(X_filtrado), 'r');
title('4. Espectro Filtrado (Zona 40-320Hz en Cero)');
xlabel('Frecuencia (Hz)');
xlim([0 fm]); grid on;

% ==============================================================
% El reflejo de 40 Hz es 360 - 40 = 320 Hz.
% El reflejo de 180 Hz es 360 - 180 = 180 Hz.
%Por lo tanto, hay que cortar todo lo que esté entre 40 Hz y 320 Hz.
% Si no se borra el reflejo, la antitransformada va a dar una señal con componentes imaginarios.
