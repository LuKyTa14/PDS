% DEMOSTRACION DE ALIASING (PLEGADO DE FRECUENCIAS)
fm = 50; % Frecuencia de muestreo (50 Hz)
tini = 0;
tfin = 1; % N = 50 muestras
fase = 0;

% Generamos las señales base
[t, sen_27]  = generasen(tini, tfin, fm, 27, fase);
[~, sen_105] = generasen(tini, tfin, fm, 105, fase);

% Multiplicamos por 2 para cumplir la ecuacion x(t) = 2*sin(...)
x_27 = 2 * sen_27;
x_105 = 2 * sen_105;

N = length(t);

% Vector de frecuencias (Resolucion fm/N = 50/50 = 1 Hz)
f_vec = (0:N-1) * (fm/N);

% Calculamos las Transformadas
X_27 = fft(x_27);
X_105 = fft(x_105);

% GRAFICOS
figure('Name', 'Demostracion de Aliasing', 'Position', [100 100 800 600]);

% Grafico 1: El caso del enunciado (27 Hz)
subplot(2,1,1);
stem(f_vec, abs(X_27), 'b', 'filled', 'MarkerSize', 5);
title('FFT de Señal de 27 Hz');
xlabel('Frecuencia observada (Hz)'); ylabel('|X[k]|');
xlim([0 50]);
xticks(0:5:50); % marcas cada 5 Hz
grid on;

% Grafico 2: Nuestro caso extremo (105 Hz)
subplot(2,1,2);
stem(f_vec, abs(X_105), 'r', 'filled', 'MarkerSize', 5);
title('FFT de Señal de 105 Hz');
xlabel('Frecuencia observada (Hz)'); ylabel('|X[k]|');
xlim([0 50]);
xticks(0:5:50);
grid on;

% ALIASING Y TEOREMA DE NYQUIST
% Ocurre cuando la frecuencia de muestreo (fm) es demasiado "lenta" para
% seguirle el ritmo a la onda original. Como la computadora solo guarda
% puntos discretos, termina uniendo esos puntos por el camino mas corto,
% "inventando" (o plegando) una frecuencia falsa y mas baja.

% Solucion:
% Para digitalizar una senal sin destruir la informacion ni crear fantasmas,
% la frecuencia de muestreo debe ser estrictamente mayor al doble de la
% frecuencia mas alta presente en la senal.
% Formula: fm > 2 * fs

% Conclusion
% Al setear fm = 300 Hz, cumplimos sobradamente con Nyquist tanto para
% la senal de 27 Hz (pedia fm > 54) como para la de 105 Hz (pedia fm > 210).
% Al sacarle suficientes "fotos" por segundo, la FFT ahora si dibuja los
% picos en sus frecuencias reales exactas.

fm1 = 300;

[t_nuevo, sen_nuevo_27]  = generasen(tini, tfin, fm1, 27, 0);
[~, sen_nuevo_105] = generasen(tini, tfin, fm1, 105, 0);

x_nuevo_27 = 2 * sen_nuevo_27;
x_nuevo_105 = 2 * sen_nuevo_105;

N_nuevo = length(t_nuevo);

f_vec_nueva = (0:N_nuevo-1) * (fm1/N_nuevo);

X_nueva_27 = fft(x_nuevo_27);
X_nueva_105 = fft(x_nuevo_105);

% GRAFICOS
figure('Name', 'Nyquist', 'Position', [100 100 800 600]);

% Grafico 1: 27 Hz muestreada correctamente
subplot(2,1,1);
stem(f_vec_nueva, abs(X_nueva_27), 'b', 'filled', 'MarkerSize', 4);
title('FFT de Señal de 27 Hz (Muestreada a 300 Hz)');
xlabel('Frecuencia (Hz)'); ylabel('|X[k]|');
xlim([0 150]); % Mostramos solo hasta fm/2
xticks(0:15:150);
grid on;

% Grafico 2: 105 Hz muestreada correctamente
subplot(2,1,2);
stem(f_vec_nueva, abs(X_nueva_105), 'r', 'filled', 'MarkerSize', 4);
title('FFT de Señal de 105 Hz (Muestreada a 300 Hz)');
xlabel('Frecuencia (Hz)'); ylabel('|X[k]|');
xlim([0 150]); % Mostramos solo hasta fm/2
xticks(0:15:150);
grid on;

