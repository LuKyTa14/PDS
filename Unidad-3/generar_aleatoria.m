function [t, y] = generar_aleatoria(t_inicial, t_final, fm, A)
    % Se define el vector de tiempo discreto con paso 1/fm
    t = t_inicial : 1/fm : t_final;

    % Generamos el vector de ruido con el mismo tamaño que 't'
    y = A * randn(1, length(t));
end
