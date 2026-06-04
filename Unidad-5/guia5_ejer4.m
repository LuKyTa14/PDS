clc; clear all; close all;
pkg load signal

% SISTEMA CONTINUO H(s)
b_s = [12500, 0];
a_s = [44, 60625, 6250000];

% Buscamos la frecuencia de corte (fc) calculando la respuesta analógica
w = linspace(10, 2000, 5000); % Rango de frecuencias en rad/s
h_s = freqs(b_s, a_s, w);

mag_s = abs(h_s);
[max_mag, idx_max] = max(mag_s);
mag_3db = max_mag / sqrt(2);

% fc es el primer punto después del pico que cae por debajo de -3dB
idx_fc = find(mag_s <= mag_3db & w > w(idx_max), 1);
fc = w(idx_fc) / (2*pi);

% ---------------------------------------------------------
% FRECUENCIA DE MUESTREO
fm = 4 * fc;
T = 1 / fm;

% ---------------------------------------------------------
% TRANSFORMACIONES CONFORMES

% a) Transformación de Euler (Manual: s = (1 - z^-1)/T )
num_euler = [12500*T, -12500*T, 0];
den_euler = [(44 + 60625*T + 6250000*T^2), (-88 - 60625*T), 44];

% b) Transformación Bilineal (Manual: s = K * (1 - z^-1)/(1 + z^-1) )
K = 2/T;
num_bilin = [12500*K, 0, -12500*K];
den_bilin = [(44*K^2 + 60625*K + 6250000), (-2*44*K^2 + 2*6250000), (44*K^2 - 60625*K + 6250000)];

% ---------------------------------------------------------
% GRAFICOS
f_plot = linspace(0, fm/2, 500); % Frecuencias a graficar (hasta Nyquist)

% Calculamos las 3 respuestas usando los vectores que armamos
h_s_plot = freqs(b_s, a_s, 2*pi*f_plot);
[h_e_plot, ~] = freqz(num_euler, den_euler, f_plot, fm);
[h_b_plot, ~] = freqz(num_bilin, den_bilin, f_plot, fm);

figure('Name', 'Comparativa: Continua vs Discreta', 'Position', [150 150 800 500]);
plot(f_plot, 20*log10(abs(h_s_plot)), 'k', 'LineWidth', 2); hold on;
plot(f_plot, 20*log10(abs(h_e_plot)), 'b--', 'LineWidth', 2);
plot(f_plot, 20*log10(abs(h_b_plot)), 'r-.', 'LineWidth', 2);

% Líneas guías para mostrar dónde está el corte exacto
yline(20*log10(mag_3db), 'g:', 'Corte -3dB', 'LineWidth', 1.5);
xline(fc, 'g:', 'fc', 'LineWidth', 1.5);

title('Respuesta en Frecuencia: Analógica vs Euler vs Bilineal');
xlabel('Frecuencia (Hz)'); ylabel('Magnitud (dB)');
xlim([0 fm/2]); ylim([-40 5]);
legend('H(s) Analógica', 'H(z) Euler', 'H(z) Bilineal');
grid on;
