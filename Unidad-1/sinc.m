function [y] = sinc(t,fs)
    if t == 0
      y =  1;
    else
      x = 2*pi*fs*t;
      y = sin(x)/x;
    endif

