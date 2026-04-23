function y = convolucion_lineal(x,h)
  N = length(x);
  M = length(h);
  L = N + M - 1; % La convolucion siempre tiene la suma de las dimensiones
  % de x y h - 1

  % Sumatoria manual
  y = zeros(1, L);

  % Implementacion mediante bucles anidados para evitar "function"
  for n = 1:L
      for k = 1:N
          % Sumamos 1 al indice de h debido a que Octave empieza en 1, no en 0
          if (n-k+1 > 0 && n-k+1 <= M)
              y(n) = y(n) + x(k) * h(n-k+1);
          endif
      endfor
  endfor
endfunction
