function [t, y] = generar_sinc(t_inicial, t_final, fm, fs)
    t = t_inicial : 1/fm : t_final;
    x = 2 * pi * fs * t;

    y = zeros(size(t));

    for i = 1:length(x)
      if (x(i) == 0)
          y(i) = 1;   % Forzamos el valor 1 donde x es exactamente cero
      else
          y(i) = sin(x(i)) / x(i);   % Calculamos los valores donde x no es cero
      endif
    endfor
end
