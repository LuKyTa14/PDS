function [y] = escalon(t)

    if (t >= 0 && t < 1)
      y = 1;
    else
      y = 0;
    endif


