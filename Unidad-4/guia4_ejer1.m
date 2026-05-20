clc; clear all;
% CONFIGURACIÓN BASE
fm = 1000; % Frecuencia de muestreo (Hz)
fase = 0;
tini = 0;
tfin = 1;

% Caso Base: f1 = 10 Hz, f2 = 20 Hz
% Generamos las señales individuales y las sumamos
f1 = 10; f2 = 20;
[t1, s1] = generasen(tini, tfin, fm, f1, fase);
[~, s2] = generasen(tini, tfin, fm, f2, fase);

s_base = s1 + 4 * s2;
N1 = length(t1);

% Vector de frecuencias para el eje X (resolucion fm/N1 = 1 Hz)
% Armamos un vector por cada frecuencia, porque la funcion
% en la nueva base es un conjunto de senoidales con distintas frecuencias
f_vec1 = (0:N1-1) * (fm/N1);

% TDF
S_base = fft(s_base);

% Verificacion de Relacion de Parseval
Es_tiempo = sum(s_base.^2);
Es_frec = sum(abs(S_base).^2) / N1;

fprintf('--- Verificacion de Parseval (Caso Base) ---\n');
fprintf('Energia en el tiempo (Es):      %.4f\n', Es_tiempo);
fprintf('Energia en la frecuencia (Es):  %.4f\n\n', Es_frec);

% GRÁFICOS Y MODIFICACIONES
% Configuracion de la figura principal
figure('Name', 'Analisis de Espectro TDF', 'Position', [100, 100, 1000, 800]);

% Grafico Caso Base
subplot(3, 2, 1);
stem(f_vec1, abs(S_base), 'filled', 'MarkerSize', 4);
title('Caso Base: f1=10Hz, f2=20Hz');
xlabel('Frecuencia (Hz)'); ylabel('|S[k]|');
xlim([0 30]); grid on;

% Modificacion 1: Se suma un nivel CC de +4
s_mod1 = s_base + 4;
S_mod1 = fft(s_mod1);

subplot(3, 2, 2);
stem(f_vec1, abs(S_mod1), 'filled', 'MarkerSize', 4);
title('Mod 1: f1=10, f2=20, CC=+4');
xlabel('Frecuencia (Hz)'); ylabel('|S[k]|');
xlim([0 30]); grid on;

% Modificacion 2: f1=10 Hz, f2=11 Hz
f2_nueva = 11;
[~, s2_mod2] = generasen(tini, tfin, fm, f2_nueva, fase);
s_mod2 = s1 + 4 * s2_mod2; % Reutilizamos s1 (10 Hz)
S_mod2 = fft(s_mod2);

subplot(3, 2, 3);
stem(f_vec1, abs(S_mod2), 'filled', 'MarkerSize', 4);
title('Mod 2: f1=10Hz, f2=11Hz');
xlabel('Frecuencia (Hz)'); ylabel('|S[k]|');
xlim([0 30]); grid on;

% Modificacion 3: f1=10 Hz, f2=10.5 Hz (Fuga Espectral)
f2_aun_mas_nueva = 10.5;
[~, s2_mod3] = generasen(tini, tfin, fm, f2_aun_mas_nueva, fase);
s_mod3 = s1 + 4 * s2_mod3;
S_mod3 = fft(s_mod3);

subplot(3, 2, 4);
stem(f_vec1, abs(S_mod3), 'filled', 'MarkerSize', 4);
title('Mod 3: f1=10Hz, f2=10.5Hz (Fuga Espectral)');
xlabel('Frecuencia (Hz)'); ylabel('|S[k]|');
xlim([0 30]); grid on;

% Modificacion 4: Ventana t = [0 ... 2) s
% Aumentamos el tfin a 2
tfin_nuevo = 2;
[t2, s1_mod4] = generasen(tini, tfin_nuevo, fm, f1, fase);
[~, s2_mod4]  = generasen(tini, tfin_nuevo, fm, f2_aun_mas_nueva, fase);

s_mod4 = s1_mod4 + 4 * s2_mod4;
N2 = length(t2); % Ahora N = 2000

% Nuevo vector de frecuencias (resolucion fm/N2 = 0.5 Hz)
f_vec2 = (0:N2-1) * (fm/N2);
S_mod4 = fft(s_mod4);

% Ocupa el ancho de las dos columnas inferiores
subplot(3, 2, [5 6]);
stem(f_vec2, abs(S_mod4), 'filled', 'MarkerSize', 4);
title('Mod 4: Intervalo t=[0...2)s, f1=10Hz, f2=10.5Hz');
xlabel('Frecuencia (Hz)'); ylabel('|S[k]|');
xlim([0 30]); grid on;
