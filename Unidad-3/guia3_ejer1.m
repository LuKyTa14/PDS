clc; clear all;

fm = 100; % Frecuencia de muestreo
t = 0:1/fm:1-1/fm; % Vector de tiempo
fs = 5; % Frecuencia señales
A = 1; % Amplitud
m = 1; % Pendiente
fase = 0; % Fase

t_inicial = t(1);
t_final = t(end);

% Generación de señales (capturando la amplitud en la segunda variable)
[~, senoidal] = generar_senoidal(t_inicial, t_final, fm, fs, fase);
[~, rampa]    = generar_rampa(t_inicial, t_final, fm, m);
[~, cuadrada] = generar_cuadrada(t_inicial, t_final, fm, fs, fase); % Nombre corregido
aleatoria = randn(size(t)); % Limpiado el espacio extra

% Gráficos compactos
figure(1);
subplot(4,1,1); plot(t, senoidal); title('Senoidal'); grid on;
subplot(4,1,2); plot(t, rampa);    title('Rampa'); grid on;
subplot(4,1,3); plot(t, cuadrada); title('Cuadrada'); grid on; ylim([-1.5 1.5]);
subplot(4,1,4); plot(t, aleatoria);title('Aleatoria'); grid on;
xlabel('Tiempo (s)');

% Gráficos
figure(2);
subplot(4,1,1); stem(t, senoidal); title('Senoidal'); ylabel('Amp'); grid on;
subplot(4,1,2); stem(t, rampa); title('Rampa'); ylabel('Amp'); grid on;
subplot(4,1,3); stem(t, cuadrada); title('Cuadrada'); ylabel('Amp'); grid on; ylim([-1.5 1.5]);
subplot(4,1,4); stem(t, aleatoria); title('Aleatoria'); ylabel('Amp'); grid on;
xlabel('Tiempo (s)');

% Analisis de cada Funcion Individual
analizar_propiedades('senoidal', t, senoidal);
analizar_propiedades('rampa', t, rampa);
analizar_propiedades('cuadrada', t, cuadrada);
analizar_propiedades('aleatoria', t, aleatoria);
