function x = cuantizacion(x_real, N, H)
  % Encontrar el minimo para desplazar la señal a positivo
  val_min = min(x_real);
  x_desplazada = x_real - val_min; % Si oscila de -1 a 1, al restar -1, es como sumar 1
  % Podriamos haber usado el maximo y sumarlo y luego restarlo, era lo mismo

  limite_superior = (N - 1) * H;

  x = zeros(size(x_desplazada));

  for i = 1:length(x_desplazada)
    if (x_desplazada(i) < 0)
      x(i) = 0;
    elseif (x_desplazada(i) >= limite_superior)
      x(i) = limite_superior;
    else
      x(i) = H * round(x_desplazada(i)/H);
    endif
  endfor

  % Para volver al rango original, sumamos el minimo que restamos al principio
  x = x + val_min;

endfunction
