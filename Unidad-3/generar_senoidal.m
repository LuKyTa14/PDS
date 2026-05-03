function [t, y] = generar_senoidal(t_inicial, t_final, fm, fs, phi)
    % Se define el vector de tiempo discreto con paso 1/fm
    t = t_inicial : 1/fm : t_final;

    % Se evalúa la ecuación senoidal vectorizada
    y = sin(2 * pi * fs * t + phi);
end
