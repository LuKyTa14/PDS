clc; clear all;

fm = 100;
t = 0:1/fm:1-1/fm;
t_inicial = t(1);
t_final = t(end);
fs1 = 5;
fase1 = 0;

% Senoidal original
[~,x] = generar_senoidal(t_inicial, t_final, fm, fs1, fase1);

[~, y_identica] = generar_senoidal(t_inicial, t_final, fm, fs1, fase1);

% Cambio de fase (Desfase de 90 grados u ortogonales)
fase2 = pi/2;
[~, y_desfasada] = generar_senoidal(t_inicial, t_final, fm, fs1, fase2);

% Cambio de frecuencia (Señales distintas)
fsnueva2 = 10;
[~, y_frecuencia] = generar_senoidal(t_inicial, t_final, fm, fsnueva2, fase1);


% Producto Interno en Discreto
prod_identica = dot(x, y_identica);
prod_desfasada = dot(x, y_desfasada);
prod_frecuencia = dot(x, y_frecuencia);

fprintf('--- RESULTADOS PRODUCTO INTERNO DISCRETO ---\n');
fprintf('1. Señales identicas: %5f\n', prod_identica);
fprintf('2. Señales desfasadas (90 grados): %5f\n', prod_desfasada);
fprintf('3. Señales dist. frecuencia: %5f \n', prod_frecuencia);


% --- Interpretacion ---
% 1. Identicas: Da exactamente 50.
% Interpretación: El producto interno de una señal consigo misma es igual a
% su energía discreta (Norma-2 al cuadrado).
% Como N=100 muestras y el valor medio del seno al cuadrado es 0.5,
% la sumatoria pura da 100 * 0.5 = 50.

% 2. Desfasadas 90 grados: Da aproximadamente 0.
% Interpretación: Si el ángulo es 90° (cos=0), el producto interno es cero.
% Decimos que las señales son ortogonales. En el espacio discreto,
% los vectores x e y_desfasada son perpendiculares en R^100.

% 3. Distinta frecuencia (5Hz vs 10Hz): Da aproximadamente 0.
% Interpretación: Al tener frecuencias que son múltiplos enteros dentro de la
% ventana de observación, ambas señales conforman una base ortogonal. El aporte
% de una en la otra es nulo.
