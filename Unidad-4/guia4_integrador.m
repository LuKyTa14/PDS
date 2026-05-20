clc; clear all;
% ===============================================
% PARTE I: Generacion de la Señal y Aliasing
% ===============================================
fs1 = 50;   fs2 = 120;    fs3 = 280;
A1 = 5;    A2 = 3;    A3 = 2;
fm = 1000;
tini = 0;     tfin = 1;
fase = 0;

[t,sen1] = generasen(tini, tfin, fm, fs1, fase);
[t,sen2] = generasen(tini, tfin, fm, fs2, fase);
[t,sen3] = generasen(tini, tfin, fm, fs3, fase);
seno = A1 .* sen1 + A2 .* sen2 + A3 .* sen3;

% Calculo y grafico de la TDF a 1000 Hz
N = length(seno);
X = fft(seno);
f_vec1 = (0:N-1) * (fm/N);

% GRAFICOS
figure('Name', 'Analisis de Señales y Aliasing', 'Position', [100 100 900 700]);
subplot(3,1,1);
% Graficamos solo una porcion (primeras 100 muestras) para visualizar bien las ondas
plot(t(1:100), seno(1:100), 'k', 'LineWidth', 1.2);
title('Señal s[n] en el tiempo (Primeras 100 muestras)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

subplot(3,1,2);
stem(f_vec1, abs(X), 'b', 'filled', 'MarkerSize', 4);
title('Espectro de Magnitud a fm = 1000 Hz');
xlabel('Frecuencia (Hz)');
ylabel('|X[k]|');
xlim([0 fm/2]); % Mostramos solo hasta la frecuencia de Nyquist (500 Hz)
grid on;

% Reduccion A fm = 200 hz y nueva TDF
fm_reducida = 200;

% Generamos las señales nuevamente con la nueva frecuencia de muestreo
[t_red,sen1_red] = generasen(tini, tfin, fm_reducida, fs1, fase);
[t_red,sen2_red] = generasen(tini, tfin, fm_reducida, fs2, fase);
[t_red,sen3_red] = generasen(tini, tfin, fm_reducida, fs3, fase);
seno_reducido = A1 .* sen1_red + A2 .* sen2_red + A3 .* sen3_red;

N_red = length(seno_reducido);
X_red = fft(seno_reducido);
f_vec_red = (0:N_red-1) * (fm_reducida/N_red);

subplot(3,1,3);
stem(f_vec_red, abs(X_red), 'r', 'filled', 'MarkerSize', 4);
title('Espectro de Magnitud con submuestreo (fm = 200 Hz)');
xlabel('Frecuencia (Hz)');
ylabel('|X[k]|');
xlim([0 fm_reducida/2]); % Mostramos solo hasta el nuevo limite de Nyquist (100 Hz)
grid on;

% ===============================================
% PARTE II: Ventanas y Zero-Padding
% ===============================================
fs1 = 50;  fs2 = 120; fs3 = 280;
A1 = 5;    A2 = 3;   A3 = 2;
fm = 1000;
tini = 0;
tfin_corta = 0.04; % Reducción a 40ms (0.04 segundos)
fase = 0;

% 1. Generación de la señal de 40ms
[t_corta, sen1_c] = generasen(tini, tfin_corta, fm, fs1, fase);
[t_corta, sen2_c] = generasen(tini, tfin_corta, fm, fs2, fase);
[t_corta, sen3_c] = generasen(tini, tfin_corta, fm, fs3, fase);

seno_corta = A1 .* sen1_c + A2 .* sen2_c + A3 .* sen3_c;
N_corta = length(seno_corta);

% Cálculo de la TDF de la señal corta
X_corta = fft(seno_corta);
f_vec_corta = (0:N_corta-1) * (fm/N_corta); % (fm/N_corta) = 25Hz

% 2. Zero-Padding (Extender a 5*N muestras usando ceros)
N_zp = 5 * N_corta; % 5 * 40 = 200 muestras
X_zp = fft(seno_corta, N_zp); % Octave agrega los ceros automáticamente al pasar N_zp
f_vec_zp = (0:N_zp-1) * (fm/N_zp);

% Normalizamos las magnitudes para poder comparar amplitudes reales
mag_corta = abs(X_corta) / N_corta;
mag_zp = abs(X_zp) / N_corta; % Se divide por N original para mantener la escala de energía

% 3. Gráficos Superpuestos
figure('Name', 'Efecto del Tiempo de Observacion y Zero-Padding');
plot(f_vec_zp, mag_zp, 'r-', 'LineWidth', 1.5); % Espectro interpolado (continuo)
hold on;
stem(f_vec_corta, mag_corta, 'b', 'filled', 'LineWidth', 1.2); % Espectro original de 40ms

title(['Análisis de Resolución Frecuencial (\Delta f = ', num2str(fm/N_corta), ' Hz)']);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud Normalizada');
xlim([0 200]); % Enfocamos de 0 a 200 Hz para ver los lóbulos

legend('Espectro con Zero-Padding (5N)', 'Espectro Original (40ms)');
grid on;

% ===============================================
% PARTE III: Linealidad y Parseval
% ===============================================
% Generamos un vector de tiempo (fm y N ; PARTE I)
t1 = (0:N-1) / fm;

x1 = 5 * sin(2*pi*50*t1);
x2 = 3 * cos(2*pi*120*t1);
x3 = 2 * sin(2*pi*280*t1);

x_parte3 = x1 + x2 + x3;

% TDF de la señal unificada
X_parte3 = fft(x_parte3);
f_vec_parte3 = (0:N-1) * (fm/N);

% TDF individuales
X1 = fft(x1);    X2 = fft(x2);    X3 = fft(x3);
X_sumada = X1 + X2 + X3;

% Comprobacion grafica de Linealidad
figure('Name', 'Parte III: Linealidad', 'Position', [150 150 900 400]);
plot(f_vec_parte3, abs(X_parte3), 'ko', 'MarkerSize', 8, 'LineWidth', 1.5); hold on;
plot(f_vec_parte3, abs(X_sumada), 'r.', 'MarkerSize', 12);
title('Verificacion de Linealidad: FFT(x1+x2+x3) = FFT(x1) + FFT(x2) + FFT(x3)');
xlim([0 350]); grid on;
legend('FFT de la suma total', 'Suma de las FFT individuales');

% Calculo de Parseval
Es_t = sum(x_parte3.^2);
Es_f = sum(abs(X_parte3).^2) / N;
fprintf('\n--- TEOREMA DE PARSEVAL ---\n');
fprintf('Energia Temporal:    %.4f\n', Es_t);
fprintf('Energia Frecuencial: %.4f\n\n', Es_f);

% ===============================================
% PARTE IV: Filtro Ideal Pasa-Bajos
% ===============================================
% Aplicamos el filtro sobre la señal de la Parte III (X_parte3)
fc = 200; % Frecuencia de corte
H = zeros(1, N);

% Hacemos 1 las frecuencias menores a fc
H(f_vec_parte3 <= fc | f_vec_parte3 >= (fm - fc)) = 1;

% Filtrado en el dominio de la frecuencia
X_filt = X_parte3 .* H;

% Antitransformada
y = ifft(X_filt);

% GRAFICOS
figure('Name', 'Parte IV: Filtrado Pasa-Bajos', 'Position', [200 200 900 700]);
subplot(3,1,1);
plot(f_vec_parte3, H, 'g', 'LineWidth', 2);
title('Mascara del Filtro Ideal Pasa-Bajos H[k] (Corte = 200 Hz)');
xlabel('Frecuencia (Hz)'); ylim([-0.2 1.2]); grid on;

subplot(3,1,2);
stem(f_vec_parte3, abs(X_filt), 'm', 'filled', 'MarkerSize', 4);
title('Espectro Filtrado X[k] * H[k]');
xlabel('Frecuencia (Hz)'); xlim([0 500]); grid on;

subplot(3,1,3);
% Graficamos las primeras 100 muestras para ver el detalle de la onda
plot(t1(1:100), x_parte3(1:100), 'b', t1(1:100), y(1:100), 'r', 'LineWidth', 1.5);
title('Señal Original (Parte III) vs Señal Filtrada (Zoom 0 a 0.1s)');
xlabel('Tiempo (s)'); ylabel('Amplitud');
grid on;
legend('Original (Con ruido 280 Hz)', 'Filtrada (Sin 280 Hz)');
