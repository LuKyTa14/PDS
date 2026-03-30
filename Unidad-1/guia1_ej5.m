fs = 4000;
t_inicial = 0;
t_final = 2;
phi = 0;
fm = 129;
[t, x] = generar_senoidal(t_inicial, t_final, fm, fs, phi);
stem(t, x);

% en 2 segundos hay 2 ciclos, significa que la frecuencia que estamos observando en la gráfica es de 1 Hz.
% Como 129 Hz < 8000 Hz, estamos "submuestreando" de manera extrema.
% porque no estamos repetando 2.fs < fm.
% al muestrear una señal de 4000 Hz a 129 Hz, esta adquiere el alias de una señal de 1 Hz.
