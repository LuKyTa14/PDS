function [t, y] = generar_cuadrada(t_inicial, t_final, fm, fs, phi)
    % Se define el vector de tiempo discreto con paso 1/fm
    t = t_inicial : 1/fm : t_final;

    % Se evalúa la cuadrada aprovechando el signo de la senoidal vectorizada
    y = sign(sin(2 * pi * fs * t + phi));
end
