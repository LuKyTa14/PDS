clc; clear all;
% ------------ Parte 1 ------------
A = 5;
fs = 10;
fase = pi/4;
fm = 400;
Tm = 1/fm;

% vector tiempo
t = 0 : Tm : 0.5;
% generacion de la señal discreta
x_original = A * sin(2 * pi * fs * t + fase);

% La señal es una señal deterministica, periodica y sinusoidal. Esto porque es un seno.
% Expandir explicacion

x_rectificada = rectificacion_onda_completa(x_original);
N = 16;
H = 5 / (N-1);     %  -->  depende del rango de la señal | Amplitud = 5
x_cuantizada = cuantizacion(x_rectificada, N, H);

% Graficos
figure('Name', 'Integrador Parte I:');
subplot(3,1,1);
plot(t, x_original, 'b'); title('Señal Original');
grid on;
subplot(3,1,2);
plot(t, x_rectificada, 'r'); title('Señal Rectificada');
grid on;
subplot(3,1,3);
plot(t, x_cuantizada, 'g'); title('Señal Cuantizada');
grid on;

% ------------ Parte 2 ------------
var1 = 0.1;
ruido_bajo = sqrt(var1) * randi([-1, 1], size(t));
x_ruido_bajo = x_original + ruido_bajo;
var2 = 0.5;
ruido_alto = sqrt(var2) * randi([-1, 1], size(t));
x_ruido_alto = x_original + ruido_alto;

% Graficos
figure('Name', 'Integrador Parte II:');
subplot(3,1,1);
plot(t, x_original, 'b'); title('Señal Original');
grid on;
subplot(3,1,2);
plot(t, x_ruido_bajo, 'r'); title('Señal con ruido bajo');
grid on;
subplot(3,1,3);
plot(t, x_ruido_alto, 'r'); title('Señal con ruido alto');
grid on;

% Mostrar en pantalla estos resultados:
P_senal = mean(x_original.^2);
P_ruido_bajo = mean(ruido_bajo.^2);
P_ruido_alto = mean(ruido_alto.^2);

fprintf(' --- Valores Potencia Iniciales: \n');
fprintf('Potencia Señal: %.4f \n', P_senal);
fprintf('Potencia del Ruido: %.4f \n', P_ruido_bajo);
fprintf('Potencia del Ruido: %.4f \n \n', P_ruido_alto);

% Objetivo SNR = 6 [dB]
SNR_obj = 6;
k = sqrt(P_senal / (P_ruido_bajo * (10).^0.6));

% multiplicar k por el vector de ruido bajo
ruido_nuevo_6dB = k * ruido_bajo;
P_ruido_nuevo_6dB = mean(ruido_nuevo_6dB.^2);
% Comprobacion
SNR_final = 10 * log10(P_senal/P_ruido_nuevo_6dB);

fprintf('Constante calculada para 6 [dB]: %.4f \n', k);
fprintf('SNR de comprobación: %.4f [dB] \n \n', SNR_final);

% ------------ Parte 3 ------------

