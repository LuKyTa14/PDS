clc; clear all;
N = 10;
n = 0:1:(N-1);
delta = zeros(1,N);
delta(1) = 1;
a = 0.5;

% Creamos delta[n-1] desplazando el vector
% Usamos [0 delta(1:end-1)] para mover el 1 una posición a la derecha
% delta es [1, 0, 0, 0, 0, ... ]
% delta desplazada es [ 0, 1, 0, 0, 0, ... ], ya que n = 1 es 1
delta_atrasada = [0, delta(1:end-1)];

% Ahora x se calcula para todos los n de una sola vez
x = delta - a .* delta_atrasada;

ha = sin(8 .* n);
hb = a .^ n;

w = convolucion_lineal(x, ha);
disp("Primer convolucion: \n");
disp(w');

y = convolucion_lineal(w, hb);
disp("Segunda convolucion: \n");
disp(y');

% Debido a la propiedad conmutativa de los sistemas LTI
% el orden de los sistemas en cascada no altera
% la respuesta total del sistema.
% Por lo tanto, y[n] debe ser idéntica en ambos casos.

w2 = convolucion_lineal(x, hb);
disp("Primer Convolucion Invertida: \n");
disp(w2');

y2 = convolucion_lineal(w2, ha);
disp("Segunda Convolucion Invertida: \n");
disp(y2');

disp("Como se puede ver, las convoluciones finales son iguales. \n");

% Grafico
figure('Name', 'Ejercicio 3: Sistemas en Cascada');
n_final = 0 : length(y) - 1;

stem(n_final, y, 'b', 'filled'); hold on; grid on;
stem(n_final, y2, 'r', 'Marker', 'o');
title('Comparación de Sistemas en Cascada LTI');
legend('Conexión Original (hA -> hB)', 'Conexión Invertida (hB -> hA)');

