% Este script demuestra el Principio de Incertidumbre de Heisenberg.
% No se puede tener una senal que sea un "punto" (totalmente concentrada)
% en el tiempo y al mismo tiempo un "punto" en la frecuencia.
% Si se comprime en un dominio, se expande necesariamente en el otro.

fs = 1000;
t = -1:1/fs:1-1/fs;
N = length(t);

% Vector de frecuencias centrado en 0 Hz
% (Vamos de -fs/2 a fs/2 para ver el espectro completo simetrico)
f = (-N/2 : N/2-1) * (fs/N);

% ==============================================================
% GENERACION DE VENTANAS
% Ventana Ancha (energia dispersa en el tiempo)
% Al durar mucho tiempo, el cambio es mas "relajado".
ancho_1 = 0.4; % Dura 0.8 segundos en total
ventana_ancha = zeros(1, N);
ventana_ancha(abs(t) <= ancho_1) = 1;

% Ventana Angosta (energia muy concentrada en el tiempo)
% Al durar solo un instante, tiene flancos de subida y bajada muy bruscos.
ancho_2 = 0.02; % Dura 0.04 segundos en total
ventana_angosta = zeros(1, N);
ventana_angosta(abs(t) <= ancho_2) = 1;

% ==============================================================
% TRANSFORMADAS DE FOURIER
% Usamos fftshift para que la frecuencia 0 Hz quede en el medio del grafico.
% La fft normal arranca en 0 Hz, sube hasta las positivas, y pega las
% negativas al final del vector. fftshift corta el vector al medio y lo
% reordena para visualizar el espectro centrado como en los libros.

TDF_ancha = fftshift(fft(ventana_ancha));
TDF_angosta = fftshift(fft(ventana_angosta));

% Normalizamos las amplitudes de la TDF para comparar visualmente mejor
TDF_ancha_mag = abs(TDF_ancha) / max(abs(TDF_ancha));
TDF_angosta_mag = abs(TDF_angosta) / max(abs(TDF_angosta));

% ==============================================================
% GRAFICOS
figure('Name', 'Dualidad Tiempo-Frecuencia', 'Position', [100, 100, 1000, 600]);

% --- CASO 1: VENTANA ANCHA ---
% Teoria: Como la senal cambia despacito en el tiempo, casi no necesita
% frecuencias altas para construirse. Por lo tanto, en el dominio
% frecuencial vemos un lobulo central (funcion Sinc) muy finito y
% puntiagudo. La energia espectral esta super concentrada cerca de los 0 Hz.

% Tiempo
subplot(2, 2, 1);
plot(t, ventana_ancha, 'LineWidth', 2);
title('Dominio Temporal: Ventana Ancha');
xlabel('Tiempo (s)'); ylabel('Amplitud');
axis([-1 1 -0.2 1.2]); grid on;

% Frecuencia
subplot(2, 2, 3);
plot(f, TDF_ancha_mag, 'LineWidth', 2);
title('Dominio Frecuencial: Espectro Estrecho');
xlabel('Frecuencia (Hz)'); ylabel('|S[f]| (Normalizado)');
xlim([-50 50]); grid on; % Hacemos zoom entre -50 y 50 Hz

% --- CASO 2: VENTANA ANGOSTA ---
% Teoria: Para que una sumatoria de senos logre hacer un salto cuadrado
% tan violento y rapido, necesita sumar muchisimos armonicos de alta
% frecuencia. Por eso, el lobulo central de la frecuencia se ensancha
% muchisimo y la energia se desparrama hacia los costados.

% Tiempo
subplot(2, 2, 2);
plot(t, ventana_angosta, 'LineWidth', 2, 'Color', 'r');
title('Dominio Temporal: Ventana Angosta');
xlabel('Tiempo (s)'); ylabel('Amplitud');
axis([-1 1 -0.2 1.2]); grid on;

% Frecuencia
subplot(2, 2, 4);
plot(f, TDF_angosta_mag, 'LineWidth', 2, 'Color', 'r');
title('Dominio Frecuencial: Espectro Disperso');
xlabel('Frecuencia (Hz)'); ylabel('|S[f]| (Normalizado)');
xlim([-50 50]); grid on;
