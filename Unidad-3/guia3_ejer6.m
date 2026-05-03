clc; clear all;
% cargar el archivo de audio
[senal, fm] = audioread('escala.wav');

% Si el audio llega a ser estéreo (2 canales), lo promediamos a mono
if size(senal, 2) > 1
    senal = mean(senal, 2);
end

% Parametros
f_LA = 440;                  % frecuencia buscada
duracion_nota = 0.5;    % segundos por nota
muestras_por_nota = floor(duracion_nota * fm);
num_notas = floor(length(senal) / muestras_por_nota);  % cant de notas

energia_LA = zeros(1, num_notas);

for i = 1:num_notas
    % indices
    inicio = (i - 1) * muestras_por_nota + 1;
    fin = i * muestras_por_nota;

    % extraemos el segmentos
    segmento = senal(inicio:fin);

    % pasamos a filas para que dot() no tire error y % limpiamos el nivel de continua
    segmento = segmento(:)';
    segmento = segmento - mean(segmento);

    L = length(segmento);
    t_seg = (0:L-1) / fm;

    % Generamos nuestra base ortogonal solo para 440 Hz
    ref_sin = sin(2 * pi * f_LA * t_seg);
    ref_cos = cos(2 * pi * f_LA * t_seg);

    % Reutilizamos el algoritmo del Ejercicio 5 (Invariante a la fase)
    energia_LA(i) = sqrt(dot(segmento, ref_sin)^2 + dot(segmento, ref_cos)^2);
end

% bloque ganador (El que tenga la energía máxima)
[max_energia, idx_LA] = max(energia_LA);

tiempo_inicio = (idx_LA - 1) * duracion_nota;   % se resta uno porque esta entre medio de dos notas (1*0.5 = 0.50 seg)
tiempo_fin = idx_LA * duracion_nota;                 % se multiplica por 0.5 asi da el segundo exacto  (2*0.5 = 1 seg)

% Resultados
fprintf('RESULTADO DE LA DETECCION: \n');
fprintf('La nota LA (440 Hz) es la nota numero: %d \n', idx_LA);
fprintf('Se encuentra sonando entre los %.2f y %.2f segundos \n', tiempo_inicio, tiempo_fin);

% Grafico
figure(1);
bar(1:num_notas, energia_LA);
title('Deteccion de la nota LA (440 Hz) ');
xlabel('Numero de Nota'); ylabel('Similitud (Energia a 440 Hz)');
grid on;
