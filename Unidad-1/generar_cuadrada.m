function [t, y] = generar_cuadrada(t_inicial, t_final, fm, fs, phi)
    t = t_inicial : 1/fm : t_final;

    % argumento del módulo
    fase_mod = mod(2 * pi * fs * t + phi, 2 * pi);

    % Inicializamos el vector asumiendo que todos valen 1
    y = ones(size(t));

    % Cambiamos a -1 aquellos que cumplen la condición >= pi
    y(fase_mod >= pi) = -1;
end
