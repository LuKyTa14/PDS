% Parametros para crear matriz
N = 1000;
M = 500;

% randn genera distribución normal (media 0, varianza 1)
% M filas (señales) ; N columnas (tiempo)
X = randn(M, N);

% PARTE A: Estacionariedad
% Si es estacionaria, estos valores deben mantenerse constantes en el tiempo.
media_ensamble = mean(X, 1);
var_ensamble = var(X, 0, 1);

figure('Name', 'Estacionalidad ');
subplot(2,1,1);
plot(media_ensamble, 'LineWidth', 1); title('Media en el tiempo');
yline(0, '--r');
grid on;
subplot(2,1,2);
plot(var_ensamble, 'LineWidth', 1); title('Varianza en el tiempo');
yline(1, '--r');
grid on;

% PARTE B: Ergodicidad
% Como evoluciona a lo largo del tiempo para una sola. Si es ergolica, al aumentar N, debe converger a los valores (0 y 1).
x_una_senal = X(1, :);
vector_tiempo = 1:N;

% Media temporal = promedio desde 1 hasta la n
media_temporal_acum = cumsum(x_una_senal) ./ vector_tiempo;
% Var temporal = E[X^2] - (E[X])^2
potencia_acum = cumsum(x_una_senal.^2) ./ vector_tiempo;
var_temporal_acum = potencia_acum - (media_temporal_acum.^2);

figure('Name', 'Ergodicidad');
subplot(2,1,1);
plot(vector_tiempo, media_temporal_acum, 'b'); hold on;
yline(0, '--r');
title('Media Acumulada de una señal');
grid on;
subplot(2,1,2);
plot(vector_tiempo, var_temporal_acum, 'b'); hold on;
yline(1, '--r');
title('Varianza Acumulada de una señal');
grid on;

% Funciones utilizadas parametros
% mean(matriz, dimension);
% var(matriz, opt, dimension);
        % opt = 0 --> Calcula la varianza muestral ; opt = 1 -->  Calcula la varianza poblacional
 % cumsum -->  suma acumulada
 % cumsum([2, 4, 6, 8])  -->  [2, 6, 12, 20]

% --------- Explicacion -----------
% Estacionaridad:
% Se observa que tanto la media del conjunto como la varianza del conjunto se mantienen
% estables alrededor de sus valores teoricos (0 y 1 respectivamente) a lo
% largo de todo el eje del tiempo.
% Esto demuestra que las propiedades estadisticas de la señal no cambian con
% el tiempo (t), cumpliendo la condicion de Estacionariedad en Sentido Amplio.

% Ergodicidad:
% Se observa que al inicio (pocas muestras), el promedio y la varianza de la
% señal individual oscilan mucho. Sin embargo, a medida que el numero de
% muestras (N) aumenta, los valores de la media y varianza acumuladas convergen
% a los valores del conjunto.
% El hecho de que el promedio temporal de una sola realización tienda al mismo
% valor que el promedio de todas las realizaciones demuestra que la señal es ergodica.
% Esto significa que una sola muestra lo suficientemente larga es representativa
% de todo el proceso estadistico.

% Cuando los valores tienden a infinito, entonces la media y varianza tienden a 0 y 1
% respectivamente. Pero podemos ver con unos pocos valores como ya se aproxima muy bien
% a estos valores.

