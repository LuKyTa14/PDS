clc; clear all; close all;
pkg load signal;

% PARAMETROS
% El enunciado NO nos da una frecuencia de muestreo (fm).
% Como la frecuencia más alta a procesar es 6000 Hz, por el Teorema de Nyquist
% sabemos que fm DEBE ser mayor a 12000 Hz. Asumimos fm = 16000 Hz.
fm = 16000;
f_nyq = fm / 2;
N = 500; % Orden del filtro FIR (Elegimos un orden alto para lograr transiciones abruptas)

% PLANTILLA DEL FILTRO (Frecuencias vs Magnitudes)
% Armamos los vectores definiendo qué magnitud queremos en cada frecuencia.
% Usamos separaciones de 1 Hz (ej: 99 a 100) para forzar caidas "verticales".
f = [0,  99, 100, 200, 201, 1639, 1640, 3028, 3029, 4999, 5000, 6000, 6001, f_nyq];
m = [0,   0,   1,   1,   0,    0,    1,    1,    0,    0,    0,    1,    0,     0];

% Explicacion de la rampa:
% Al poner un punto en (5000Hz, Mag=0) y el siguiente en (6000Hz, Mag=1),
% el algoritmo interpola linealmente, creando exactamente la rampa proporcional.

% La funcion fir2 exige que las frecuencias esten normalizadas entre 0 y 1 (donde 1 es Nyquist)
f_norm = f / f_nyq;

% CALCULO DE COEFICIENTES (Metodo de Muestreo en Frecuencia)
h = fir2(N, f_norm, m);

% RESPUESTA EN FRECUENCIA (Para verificar el resultado)
[H, w] = freqz(h, 1, 4000, fm);

% -------------------------------------------------------------------------
% GRAFICOS
figure('Name', 'Filtro FIR Multibanda Arbitrario', 'Position', [100 100 900 500]);

% Superponemos el diseño ideal (rojo punteado) para comparar con la realidad
plot(f, m, 'r--', 'LineWidth', 2); hold on;
% Graficamos la respuesta real obtenida del filtro
plot(w, abs(H), 'b', 'LineWidth', 1.5);

title('Respuesta en Frecuencia: Filtro Multibanda con Rampa');
xlabel('Frecuencia (Hz)'); ylabel('Magnitud Lineal |H(f)|');
xlim([0 7000]); ylim([-0.1 1.2]);

legend('Plantilla Ideal Deseada', 'Respuesta Real del FIR', 'Ubicación Bandas de Paso', 'Location', 'northwest');
grid on;
