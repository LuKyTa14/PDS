function y = convolucion_circular(x,h)
  % Verificacion de longitudes segun la teoria de sistemas periodicos
  N = length(x);
  M = length(h);

  % En convolucion circular, ambas señales deben tener el mismo largo N
  if N != M
    error('Para convolucion circular, x y h deben tener la misma longitud.');
  end

  y = zeros(1, N);

  % Implementacion basada en la sumatoria de convolucion periodica
  for k = 1:N
    for l = 1:N
        % Calculo del indice con operacion modulo para periodicidad
        % El + 1 ajusta el rango [0, N - 1] de mod al rango [1, N] de Octave
        indice_x = mod(k - l, N) + 1;

        y(k) = y(k) + h(l) * x(indice_x);
    endfor
  endfor
endfunction
