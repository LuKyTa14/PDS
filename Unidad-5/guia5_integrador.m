clc; clear; close all;
pkg load signal

% ---------------------------------------------------------
disp("=============");
disp("PARTE I");

% H(z) = (1 + 0.5 z^-1)/(1 - 0.8 z^-1 + 0.12 z^-2)

b = [1 0.5];
a = [1 -0.8 0.12];

% Polos y ceros
ceros = roots(b);
polos = roots(a);

disp("Ceros:"); disp(ceros);
disp("Polos:"); disp(polos);

% Estabilidad
if all(abs(polos) < 1)
    disp("El Sistema es ESTABLE");
else
    disp("El Sistema es INESTABLE");
endif

% Mapa polos y ceros
figure("Name","Parte I - Polos y Ceros");
zplane(b,a);
title("Parte I - Polos y Ceros");

% ---------------------------------------------------------
% PARTE II
disp("=============");
disp("PARTE II");

fm = 1000;

% Magnitud y fase
[H,f] = freqz(b,a,1024,fm);
figure("Name","Parte II - Respuesta en Frecuencia");

% Magnitud lineal
subplot(3,1,1)
plot(f,abs(H),'b','LineWidth',2);
grid on;
xlabel('Frecuencia (Hz)');
ylabel('|H(f)|');
title('Magnitud Lineal');

% Magnitud en dB
subplot(3,1,2)
plot(f,20*log10(abs(H)),'r','LineWidth',2);
grid on;
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (dB)');
title('Magnitud en dB');

% Fase
subplot(3,1,3)
plot(f,unwrap(angle(H))*180/pi,'k','LineWidth',2);
grid on;
xlabel('Frecuencia (Hz)');
ylabel('Fase (°)');
title('Fase');

% Respuesta al impulso
imp = [1 zeros(1,50)];
h = filter(b,a,imp);
figure("Name","Parte II - Respuesta al Impulso");
stem(0:length(h)-1,h,'filled');
grid on;
xlabel('n');
ylabel('h[n]');
title('Respuesta al Impulso');

% ---------------------------------------------------------
% PARTE III
disp("=============");
disp("PARTE III");

T = 0.1;

% H(s)=1/(s+1)
% Euler:
% s=(1-z^-1)/T
% H(z)=T/(1+T-z^-1)

num_euler = [T];
den_euler = [1+T -1];
% Normalizamos
num_euler = num_euler/(1+T);
den_euler = den_euler/(1+T);

disp("Numerador Euler:"); disp(num_euler);
disp("Denominador Euler:"); disp(den_euler);

% Respuesta en frecuencia analógica
w = linspace(0,30,1000);
Hs = freqs([1],[1 1],w);
f_analog = w/(2*pi);

% Respuesta discreta Euler
[He,fe] = freqz(num_euler,den_euler,1024,1/T);

% ---------------------------------------------------------
% PARTE IV
disp("=============");
disp("PARTE IV");

K = 2 / T;

num_bilin = [1, 1];
den_bilin = [(K + 1), (1 - K)];
% Normalizamos dividiendo por el primer término del denominador
num_bilin = num_bilin / den_bilin(1);
den_bilin = den_bilin / den_bilin(1);

disp("Numerador Bilineal:"); disp(num_bilin);
disp("Denominador Bilineal:"); disp(den_bilin);

% Respuesta en frecuencia
[Hb,fb] = freqz(num_bilin,den_bilin,1024,1/T);


% ===================================
% ECUACIONES EN DIFERENCIAS
disp("=============");
disp("ECUACIONES EN DIFERENCIAS");
disp("Euler:  ");  disp("y[n] - 0.9091 y[n-1] = 0.0909 x[n]");
disp("Bilineal:   ");  disp("y[n] - (19/21)y[n-1] = (1/21)x[n] + (1/21)x[n-1]");
% ===================================
% GRAFICO GLOBAL (PARTE III Y IV)
figure("Name", "Comparativa Global de Transformaciones", "Position", [100 100 1000 650]);

% Analógica vs Euler
subplot(2, 2, 1);
plot(f_analog, 20*log10(abs(Hs)), 'k', 'LineWidth', 2); hold on;
plot(fe, 20*log10(abs(He)), 'b--', 'LineWidth', 2);
grid on;
title('Analógica vs Euler');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (dB)');
legend('Analógica', 'Euler', 'Location', 'southwest');
xlim([0 5]); % Acotamos para ver la zona de corte
ylim([-25 5]);

% Analógica vs Bilineal
subplot(2, 2, 2);
plot(f_analog, 20*log10(abs(Hs)), 'k', 'LineWidth', 2); hold on;
plot(fb, 20*log10(abs(Hb)), 'r-.', 'LineWidth', 2);
grid on;
title('Analógica vs Bilineal');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (dB)');
legend('Analógica', 'Bilineal', 'Location', 'southwest');
xlim([0 5]);
ylim([-25 5]);

% Comparación de las tres
subplot(2, 2, [3, 4]);
plot(f_analog, 20*log10(abs(Hs)), 'k', 'LineWidth', 2); hold on;
plot(fe, 20*log10(abs(He)), 'b--', 'LineWidth', 2);
plot(fb, 20*log10(abs(Hb)), 'r-.', 'LineWidth', 2);
grid on;
title('Comparación Total: Analógica - Euler - Bilineal');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (dB)');
legend('Analógica', 'Euler', 'Bilineal', 'Location', 'southwest');
xlim([0 5]);
ylim([-25 5]);
