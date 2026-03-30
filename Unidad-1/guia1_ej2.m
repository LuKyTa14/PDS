#  Invertir: invertir una senial significa cambiar su polaridad (multiplicarla por -1). Es el equivalente a un desfase de 180 grados.
# Rectificacion: consiste en hacer que toda la senial sea positiva. Si la amplitud es negativa, se invierte su signo;

% Generamos una senial de seno con la funcion del ej anterior
[t, x] = generar_senoidal(0, 1, 100, 5, 0);
subplot(5, 1, 1);
stem(t,x,'filled'); title('Funcion Orginial');

% Inversion: Si el vector es [0, 2, 3, 1], el inverso es [1, 3, 2, 0]
x_invertida = -x;
subplot(5, 1, 2);
stem(t, x_invertida, 'r', 'filled'); title('Inversion');

% Rectificacion: La de media onda, pasa los valores negativos a 0.
% La rectificacion de onda completa, vuelve los valores negativos en valores positivos
x_rectificada_med = rectificacion_media_onda(x);
x_rectificada_comp = rectificacion_onda_completa(x);
subplot(5, 1, 3);
stem(t,x_rectificada_med,'k', 'filled'); title('rectificacion media onda');
subplot(5, 1, 4);
stem(t,x_rectificada_comp,'g','filled'); title('rectificacion onda completa');

% Cuantizacion: Es convertir la senial analogica en digital
x_cuantizada = cuantizacion(x, 8, 2/7);
subplot(5, 1, 5);
stem(t,x_cuantizada,'y','filled'); title('cuantizacion');
