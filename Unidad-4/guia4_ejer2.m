clc; clear all;
fm = 100;
fase = 0;
tini = 0;
tfin = 1;

% a) Senoidal 2 Hz
f_a = 2;
[t, senal_a] = generasen(tini, tfin, fm, f_a, fase);

f_b = 2;

% b) Cuadrada 2 Hz.
% Usamos la funcion sign() sobre el seno para hacerla cuadrada.
% Como el sign() de 0 da 0, lo forzamos a 1 para que tenga amplitud constante de 1 y -1
senal_b = sign(senal_a);
senal_b(senal_b == 0) = 1;

% c) Senoidal 4 Hz
f_c = 4;
[~, senal_c] = generasen(tini, tfin, fm, f_c, fase);

N = length(t); % Deberia ser 100 muestras

% =========================================================
% PUNTO 1: Ortogonalidad en el tiempo
% Dos senales discretas son ortogonales si su producto interno es cero
% (es decir, la suma de multiplicarlas punto a punto).
ort_ab_t = dot(senal_a,senal_b);
ort_ac_t = dot(senal_a,senal_c);
ort_bc_t = dot(senal_b, senal_c);

fprintf('1. Ortogonalidad en el Dominio del TIEMPO: \n');
fprintf('Producto interno a y b (Seno 2Hz vs Cuadrada 2Hz):  %.4f \n', ort_ab_t);
fprintf('Producto interno a y c (Seno 2Hz vs Seno 4Hz):  %.4f \n', ort_ac_t);
fprintf('Producto interno b y c (Cuadrada 2Hz vs Seno 4Hz):  %.4f \n\n', ort_bc_t);

% =========================================================
% PUNTO 2: Ortogonalidad en la frecuencia (TDF)
A_frec = fft(senal_a);
B_frec = fft(senal_b);
C_frec = fft(senal_c);

% Producto interno en frecuencia. Se divide por N para normalizar, aunque
% para verificar si es 0, la division por N no cambia el resultado.
ort_ab_f = dot(A_frec, B_frec) / N;
ort_ac_f = dot(A_frec, C_frec) / N;
ort_bc_f = dot(B_frec, C_frec) / N;

fprintf('2. Ortogonalidad en el Dominio de la FRECUENCIA: \n');
fprintf('Producto interno A y B:  %.4f \n', ort_ab_f);
fprintf('Producto interno A y C:  %.4f \n', ort_ac_f);
fprintf('Producto interno B y C:  %.4f \n\n', ort_bc_f);

% =========================================================
% PUNTO 3: Redefinicion de c) a 3.5 Hz
f_c_nueva = 3.5;
[~, senal_c_mod] = generasen(tini, tfin, fm, f_c_nueva, fase);

% Ortogonalidad en el tiempo
ort_ac_mod_t = dot(senal_a, senal_c_mod);

% Ortogonalidad en la frecuencia
C_mod_frec = fft(senal_c_mod);
ort_ac_mod_f = dot(A_frec, C_mod_frec) / N;

fprintf('3. Redefinicion de c) a 3.5 Hz \n');
fprintf('Producto interno a y c_mod (TIEMPO):  %.4f\n', ort_ac_mod_t);
fprintf('Producto interno A y C_mod (FRECUENCIA):  %.4f\n', ort_ac_mod_f);


% =========================================================
% GRAFICOS
figure('Name', 'Ejercicio 2 - Ortogonalidad', 'Position', [100, 100, 1100, 850]);

% --- FILA 1: Señales en el tiempo ---
subplot(3, 3, 1);
plot(t, senal_a, 'b', 'LineWidth', 1.2);
title('a) Seno 2 Hz');
xlabel('Tiempo (s)'); ylabel('Amplitud');
ylim([-1.5 1.5]); grid on;

subplot(3, 3, 2);
plot(t, senal_b, 'r', 'LineWidth', 1.2);
title('b) Cuadrada 2 Hz');
xlabel('Tiempo (s)'); ylabel('Amplitud');
ylim([-1.5 1.5]); grid on;

subplot(3, 3, 3);
plot(t, senal_c, 'g', 'LineWidth', 1.2);
title('c) Seno 4 Hz');
xlabel('Tiempo (s)'); ylabel('Amplitud');
ylim([-1.5 1.5]); grid on;

% --- FILA 2: Espectros de magnitud ---
f_vec = (0:N-1) * (fm/N);

subplot(3, 3, 4);
stem(f_vec(1:20), abs(A_frec(1:20)), 'b', 'filled', 'MarkerSize', 4);
title('|A[k]| - Seno 2 Hz');
xlabel('Frecuencia (Hz)'); ylabel('|S[k]|');
grid on;

subplot(3, 3, 5);
stem(f_vec(1:20), abs(B_frec(1:20)), 'r', 'filled', 'MarkerSize', 4);
title('|B[k]| - Cuadrada 2 Hz');
xlabel('Frecuencia (Hz)'); ylabel('|S[k]|');
grid on;

subplot(3, 3, 6);
stem(f_vec(1:20), abs(C_frec(1:20)), 'g', 'filled', 'MarkerSize', 4);
title('|C[k]| - Seno 4 Hz');
xlabel('Frecuencia (Hz)'); ylabel('|S[k]|');
grid on;

% --- FILA 3: Comparacion fuga espectral ---
subplot(3, 3, 7);
stem(f_vec(1:20), abs(C_frec(1:20)), 'g', 'filled', 'MarkerSize', 4);
title('|C[k]| - Seno 4 Hz (sin fuga)');
xlabel('Frecuencia (Hz)'); ylabel('|S[k]|');
grid on;

subplot(3, 3, 8);
stem(f_vec(1:20), abs(C_mod_frec(1:20)), 'm', 'filled', 'MarkerSize', 4);
title('|Cmod[k]| - Seno 3.5 Hz (con fuga)');
xlabel('Frecuencia (Hz)'); ylabel('|S[k]|');
grid on;

