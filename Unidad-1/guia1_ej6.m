% Parametros Originales
fs_senal = 1;
fm_orig = 10;
T = 1/fm_orig;
t_orig = 0:T:1-T;
x_orig = sin(2 * pi * fs_senal * t_orig);

% Parametros de Sobremuestreo
L = 4;                                  % Factor de sobremuestreo (4 veces)
fm_nuevo = fm_orig * L;   % 40 Hz
Ti = 1/fm_nuevo;              % Nuevo periodo
t_nuevo = 0:Ti:1-Ti;           % Tiempo con 40 muestras

x_sobremuestreo = zeros(size(t_nuevo));

for m_idx = 1:length(t_nuevo)
    m = m_idx - 1;              % Para que en la multiplicacion se corresponda correctamente con el indice
    suma_acumulada = 0;


    for n_idx = 1:length(x_orig)
        n = n_idx - 1;
        % Calculamos el argumento de la Sinc segun la formula
        arg = (m * Ti - n * T) / T;
        aux_x = pi * arg;          % x = 2 * pi * fs * arg  -->  2 * pi * 0.5 * arg --> pi * arg

        % La formula de interpolacion no mira el reloj absoluto,mira la distancia entre dos puntos
        if (aux_x == 0)
            val_sinc = 1;
        else
            val_sinc = sin(aux_x) / aux_x;
        endif
        suma_acumulada = suma_acumulada + x_orig(n_idx) * val_sinc;
    endfor

    % Al terminar de sumar todos los n, guardamos el resultado en m
    x_sobremuestreo(m_idx) = suma_acumulada;
endfor

figure(1);
stem(t_orig, x_orig);

figure(2);
stem(t_nuevo, x_sobremuestreo);
