clc; clear all; close all;
pkg load signal

% b = coeficientes de X(z) (Numerador)  (x en el grafico)
% a = coeficientes de Y(z) (Denominador) (0 en el grafico)

% -------------------------------------------------------------------------
% SISTEMA 1
% Ecuacion:  y[n] - 0.5*y[n-1] + 0.25*y[n-2] = x[n]
% Transf. Z: Y(z) - 0.5*z^-1*Y(z) + 0.25*z^-2*Y(z) = X(z)
% Despeje:   Y(z) * (1 - 0.5*z^-1 + 0.25*z^-2) = X(z)
% H(z) = Y(z)/X(z) = 1 / (1 - 0.5*z^-1 + 0.25*z^-2)
% -------------------------------------------------------------------------
b1 = [1];
a1 = [1, -0.5, 0.25];

% -------------------------------------------------------------------------
% SISTEMA 2
% Ecuacion:  y[n] = y[n-1] + y[n-2] + x[n-1]
% Ordenamos: y[n] - y[n-1] - y[n-2] = x[n-1]
% Transf. Z: Y(z) - z^-1*Y(z) - z^-2*Y(z) = z^-1*X(z)
% Despeje:   Y(z) * (1 - z^-1 - z^-2) = X(z) * z^-1
% H(z) = Y(z)/X(z) = (z^-1) / (1 - z^-1 - z^-2)
% -------------------------------------------------------------------------
b2 = [0, 1]; % El 0 va al principio porque NO hay termino x[n] (z^0)
a2 = [1, -1, -1];

% -------------------------------------------------------------------------
% SISTEMA 3
% Ecuacion:  y[n] = 7*x[n] + 2*y[n-1] - 6*y[n-2]
% Ordenamos: y[n] - 2*y[n-1] + 6*y[n-2] = 7*x[n]
% Transf. Z: Y(z) - 2*z^-1*Y(z) + 6*z^-2*Y(z) = 7*X(z)
% Despeje:   Y(z) * (1 - 2*z^-1 + 6*z^-2) = X(z) * 7
% H(z) = Y(z)/X(z) = 7 / (1 - 2*z^-1 + 6*z^-2)
% -------------------------------------------------------------------------
b3 = [7];
a3 = [1, -2, 6];

% -------------------------------------------------------------------------
% SISTEMA 4
% Ecuacion:  y[n] = sumatoria de k=0 a 7 de: (2^-k) * x[n-k]
% Transf. Z: Y(z) = sumatoria de k=0 a 7 de: (2^-k) * z^-k * X(z)
% Despeje:   Y(z) = X(z) * [1 + 0.5*z^-1 + 0.25*z^-2 + ... + (0.5^7)*z^-7]
% H(z) = Y(z)/X(z) = (0.5)^0 + (0.5)^1*z^-1 + ... + (0.5)^7*z^-7
% Este es un sistema MA (Promedio Movil), no tiene Y(z) pasadas,
% por lo tanto el denominador es simplemente 1.
% -------------------------------------------------------------------------
b4 = (0.5).^(0:7); % vector [1, 0.5, 0.25, 0.125]
a4 = [1];


% =======================================================
% GRAFICOS
figure('Name', 'Mapas de Polos y Ceros (Estabilidad)', 'Position', [100 100 800 800]);

% El circulo unitario (radio 1) es el limite.
% Si las "x" (polos) caen adentro, es ESTABLE. Si caen afuera, EXPLOTA.

subplot(2,2,1);
zplane(b1, a1);
title('Sistema 1 (Estable: Polos dentro del circulo)');

subplot(2,2,2);
zplane(b2, a2);
title('Sistema 2 (Inestable: Polo fuera del circulo)');

subplot(2,2,3);
zplane(b3, a3);
title('Sistema 3 (Inestable: Polos fuera del circulo)');

subplot(2,2,4);
zplane(b4, a4);
title('Sistema 4 (Filtro FIR - Estable)');
