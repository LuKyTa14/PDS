% Analisis de propiedades de los sistemas
n = -20:20;
x = sin(0.2*pi*n);

figure('Name', 'Entrada x[n]');
stem(n, x, 'r');
title('Entrada x[n]');
figure('Name', 'Sistemas y[n]');

% -------------------------------------------------------------------------------
% Sistema 1: y[n] = A*sin(w*n*T) * x[n]
% Memoria: No posee. Solo depende del instante n actual.

% Causalidad: Si. No depende de valores futuros de x[n].

% Linealidad:
% x1[n] -> y1[n]
% x2[n] -> y2[n]
% a * x1[n] + b * x2[n] = a * y1[n] + b * y2[n]
% Para todos los casos vamos a usar a = 1 y b = 1 para simplificar calculos
% x3 = x1 + x2
% Es y3 = y1 + y2?
% y1 = A*sin(w*n*T) * x1[n]
% y2 = A*sin(w*n*T) * x2[n]
% y3 = A*sin(w*n*T) * x3[n] = A*sin(w*n*T) * (x1[n] + x2[n]) =
% = A*sin(w*n*T) * x1[n] + A*sin(w*n*T) * x2[n]
% Por ende si cumple con la linealidad, por cumplir el principio de superposicion.

% Invarianza: No. El coeficiente g[n] cambia con n, por lo que desplazar
% la entrada no es igual a desplazar la salida.

A = 1;
w = 0.5*pi;
T = 1;

y1 = A * sin(w*n*T) .* x;

subplot(4, 1, 1);
stem(n, y1);
title('Salida y[n] - Sistema 1');

% -------------------------------------------------------------------------------
% Sistema 2: y[n] = Sumatoria de x[k] (n-n0 a n+n0)
% Memoria: Si. "Almacena" y suma valores pasados.

% Causalidad: No. El limite superior n+n0 accede a valores futuros.

% Linealidad:
% x3 = x1 + x2
% Es y3 = y1 + y2?
% y1 = sum(x1[k]) de (n-n0 a n+n0)
% y2 = sum(x2[k]) de (n-n0 a n+n0)
% y3 = sum(x1[k] + x2[k]) de (n-n0 a n+n0)
% Lo que por propiedades de sumatoria es igual a
% = sum(x1[k]) de (n-n0 a n+n0) + sum(x2[k]) de (n-n0 a n+n0)
% Con lo cual si cumple con el principio de superposicion, y por ende
% con la propiedad de linealidad.

% Invarianza: Si. Un desplazamiento en el tiempo n
% solo corre la ventana de la sumatoria uniformemente.

n0 = 3;
y2 = zeros(size(n));

for i = 1:length(n)
    inicio = max(1, i - n0);
    % Ya que si es negativo i - n0 consideramos el valor  en i = 1 para el intervalo
    % porque no hay posiciones negativas en el vector (cuando i = 2, por ejemplo, i - n0 = -1).

    fin = min(length(n), i + n0);
    % Aqui sucede lo mismo que en el caso anterior pero con el maximo. Tenemos 41 valores [-20;20]
    % en el vector, por lo que no consideramos valores mas alla del rango del vector
    % (Por ejemplo, cuando i = 39 -> i + n0 = 42, y no hay un valor del vector con ese i).

    y2(i) = sum(x(inicio:fin));
end

subplot(4, 1, 2);
stem(n, y2);
title('Salida y[n] - Sistema 2');

% -------------------------------------------------------------------------------
% Sistema 3: y[n] = x[n] + 2
% Memoria: No posee, ya que no depende de valores pasados de la entrada.

% Causalidad: Si. Solo depende del valor actual de x[n], no de valores futuros.

% Linealidad:
% x3 = x1 + x2
% Es y3 = y1 + y2?
% y1 = x1[n] + 2
% y2 = x2[n] + 2
% y3 = (x1[n] + x2[n]) + 2 = x1[n] + x2[n] + 2
% Pero y1[n] + y2[n] = x1[n] + x2[n] + 4, por ende no se cumple el principio
% de superposicion, y por tanto tampoco la propiedad de linealidad.

% Invarianza: Si. La constante 2 no depende de n, por lo que el
% sistema se comporta igual en cualquier momento.

y3 = x + 2;

subplot(4, 1, 3);
stem(n, y3);
title('Salida y[n] - Sistema 3');

% -------------------------------------------------------------------------------
% Sistema 4: y[n] = n * x[n]
% Memoria: No posee, ya que la salida no depende de valores pasados de la entrada.

% Causalidad: Si, la salida no depende de valores futuros de la entrada.

% Linealidad:
% x3 = x1 + x2
% Es y3 = y1 + y2?
% y1 = n * x1[n]
% y2 = n * x2[n]
% y3 = n * x3[n] = n * (x1[n] + x2[n]) = n * x1[n] + n * x2[n] = y1[n] + y2[n]
% Por ende, se cumple el principio de superposicion y, por tanto, la propiedad
% de linealidad.

% Invarianza: No, ya que si x[n] se atrasa, el n multiplicador
% no se atrasa con la senial, alterando el resultado.

y4 = n .* x;

subplot(4, 1, 4);
stem(n, y4);
title('Salida y[n] - Sistema 4');
