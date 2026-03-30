function x = rectificacion_media_onda(x_real)
  x = zeros(size(x_real));

  for i = 1:length(x_real)
    if(x_real(i) >= 0)
      x(i) = x_real(i); % Si es positivo, guardo el valor
      % Si no es positivo, como es de media onda y ya lo defini como
      % un vector de 0, lo dejo como 0 y listo
    endif
  endfor

endfunction
