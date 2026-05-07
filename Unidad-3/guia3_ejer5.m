clc; clear all;
fm = 11025;

% Frecuencias DTMF estándar
fs_filas = [697, 770, 852, 941];
fs_cols = [1209, 1336, 1477];
teclas = [ 1,  2,  3;  4,  5,  6;  7,  8,  9;  11,  0, 12];    % 11 representa '*'   ;   12 representa '#'

% Carga de la señal
senal = load('te.txt');
figure(1);
plot(senal); title('Señal de audio DTMF'); hold on;

% Intervalos de tiempo
intervalos = [
    17800, 23800;
    29200, 35200;
    39200, 45200;
    47800, 53800;
    58200, 64200;
    68800, 74800;
    80300, 86300
];
#Grafico Intervalos
for i = 1:size(intervalos, 1)
    inicio = intervalos(i, 1);
    fin = intervalos(i, 2);
    ancho = fin - inicio;
    rectangle('Position', [inicio, -1.5, ancho, 3], 'EdgeColor', 'r');
end
hold off;

% DECODIFICACION POR CUADRATURA
% La formula: sqrt(dot(seg, sin)^2 + dot(seg, cos)^2)
% sirve para medir la energia de una frecuencia especifica siendo
% invariante a la fase inicial.

% El problema: Si usamos solo un seno de referencia y la senal original
% esta desfasada 90 grados, el dot() daria cero, fallando la deteccion.

% La solucion: Al proyectar el segmento sobre una base ortogonal de
% Seno (parte imaginaria) y Coseno (parte real), obtenemos las componentes
% rectangulares en esa frecuencia. Aplicando Pitagoras sacamos la magnitud
% total, la cual sera maxima cuando la frecuencia coincida, sin importar
% donde arranco la onda.

numero_final = zeros(1, 7);

for i = 1:7
    inicio = intervalos(i, 1);
    fin = intervalos(i, 2);

    % Extraer segmento
    segmento = senal(inicio:fin);

    % Limpieza: quitar el nivel de continua y normalizar
    % (el nivel de continua de te.txt falsea el dot() por el ruido)
    segmento = segmento - mean(segmento);
    segmento = segmento / max(abs(segmento));

    L = length(segmento);
    t_seg = (0:L-1)/fm;

    % Búsqueda de coincidencia en las FILAS
    sim_f = zeros(1, 4);
    for f = 1:4
        ref_sin = sin(2*pi*fs_filas(f)*t_seg);
        ref_cos = cos(2*pi*fs_filas(f)*t_seg);
        sim_f(f) = sqrt(dot(segmento, ref_sin)^2 + dot(segmento, ref_cos)^2);
    end

    % Búsqueda de coincidencia en las COLUMNAS
    sim_c = zeros(1, 3);
    for c = 1:3
        ref_sin = sin(2*pi*fs_cols(c)*t_seg);
        ref_cos = cos(2*pi*fs_cols(c)*t_seg);
        sim_c(c) = sqrt(dot(segmento, ref_sin)^2 + dot(segmento, ref_cos)^2);
    end

    % Encontramos los picos de similitud
    [~, idx_fila] = max(sim_f);
    [~, idx_col]  = max(sim_c);

    % Mapeamos los índices a la matriz del teclado
    numero_final(i) = teclas(idx_fila, idx_col);
end

% Imprimimos el resultado
str_numero =  num2str(numero_final);
fprintf('El numero discado es: %s \n', str_numero);
