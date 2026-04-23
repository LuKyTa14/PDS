% -------------------
% PARTE 2:
% -------------------
% Parametros de la simulacion
N = 20; % Numero de muestras solicitadas
n = 0:N-1; % Vector de tiempo discreto

% Coeficientes de la ecuacion en diferencias
% b: coeficientes de x (entrada) -> 1*x[n] + 0.2*x[n-1]
% a: coeficientes de y (salida)  -> 1*y[n] - 0.6*y[n-1]
b = [1, 0.2];
a = [1, -0.6];

% Generacion del impulso unitario delta[n]
% Un 1 en la primera posicion, el resto ceros
delta = [1, zeros(1, N-1)];

% Calculo de la respuesta al impulso h[n]
h = filter(b, a, delta);
% Utilizamos filter(b, a, delta) porque es la herramienta para resolver
% sistemas descritos por ecuaciones en diferencias con realimentación (IIR).
% A diferencia del conv(), filter no requiere conocer la respuesta al
% impulso completa, sino que calcula recursivamente cada salida basandose
% en los estados anteriores, respetando la causalidad y el reposo inicial.

disp("Muestras de la respuesta al impulso h[n]: \n");
disp("    n      h[n] \n")
disp([(0:N-1)', h']);

figure;
stem(n, h, 'filled', 'MarkerSize', 6, 'LineWidth', 1.5);
grid on;
title('Respuesta al impulso h[n] (Primeras 20 muestras)');
xlabel('n (muestras)');
ylabel('Amplitud h[n]');

% Observando h[n], se aprecia una respuesta decreciente que
% tiende a cero a medida que n aumenta. Esto verifica visualmente que el
% sistema es estable.

% -------------------
% PARTE 3:
% -------------------
x = [0 1 2 3 4 5 6 7 8 9];
h_sist = h;

L = length(x);
M = length(h);
N = L + M - 1;  %(10 + 20 - 1 = 29)

% a) Convolución Lineal
y_a = convolucion_lineal(x, h_sist);

% b) Representación Matricial
% Creamos la matriz de convolución manualmente para las primeras muestras
H = zeros(N, L);
for i = 1:L
    H(i:i+M-1, i) = h_sist';
end
y_b = (H * x')';

% c) Convolución Circular
% Zero Padding a longitud N
x_pad = [x, zeros(1, N-L)];
h_pad = [h, zeros(1, N-M)];
y_c = convolucion_circular(x_pad, h_pad);

% d) Verificacion mediante gráficos
figure('Name', 'Integrador Parte III');

subplot(3,1,1);
stem(0:N-1, y_a, 'r', 'filled');
title('a) Convolución Lineal');
grid on;

subplot(3,1,2);
stem(0:N-1, y_b, 'g', 'filled');
title('b) Convolución Matricial');
grid on;

subplot(3,1,3);
stem(0:N-1, real(y_c), 'b', 'filled');
title('c) Convolución Circular (con Zero-Padding)');
grid on;

% -------------------
% PARTE 4:
% -------------------
% La deconvolucion actua como un filtro inverso.
% Todo sistema fisico o LTI tiende a disminuir ciertas frecuencias de la
% señal de entrada. Por lo tanto, el filtro inverso intentara recuperar esa
% información amplificando fuertemente esas frecuencias.

% Como el ruido aleatorio contiene energia en todas las frecuencias, el proceso
% de deconvolucion resulta contraproducente: el filtro inverso amplificara
% drasticamente aquellas bandas donde el sistema original tenia baja energia,
% magnificando el ruido de tal forma que destruira por completo la señal x[n] recuperada.

% Por lo tanto, el ruido vuelve completamente inestable al filtro inverso,
% haciendo que la deconvolucion directa sea inviable para aplicaciones reales.
