clc; clear all;
% ------- Parte 1 -------
fm = 100;
t = -1:1/fm:1;

% El ejemplo usa la funcion signo:
y = sign(t); % En t > 0 = 1 y en t < 0 = -1

% Funciones de Legendre (Bases ortonormales)
phi0 = sqrt(1/2) * ones(size(t));
phi1 = sqrt(3/2) * t;
phi2 = sqrt(5/2) * (3/2 * t.^2 - 1/2);
phi3 = sqrt(7/2) * (5/2 * t.^3 - 3/2 * t);

% Coeficientes del ejemplo
a0 = 0;    a1 = sqrt(3/2);   a2 = 0;    a3 = -sqrt(7/32);

% Aproximacion: y_aprox = sum(ak * phik)
y_aprox = a0*phi0 + a1*phi1 + a2*phi2 + a3*phi3;

% Error cuadratico total (ECT)
% ECT = suma (0 a n) de (y - y_aprox)^2 / n
error_func = (y - y_aprox).^2;
ect_ejemplo = sum(error_func) ./length(t);
fprintf('\n--- PARTE 1 ---\n');
fprintf('Coeficiente a0: %f\n', a0);
fprintf('Coeficiente a1: %f\n', a1);
fprintf('Coeficiente a2: %f\n', a2);
fprintf('Coeficiente a3: %f\n', a3);
fprintf('Error Cuadratico Total (ECT) original: %4f\n', ect_ejemplo);

% ------- Parte 2 -------
% Variamos a1 y a3 (que son los no nulos)
rango = 0.5;
va1 = linspace(a1 - rango, a1 + rango, 30);
va3 = linspace(a3 - rango, a3 + rango, 30);
[A1, A3] = meshgrid(va1, va3); % Genera una grilla de coordenadas a partir de vectores
% Combina los valores de va1 los valores de va3 para formar puntos en un plano (a1, a3)
ect_malla = zeros(size(A1));

for i = 1:size(A1, 1)
    for j = 1:size(A1, 2)
        % Calculamos aproximacion con coeficientes variados
        y_var = a0*phi0 + A1(i,j)*phi1 + a2*phi2 + A3(i,j)*phi3;
        error_func = (y - y_var).^2;
        ect_malla(i,j) = sum(error_func)./length(t);
    end
end

figure(1);
surf(A1, A3, ect_malla);
xlabel('Variacion Coeficiente a1');
ylabel('Variacion Coeficiente a3');
zlabel('Error Cuadratico Total');
title('Sensibilidad del Error respecto a los coeficientes alpha');
grid on;

% El grafico muestra la superficie de error cuadratico.
% El eje Z representa que tan mala es la aproximacion.
% Se observa un minimo global que en teoria coincide con los coeficientes teoricos.
% Esto confirma que la proyeccion mediante producto interno minimiza el error.
% Cualquier variacion en los coeficientes aumenta el error (la superficie sube).

% ------- Parte 3 -------
% Nuevas funciones de base
phi4 = sqrt(9/2) * 1/384 * 8.*(210.*t.^4 - 180.*t.^2 + 18);
phi5 = sqrt(11/2) * 1/3840 * 10.*(3024.*t.^5 - 3360.*t.^3 + 720.*t);

% Coeficientes nuevos
a4_calc = trapz(t, phi4.*y);  % casi 0 -->  1.1102e-16
a4 = 0;   % Lo forzamos a 0
a5 = trapz(t, phi5.*y);

y_aprox_nuevo = a0*phi0 + a1*phi1 + a2*phi2 + a3*phi3 + a4*phi4 + a5*phi5;

% Error cuadratico total (ECT)
N=length(t);
ect_nuevo = (1/N)*sum((y - y_aprox_nuevo).^2);

% --- SALIDA EN CONSOLA PARA LA PARTE 3 ---
fprintf('\n--- PARTE 3 ---\n');
fprintf('Coeficiente a4 calculado (0 teorico): %e \n', a4_calc);
fprintf('Coeficiente a5 calculado: %f \n', a5);
fprintf('Error Cuadratico Total (ECT) original: %4f\n', ect_ejemplo);
fprintf('Nuevo Error Cuadratico Total (ECT): %4f\n', ect_nuevo);
fprintf('Reduccion absoluta del error: %4f \n\n', ect_ejemplo - ect_nuevo);
