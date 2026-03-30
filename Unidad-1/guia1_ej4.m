% Los casos en los que se corresponde son aquellos en los cuales podemos ver que las cantidades de muestras que
% toma son las sufiecientes para poder visualizar 5 Hz de señal, es decir 5 valles.
fs = 5;
t_inicial = 0;
t_final = 1;
fase = 0;

[t1, x1] = generar_senoidal(t_inicial, t_final, 0.5, fs, fase);
[t2, x2] = generar_senoidal(t_inicial, t_final, 1, fs, fase);
[t3, x3] = generar_senoidal(t_inicial, t_final, 4, fs, fase);
[t4, x4] = generar_senoidal(t_inicial, t_final, 10, fs, fase);
[t5, x5] = generar_senoidal(t_inicial, t_final, 25, fs, fase);
[t6, x6] = generar_senoidal(t_inicial, t_final, 100, fs, fase);

figure(1);
subplot(3,1,1);
stem(t1,x1); title('Señal 1');

subplot(3,1,2);
stem(t2,x2); title('Señal 2');

subplot(3,1,3);
stem(t3,x3); title('Señal 3');

figure(2);
subplot(3,1,1);
stem(t4,x4); title('Señal 4');

subplot(3,1,2);
stem(t5,x5); title('Señal 5');

subplot(3,1,3);
stem(t6,x6); title('Señal 6');

% El caso 1 no corresponde porque ni siquiera llega a tomar una muestra con esa frecuencia.
% El caso 2 no toma las suficientes muestras como para llegar a corresponder a la senoidal 5 Hz.
% El caso 3 misma situación.
% El caso 4 toma varios puntos pero estan todos tan cerca del 0 que no llega a corresponderse.
% Los casos 5 y 6 si llegan a poder corresponderse con una sinusoidal de 5 Hz.

% En los casos que falla se produce el fenomeno de aliasing.
% En terminos simples: es un error de identidad. La computadora "cree" que esta viendo una señal
% lenta porque no tomo suficientes muestras para capturar la rapidez de la señal original.
