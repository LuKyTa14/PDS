clc; clear all;
% ------------ Parte 1 ------------
A = 5;
fs = 10;
fase = pi/4;
fm = 400;
Tm = 1/fm;

% vector tiempo
t = 0 : Tm : 0.5;
% generacion de la señal discreta
x_original = A * sin(2 * pi * fs * t + fase);

% Clasificacion Morfologica y Fenomenologica
% Es una señal discreta en el tiempo (definida en instantes
% especificos n*Tm) y continua en amplitud (antes de cuantizar).
% Es deterministica, ya que su evolución puede ser
% predicha exactamente mediante una expresión matematica (A*sin(2*pi*fs*t+fase)).
% Es periodica, pues cumple con x[n] = x[n + N], donde el
% periodo fundamental depende de la relacion entre fs y fm.

x_rectificada = rectificacion_onda_completa(x_original);
N = 16;
H = 5 / (N-1);     %  Depende del rango de la señal | Amplitud = 5
x_cuantizada = cuantizacion(x_rectificada, N, H);

% Graficos
figure('Name', 'Integrador Parte I:');
subplot(3,1,1);
plot(t, x_original, 'b'); title('Señal Original');
grid on;
subplot(3,1,2);
plot(t, x_rectificada, 'r'); title('Señal Rectificada');
grid on;
subplot(3,1,3);
plot(t, x_cuantizada, 'g'); title('Señal Cuantizada');
grid on;

% ------------ Parte 2 ------------
var1 = 0.1;
ruido_bajo = sqrt(var1) * randi([-1, 1], size(t));
x_ruido_bajo = x_original + ruido_bajo;
var2 = 0.5;
ruido_alto = sqrt(var2) * randi([-1, 1], size(t));
x_ruido_alto = x_original + ruido_alto;

% Graficos
figure('Name', 'Integrador Parte II:');
subplot(3,1,1);
plot(t, x_original, 'b'); title('Señal Original');
grid on;
subplot(3,1,2);
plot(t, x_ruido_bajo, 'r'); title('Señal con ruido bajo');
grid on;
subplot(3,1,3);
plot(t, x_ruido_alto, 'r'); title('Señal con ruido alto');
grid on;

% Mostrar en pantalla estos resultados:
P_senal = mean(x_original.^2);
P_ruido_bajo = mean(ruido_bajo.^2);
P_ruido_alto = mean(ruido_alto.^2);

fprintf(' Valores Potencia Iniciales: \n');
fprintf('Potencia Señal: %.4f \n', P_senal);
fprintf('Potencia del Ruido: %.4f \n', P_ruido_bajo);
fprintf('Potencia del Ruido: %.4f \n \n', P_ruido_alto);

% Objetivo SNR = 6 [dB]
SNR_obj = 6;
#k = sqrt(P_senal / (P_ruido_bajo * (10).^0.6));
k = sqrt(P_senal / P_ruido_bajo) / 10^0.3;

% multiplicar k por el vector de ruido bajo
ruido_nuevo_6dB = k * ruido_bajo;
P_ruido_nuevo_6dB = mean(ruido_nuevo_6dB.^2);
% Comprobacion
SNR_final = 10 * log10(P_senal/P_ruido_nuevo_6dB);

fprintf('Constante calculada para 6 [dB]: %.4f \n', k);
fprintf('SNR de comprobación: %.4f [dB] \n \n', SNR_final);

% ¿Cómo afecta cada ruido a la señal original?
% El ruido es una señal aleatoria que se superpone a la información útil. El ruido de baja varianza (var=0.1)
% produce una fluctuación leve sobre el seno. La morfologia de la señal sigue siendo claramente reconocible y
%  el error cuadratico medio es pequeño. En el ruido de alta varianza (var=0.5) aumenta la incertidumbre
% en cada muestra. La relacion señal-ruido disminuye, lo que "ensucia" visualmente la señal y
% dificulta la recuperacion de la fase o la amplitud exacta en un proceso de filtrado.
% En ambos casos, el ruido transforma una señal determinística en una señal estocastica (proceso aleatorio).

% ------------ Parte 3 ------------
% Si se reduce el numero de bits en la cuantizacion, la fidelidad de la señal baja drasticamente poque
% nos encontramos con menos 'escalones' para representar la amplitud de la señal, el error entre la señal
% original y la digitalizada se hace más grande. Este resultado es una representacion de una señal con saltos
% grandes y con periodos planos ante leves cambios pero no los suficientes para saltar al siguiente escalon
% para representar las distintas amplitudes de los valores.

% La fidelidad se pierde porque al reducir el numero de escalones aparece un "ruido" que antes no estaba en la senal.
% con menos bits = escalones mas grandes, la distancia entre un valor permitido y otro aumenta
% se obtiene un mayor error, la diferencia e[n] = x[n] - x_q[n] se vuelve más notable
% Por cada bit que se quita, la SNR cae aproximadamente 6 dB.

% Reduccion de fm a 15Hz:
% Perdes la forma original de la señal. Creas una "senal fantasma" de menor frecuencia.
% Es imposible reconstruir la informacion original porque "te perdiste" lo que paso entre una
%  muestra y otra por asi decirlo. Si fm baja a 15Hz, se produce aliasing. Al intentar visualizarla,
% ves una senal de una frecuencia aparente mucho menor y no la original de 10Hz.

% Obtencion de SNR de 0dB
% Una SNR de 0dB significa que la potencia de la senal es exactamente igual
% a la potencia del ruido (Ps/Pn = 1).
% Logaritmicamente: 10 * log10(1) = 0dB.

% Despeje:
% Prmult = 1/N * sum((ruido * k)^2)
% Prmult = k^2 * (1/N * sum(ruido^2))
% Prmult = k^2 * Pr
% Entonces
% 10 * log(Ps/Prmult) = 0
% 10 * log(Ps/(Pr * k^2)) = 0
% log(Ps/(Pr * k^2)) = 0
% Para que eso pase -> Ps = Pr * k^2
% k^2 = Ps/Pr
% k = sqrt(Ps/Pr)

% Probamos eso ahora
k0 = sqrt(P_senal/P_ruido_bajo);
ruido_0 = k0 * ruido_bajo;
P_ruido_0 = mean(ruido_0.^2);
SNR_comprobacion_0 = 10 * log10(P_senal / P_ruido_0);

fprintf('Resultados Parte 3: \n');
fprintf('Constante k para 0 dB: %.4f \n', k0);
fprintf('SNR de comprobacion: %.4f [dB] \n \n', SNR_comprobacion_0);

% Grafico comparativo
fm_baja = 15;
t_baja = 0 : 1/fm_baja : 0.5;
x_aliasing = A * sin(2 * pi * fs * t_baja + fase);

figure('Name', 'Integrador Parte III: ');
plot(t, x_original, 'b--'); hold on;
stem(t_baja, x_aliasing, 'r', 'LineWidth', 1.5);
title('Efecto de submuestreo a 15Hz (Aliasing)');
legend('Senal Original (400Hz)', 'Muestras a 15Hz');
grid on;
