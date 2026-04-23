clc; clear all;
% Definicion de señales de prueba (N muestras)
x = [1,2,2];
h = [2,1,0.5];

long_h = length(h);
long_x = length(x);

% Con nuestra funcion:
y_manual = convolucion_lineal(x,h);

% Funcion conv:
y_conv = conv(x, h);

% Funcion filter:
% Para que filter sea una convolucion: A = 1, B = h
% Hacemos A[1] = 1 ya a multiplica y[n]. Del otro lado de la igualdad de filter
% esta A[2], que en nuestro caso ya es 0.
% Como B[n] = h[n], la formula filter termina siendo
% y[n] = sum(h[n] * x[n]) que es la formula de convolucion
% Importante: filter devuelve la misma longitud que la entrada x.
% Para obtener la convolucion completa (k+n-1 de dimension), debemos rellenar
% la entrada x con la cantidad de ceros de dimension h-1 (zero padding visto en teoria).
% Ponemos h - 1 ceros para que tengamos una x de dimension x + h - 1 que es la
% dimension de la convolucion.
x_paddeada = [x, zeros(1, long_h - 1)];
A_filtro = [1];
B_filtro = h;
y_filter = filter(B_filtro, A_filtro, x_paddeada);

disp("Resultado Manual:");
disp(y_manual);

disp("Resultado con conv():");
disp(y_conv);

disp("Resultado con filter():");
disp(y_filter);

% Graficos
figure('Name', 'Comparación de metodos de convolución');
Ny = long_x + long_h - 1;
vector_n = 0 : Ny-1;

subplot(3,1,1);
stem(vector_n, y_manual, 'b', 'filled');
title('1. Sumatoria Manual'); grid on;

subplot(3,1,2);
stem(vector_n, y_conv, 'r', 'filled');
title('2. Comando conv(x,h)'); grid on;

subplot(3,1,3);
stem(vector_n, y_filter, 'g', 'filled');
title('3. Comando filter() con zero-padding');
xlabel('Muestras (n)'); grid on;
