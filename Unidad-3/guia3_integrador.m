clc; clear all;
% ----- PARTE 1 -----
N = 500;
fs = 100;
fm = 1000;
fase = 0;
tini = 0;
tfin = (N - 1) / fm;
[t, seno] = generar_senoidal(tini, tfin, fm, fs, fase);

% Media = 0, Varianza = 0.5.
varianza = 0.5;
ruido = sqrt(varianza) * randn(1, N);
x = seno + ruido;

figure(1);
plot(t, x); title('Señal Compuesta: x[n] = senoidal(100Hz) + ruido(var=0.5)');
xlabel('Tiempo [s]'); ylabel('Amplitud');
grid on;

norma2 = norm(x, 2);
energia = norma2^2;
RMS = norma2 / sqrt(N);
Accion = sum(abs(x));
Amplitud = norm(x, inf);

fprintf('--- RESULTADOS PARTE 1 ---\n');
fprintf('Norma-2: %.4f\n', norma2);
fprintf('Energia: %.4f\n', energia);
fprintf('Valor RMS: %.4f\n', RMS);
fprintf('Accion: %.4f\n', Accion);
fprintf('Amplitud maxima (Norma Infinito): %.4f\n\n', Amplitud);


% ----- PARTE 2  -----
[~, seno_referencia] = generar_senoidal(tini, tfin, fm, fs, fase);
correlacion = dot(x, seno_referencia);

% Formula: cos(theta) = dot(x,y) / (norm(x) * norm(y))
cos_theta = correlacion / (norm(seno_referencia) * norm(x));
angulo_rad = acos(cos_theta);
angulo_deg = rad2deg(angulo_rad);

fprintf('--- RESULTADOS PARTE 2 ---\n');
fprintf('Producto interno <x, y>: %.4f\n', correlacion);
fprintf('Angulo entre señales: %.2f grados\n\n', angulo_deg);


% ----- PARTE 3 -----
fs2 = 200;

% Usamos la funcion correcta
[~, v1] = generar_senoidal(tini, tfin, fm, fs, fase);
[~, v2] = generar_senoidal(tini, tfin, fm, fs2, fase);

% Normalizamos los vectores para hacerlos ORTONORMALES (norma = 1)
phi1 = v1 / norm(v1);
phi2 = v2 / norm(v2);

% Obtenemos los coeficientes de proyeccion alfa1 y alfa2
alfa1 = dot(x, phi1);
alfa2 = dot(x, phi2);

% Construimos la senal aproximada (~x)
x_aprox = alfa1 * phi1 + alfa2 * phi2;

% Calculamos el Error Cuadratico Total (ECT)
vector_error = x - x_aprox;
ECT = norm(vector_error)^2;

fprintf('--- RESULTADOS PARTE 3 ---\n');
fprintf('Coeficiente alfa1 (proyeccion 100 Hz): %.4f\n', alfa1);
fprintf('Coeficiente alfa2 (proyeccion 200 Hz): %.4f\n', alfa2);
fprintf('Error Cuadratico Total (ECT): %.4f\n\n', ECT);

figure(2);
subplot(2,1,1);
plot(t, x, 'b', t, x_aprox, 'r', 'LineWidth', 1.5);
title('Señal Original x[n] vs Señal Aproximada ~x[n]');
legend('Señal Original (con ruido)', 'Aproximacion (100 y 200 Hz)');
xlabel('Tiempo [s]');
ylabel('Amplitud');
grid on;

subplot(2,1,2);
plot(t, vector_error, 'k');
title(sprintf('Señal de Error (ECT = %.4f)', ECT));
xlabel('Tiempo [s]');
ylabel('Amplitud del error');
grid on;


% ----- PARTE 4 (Teoria) -----
% Si se cambia la fase de la senal de referencia y[n] a 90 grados (pi/2),
% la onda senoidal original se transforma en una onda coseno.
%
% Como la componente principal de nuestra senal original x[n] es un seno de
% 100Hz y la nueva referencia es un coseno de 100Hz, ambas senales pasan
% a ser ortogonales. Esto se cumple perfectamente porque nuestro intervalo
% de tiempo (0.5 segundos) contiene un numero entero exacto de periodos
% (50 ciclos) de la senal de 100Hz.
%
% El producto interno es una medida de similitud o proyeccion entre vectores.
% Al ser ortogonales, la proyeccion de la senoidal de x[n] sobre la nueva
% y[n] (desfasada) sera cero.
%
% Por lo tanto, el valor del producto interno entre x[n] e y[n] caera
% drasticamente a un valor muy cercano a 0. El unico valor resultante
% sera el pequeno aporte del producto interno entre el vector de ruido
% aleatorio y la nueva referencia, ya que la correlacion principal se anula.
% =========================================================================
