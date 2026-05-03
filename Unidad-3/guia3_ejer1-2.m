clc; clear all;
fm = 100; % Frecuencia de muestreo
t = 0:1/fm:1-1/fm; % Vector de tiempo
fs = 5; % Frecuencia señales
A = 1; % Amplitud
m = 1; % Pendiente
fase = 0; % Fase

t_inicial = t(1);
t_final = t(end);

[~, senoidal] = generar_senoidal(t_inicial, t_final, fm, fs, fase);
[~, rampa] = generar_rampa(t_inicial, t_final, fm, m);
[~, cuadrada] = generar_cuadrada(t_inicial, t_final, fm, fs, fase); % Nombre corregido
aleatoria = randn(size(t)); % Limpiado el espacio extra

figure(1);
subplot(4,1,1); stem(t, senoidal); title('Senoidal'); ylabel('Amp'); grid on;
subplot(4,1,2); stem(t, rampa); title('Rampa'); ylabel('Amp'); grid on;
subplot(4,1,3); stem(t, cuadrada); title('Cuadrada'); ylabel('Amp'); grid on; ylim([-1_5 1_5]);
subplot(4,1,4); stem(t, aleatoria); title('Aleatoria'); ylabel('Amp'); grid on;
xlabel('Tiempo (s)');

% Senoidal
senoidal_medio = mean(senoidal);
senoidal_maximo = max(senoidal);
senoidal_minimo = min(senoidal);
senoidal_amplitud = (max(senoidal) - min(senoidal)) / 2;
senoidal_energia = trapz(t, senoidal.^2); % Integral energia
senoidal_accion = trapz(t, abs(senoidal)); % Integral accion
senoidal_potencia = mean(senoidal.^2);
senoidal_rms = sqrt(senoidal_potencia);

% Rampa
rampa_medio = mean(rampa);
rampa_maximo = max(rampa);
rampa_minimo = min(rampa);
rampa_amplitud = (max(rampa) - min(rampa))/2;
rampa_energia = trapz(t, rampa.^2);
rampa_accion = trapz(t, abs(rampa));
rampa_potencia = mean(rampa.^2);
rampa_rms = sqrt(rampa_potencia);

% Cuadrada
cuadrada_medio = mean(cuadrada);
cuadrada_maximo = max(cuadrada);
cuadrada_minimo = min(cuadrada);
cuadrada_amplitud = (max(cuadrada) - min(cuadrada)) / 2;
cuadrada_energia = trapz(t, cuadrada.^2);
cuadrada_accion = trapz(t, abs(cuadrada));
cuadrada_potencia = mean(cuadrada.^2);
cuadrada_rms = sqrt(cuadrada_potencia);

% Aleatoria
aleatoria_medio = mean(aleatoria);
aleatoria_maximo = max(aleatoria);
aleatoria_minimo = min(aleatoria);
aleatoria_amplitud = (max(aleatoria) - min(aleatoria)) / 2;
aleatoria_energia = trapz(t, aleatoria.^2);
aleatoria_accion = trapz(t, abs(aleatoria));
aleatoria_potencia = mean(aleatoria.^2);
aleatoria_rms = sqrt(aleatoria_potencia);

% Salida en consola
fprintf('Salidas señal senoidal:\n');
fprintf('1. Valor Medio: %f\n', senoidal_medio);
fprintf('2. Maximo: %f\n', senoidal_maximo);
fprintf('3. Minimo: %f\n', senoidal_minimo);
fprintf('4. Amplitud: %f\n', senoidal_amplitud);
fprintf('5. Energia: %f\n', senoidal_energia);
fprintf('6. Accion: %f\n', senoidal_accion);
fprintf('7. Potencia Media: %f\n', senoidal_potencia);
fprintf('8. Valor RMS: %f\n', senoidal_rms);
fprintf("\n\n");

fprintf('Salidas señal rampa:\n');
fprintf('1. Valor Medio: %f\n', rampa_medio);
fprintf('2. Maximo: %f\n', rampa_maximo);
fprintf('3. Minimo: %f\n', rampa_minimo);
fprintf('4. Amplitud: %f\n', rampa_amplitud);
fprintf('5. Energia: %f\n', rampa_energia);
fprintf('6. Accion: %f\n', rampa_accion);
fprintf('7. Potencia Media: %f\n', rampa_potencia);
fprintf('8. Valor RMS: %f\n', rampa_rms);
fprintf("\n\n");

fprintf('Salidas señal cuadrada:\n');
fprintf('1. Valor Medio: %f\n', cuadrada_medio);
fprintf('2. Maximo: %f\n', cuadrada_maximo);
fprintf('3. Minimo: %f\n', cuadrada_minimo);
fprintf('4. Amplitud: %f\n', cuadrada_amplitud);
fprintf('5. Energia: %f\n', cuadrada_energia);
fprintf('6. Accion: %f\n', cuadrada_accion);
fprintf('7. Potencia Media: %f\n', cuadrada_potencia);
fprintf('8. Valor RMS: %f\n', cuadrada_rms);
fprintf("\n\n");

fprintf('Salidas señal aleatoria:\n');
fprintf('1. Valor Medio: %f\n', aleatoria_medio);
fprintf('2. Maximo: %f\n', aleatoria_maximo);
fprintf('3. Minimo: %f\n', aleatoria_minimo);
fprintf('4. Amplitud: %f\n', aleatoria_amplitud);
fprintf('5. Energia: %f\n', aleatoria_energia);
fprintf('6. Accion: %f\n', aleatoria_accion);
fprintf('7. Potencia Media: %f\n', aleatoria_potencia);
fprintf('8. Valor RMS: %f\n', aleatoria_rms);


