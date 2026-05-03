clc; clear all;
fm = 100;
t = 0:1/fm:1-1/fm;
t_inicial = t(1);
t_final = t(end);
fs1 = 5;
fase1 = 0;

% Senoidal original
[~,x] = generar_senoidal(t_inicial, t_final, fm, fs1, fase1);

% Misma señal
[~, y_identica] = generar_senoidal(t_inicial, t_final, fm, fs1, fase1);

% Cambio de fase (Desfase de 90 grados u ortogonales)
fase2 = pi/2;
[~, y_desfasada] = generar_senoidal(t_inicial, t_final, fm, fs1, fase2);

% Cambio de frecuencia (Señales distintas)
fsnueva2 = 10;
[~, y_frecuencia] = generar_senoidal(t_inicial, t_final, fm, fsnueva2, fase1);

% Producto interno
% Usamos trapz para una integracion mas precisa
prod_identica = trapz(t, x .* y_identica);
prod_desfasada = trapz(t, x .* y_desfasada);
prod_frecuencia = trapz(t, x .* y_frecuencia);

fprintf('1. Señales identicas: %f\n', prod_identica);
fprintf('2. Señales desfasadas (90 grados): %f\n', prod_desfasada);
fprintf('3. Señales dist. frecuencia: %f\n', prod_frecuencia);

% Identicas: 0.499523
% Interpretacion: El valor es alto y positivo, muy cercano al teorico de 0.5.
% Esto indica el maximo parecido posible (las senales estan en fase).
% El producto interno en este caso representa la energia de la senal.
% Cada valor positivo de x se multiplica por un positivo de y, sumando area.

% Desfasadas 90 grados: 0.001469
% Interpretacion: El valor es casi cero (la pequena diferencia es error numerico).
% Esto demuestra que las senales son ortogonales (como un seno y un coseno).
% No tienen parecido entre si: cuando una llega a su pico, la otra vale cero.
% Lo que se suma de area en un tramo se resta exactamente en el siguiente.

% Distinta frecuencia: -0.000908
% Interpretacion: El valor es despreciable o tiende a cero.
% Refleja la propiedad de ortogonalidad.
% Aunque ambas sean senoidales, al tener distintas frecuencias (5Hz y 10Hz),
% no guardan correlacion a lo largo del tiempo de integracion.
% el area total se cancela y da 0 (aproximado)

% Conclusion:
% El producto interno funciona como un medidor de correlacion o similitud.
% Frecuencia (f): Si son distintas, el parecido es nulo (resultado 0).
% Fase (phi): Determina la alineacion; a 0 radianes es maximo, a pi/2 es nulo.
