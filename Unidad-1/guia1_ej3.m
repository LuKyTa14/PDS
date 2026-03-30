% Parametros a traves de la figura 1
A = 3;
% Frecuencia de la se~nal
Ts = 0.05;          % Se observan 2 ciclos en 0.1 seg (0.1/2 = 0.05)
fs = 1/Ts;

% Frecuencia y periodo de muestreo
muestras = 80;
tiempo_total = 0.1;
fm = muestras / tiempo_total;
Tm = 1/fm;

% Retardo temporal y Fase
muestras_retardo = 5;
t1 = muestras_retardo * Tm;
phi = -2 * pi * fs * t1;

t = 0 : Tm : 0.1-Tm;
x = A * sin(2 * pi * fs .* t + phi);

figure(1);
stem(t, x, 'b', 'filled'); title('Ejercicio 3');
