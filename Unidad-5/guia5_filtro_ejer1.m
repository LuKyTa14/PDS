clc; clear all; close all;

% PARAMETROS
fm = 300; % Frecuencia de muestreo (Hz)

f_ruido = 50; % Frecuencia del ruido de red electrica a eliminar
N = 51; % Cantidad de muestras del filtro (Debe ser impar para fase lineal tipo I)

% Calculo de frecuencias digitales (normalizadas en radianes/muestra)
% Definimos un pequeño "ancho de banda" alrededor de 50Hz para asegurar el corte
ancho = 2; % No deja pasar nada entre 48 y 52
wc1 = 2*pi * (f_ruido - ancho) / fm;
wc2 = 2*pi * (f_ruido + ancho) / fm;

% RESPUESTA AL IMPULSO "IDEAL" (h_ideal)
% Un filtro rechaza-banda ideal es: (Impulso) - (Filtro Pasa-Banda)
% Y el Pasa-Banda ideal es la resta de dos Pasa-Bajos (Sinc)
alpha = (N - 1) / 2; % Eje de simetria (retraso para hacer el filtro causal)
n = 0:N-1; % Vector de muestras
h_ideal = zeros(1, N);

for i = 1:N
    m = n(i) - alpha;
    if m == 0
        % Caso especial en n = alpha (limite de la funcion sinc)
        h_ideal(i) = 1 - (wc2 - wc1)/pi;
    else
        % Impulso desplazado - Resta de funciones Sinc
        h_ideal(i) = - (sin(wc2*m) - sin(wc1*m)) / (pi*m);
    end
end

% GENERACION DE LAS VENTANAS (Truncado)
v_rect = ones(1, N);
v_hann = 0.5 - 0.5 * cos(2*pi*n / (N-1));
v_hamm = 0.54 - 0.46 * cos(2*pi*n / (N-1));
v_blck = 0.42 - 0.5 * cos(2*pi*n / (N-1)) + 0.08 * cos(4*pi*n / (N-1));

% FILTRADO (Multiplicacion en el tiempo: Ideal * Ventana)
h_rect = h_ideal .* v_rect;
h_hann = h_ideal .* v_hann;
h_hamm = h_ideal .* v_hamm;
h_blck = h_ideal .* v_blck;

% COMPARATIVA EN EL DOMINIO DE LA FRECUENCIA
N_fft = 1000;
f_eje = linspace(0, fm/2, N_fft/2);

H_rect = fft(h_rect, N_fft); H_rect = abs(H_rect(1:N_fft/2));
H_hann = fft(h_hann, N_fft); H_hann = abs(H_hann(1:N_fft/2));
H_hamm = fft(h_hamm, N_fft); H_hamm = abs(H_hamm(1:N_fft/2));
H_blck = fft(h_blck, N_fft); H_blck = abs(H_blck(1:N_fft/2));

% -------------------------------------------------------------------------
% GRAFICOS
figure('Name', 'Comparativa de Ventanas (N = 51)', 'Position', [100 100 900 600]);

% Ploteo de las 4 ventanas
plot(f_eje, 20*log10(H_rect), 'b', 'LineWidth', 1.5); hold on;
plot(f_eje, 20*log10(H_hann), 'r', 'LineWidth', 1.5);
plot(f_eje, 20*log10(H_hamm), 'g', 'LineWidth', 1.5);
plot(f_eje, 20*log10(H_blck), 'k', 'LineWidth', 1.5);

plot([50 50], [-80 10], 'k--', 'LineWidth', 1.5);
text(52, 5, 'Ruido a Eliminar (50 Hz)', 'Color', 'k', 'FontSize', 10);

title(['Respuesta de Magnitud - Filtro FIR Notch 50Hz (N = ', num2str(N), ')']);
xlabel('Frecuencia (Hz)'); ylabel('Magnitud (dB)');
xlim([0 100]); ylim([-20 5]);

legend('Rectangular', 'Hanning', 'Hamming', 'Blackman', 'Location', 'southwest');
grid on;
