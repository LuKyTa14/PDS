function [t, y] = generar_rampa(t_inicial, t_final, fm, m)
    % m: pendiente
    % Se define el vector de tiempo discreto con paso 1/fm
    t = t_inicial : 1/fm : t_final;
    y = m * (t - t_inicial);
end
