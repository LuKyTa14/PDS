clc; clear all;
fm = 250;
t = 0:1/fm:1;
fs = 5;
senal_pura = 2* sin(2 * pi * fs * t);

% Generamos ruido aleatorio Gaussiano
ruido_orig = randi([-1, 1], size(t));
senal_sucia1 = senal_pura + ruido_orig;

figure('Name', 'Análisis de Ruido');
subplot(2,1,1);
plot(t, senal_pura, 'b'); title('Señal Pura');
grid on;
subplot(2,1,2);
plot(t, senal_sucia1, 'g'); title('Señal + Ruido Original'); grid on;

% Potencias y SNR inicial
% Potencia = promedio de los valores al cuadrado
P_senal = mean(senal_pura.^2);
P_ruido_orig = mean(ruido_orig.^2);

SNR_lin_1 = P_senal / P_ruido_orig;
SNR_dB_1 = 10 * log10(SNR_lin_1);

fprintf(' --- Valores Iniciales: \n');
fprintf('Potencia Señal: %.4f \n', P_senal);
fprintf('Potencia del Ruido: %.4f \n', P_ruido_orig);
fprintf('SNR: %.4f [dB] \n \n', SNR_dB_1);

% Agregamos una constate k para luego
k = 2;
ruido_multiplicado = ruido_orig*k;
P_ruido_mult = mean(ruido_multiplicado.^2);
SNR_dB_2 = 10*log10(P_senal/P_ruido_mult);
fprintf(' --- Valores con k=2: \n');
fprintf('Constante calculada (k): %.4f \n', k);
fprintf('Potencia del Ruido: %.4f \n', P_ruido_mult);
fprintf('SNR: %.4f [dB] \n \n', SNR_dB_2);

% Encontrar la constante 'k' para que SNR = 0 dB
k = sqrt(P_senal / P_ruido_orig);
ruido_nuevo = k * ruido_orig;
senal_sucia2 = senal_pura + ruido_nuevo;

P_ruido_nuevo = mean(ruido_nuevo.^2);
SNR_dB_3 = 10 * log10( P_senal / P_ruido_nuevo);

fprintf(' --- Valores con SNR=0: \n');
fprintf('Constante calculada (k): %.4f \n', k);
fprintf('Nueva Potencia del Ruido: %.4f \n', P_ruido_nuevo);
fprintf('SNR: %.4f [dB] \n \n', SNR_dB_3);


% Despeje:
% Prmult = 1/N * sum((ruido * k)^2)
% Prmult = k^2 * (1/N * sum(ruido^2))
% Prmult = k^2 * Pr
% Entonces
% 10 * log(Ps/(Pr * k^2)) = 0
% log(Ps/(Pr * k^2)) = 0
% Para que eso pase -> Ps = Pr * k^2
% k^2 = Ps/Pr
% k = sqrt(Ps/Pr)
