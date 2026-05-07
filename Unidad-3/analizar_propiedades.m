function analizar_propiedades(nombre_senal, t, y)
    % Cálculos
    y_medio = mean(y);
    y_maximo = max(y);
    y_minimo = min(y);
    y_amplitud = norm(y, inf);
    y_energia = norm(y, 2);
    y_accion = trapz(t, abs(y));
    y_potencia = norm(y, 1);
    y_rms = sqrt(y_potencia);

    % Salida en consola
    fprintf('Salidas señal %s: \n', nombre_senal);
    fprintf('1. Valor Medio: %4f \n', y_medio);
    fprintf('2. Maximo: %4f \n', y_maximo);
    fprintf('3. Minimo: %4f \n', y_minimo);
    fprintf('4. Amplitud: %4f \n', y_amplitud);
    fprintf('5. Energia: %4f \n', y_energia);
    fprintf('6. Accion: %4f \n', y_accion);
    fprintf('7. Potencia Media: %4f \n', y_potencia);
    fprintf('8. Valor RMS: %4f \n', y_rms);
    fprintf('\n \n');
end
