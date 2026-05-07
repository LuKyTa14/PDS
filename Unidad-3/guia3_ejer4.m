clc; clear all;
% --- Parte 1: Combinación Lineal Original ---
fm = 100;
fase = 0;
frecuencias_ejemplo = 1:2;
frecuencias = 1:10;
T = 1/fm;
t = 0:T:1-T;
tini = t(1);
tfin = t(end);

senal = zeros(size(t));
senal_ejemplo = zeros(size(t));
funciones_seno = zeros(10, length(t));

% Generamos la combinación lineal y guardamos las base
for f = frecuencias
    [~, seno] = generar_senoidal(tini, tfin, fm, f, fase);
    funciones_seno(f,:) = seno(:);
    senal += seno; % Acumulamos
end

figure(1);
stem(t, senal); grid on;
title('Señal Original');

% Ejemplo gráfico con las primeras dos frecuencias
for f = frecuencias_ejemplo
    [~, seno] = generar_senoidal(tini, tfin, fm, f, fase);
    senal_ejemplo += seno;
    figure(2)
    stem(t, seno);
    hold on;
end
stem(t, senal_ejemplo, 'k', 'LineWidth', 2);
title('Señal Ejemplo (Suma de 1Hz y 2Hz)');
hold off;

% Calculamos similitud (Producto Interno)
valores_similitud = zeros(1,10);
for i = 1:10
    valores_similitud(i) = dot(funciones_seno(i,:), senal);
end

% Gráficos de barra
figure(3);
subplot(3,1,1);
bar(frecuencias, valores_similitud);
xlabel('Frecuencia (Hz)'); ylabel('Similitud');
title('Parte 1: Parecido con cada senoidal (En Fase)');
grid on;

% ¿Por qué el producto interno da exactamente 50?
% 1. Aplicamos el Producto Interno:
% La señal total es la suma de senoidales de frecuencias de 1 a 10 Hz:
% senal = sum( sin(2*pi*f*t) ) para f = 1.....10

% 2. Linealidad y Ortogonalidad:
% Por la propiedad de linealidad, podemos distribuir el producto interno:
% dot(sin_i, senal) = sum( dot(sin_i, sin_f) ) para f = 1..10

% PROPIEDAD: Las senoidales de distinta frecuencia son ORTOGONALES entre si.
% Si i != f  =>  dot(sin_i, sin_f) = 0
% Por lo tanto, todos los terminos cruzados se anulan y solo sobrevive
% el termino donde la frecuencia coincide (i == f) --> dot(sin_i, senal) = dot(sin_i, sin_i)

% 3. Calculo de energia:
% El producto dot(sin_i, sin_i) representa la energia discreta de la senoidal.
% Matematicamente, el valor medio de sin^2(x) sobre periodos enteros es 1/2.
% Como tenemos N = 100 muestras (fm = 100 Hz durante 1 segundo):
% Energia = N * (1/2) = 100 * 0.5 = 50

% Esto indica que:
%  - Todas esas frecuencias estan presentes en la mezcla original.
%  - Todas tienen exactamente la misma amplitud original.

% --- Parte 2: Combinación Lineal con Fase Variada ---
senal_fase = zeros(size(t));
fase_acumulada = 0;

for f = frecuencias
    fase_acumulada += pi/4; % Vamos desfasando cada armónico
    [~, seno] = generar_senoidal(tini, tfin, fm, f, fase_acumulada);
    senal_fase += seno;
end

valores_similitud_fase = zeros(1,10);
for i = 1:10
    % Comparamos la señal desfasada contra nuestra "base" original de fase 0
    valores_similitud_fase(i) = dot(funciones_seno(i,:), senal_fase);
end

subplot(3,1,2);
bar(frecuencias, valores_similitud_fase);
xlabel('Frecuencia (Hz)'); ylabel('Similitud');
title('Parte 2: Parecido variando la fase (+pi/4 por Hz)');
grid on;

% Cuando vale 0 quiere decir que las señales son ortogonales
% Cuando es negativo es que dan desfasadas y sino la similitud

% --- Parte 3: Señal Cuadrada de 5.5 Hz ---
fase_q = 0;
fs_q = 5.5;
[~, cuad] = generar_cuadrada(tini, tfin, fm, fs_q, fase_q);
valores_similitud_cuad = zeros(1,10);

for i = 1:10
    valores_similitud_cuad(i) = dot(funciones_seno(i,:), cuad);
end

subplot(3,1,3)
bar(frecuencias, valores_similitud_cuad);
xlabel('Frecuencia (Hz)'); ylabel('Similitud');
title('Parte 3: Parecido de onda Cuadrada (5.5 Hz) con senoidales enteras');
grid on;

% Todas son cercanas a 0, lo que quiere decir que todas las senoidale son
% ortogonales a nuestra funcion cuadrada (lo que tiene sentido).

% una onda cuadrada perfecta y simétrica está compuesta únicamente
% por su frecuencia fundamental y sus armónicos impares
% (es decir, senos de 5 Hz, 15 Hz, 25 Hz, 35 Hz, etc.).
