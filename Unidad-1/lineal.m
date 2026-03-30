function [y] = lineal(t)

    tAbs = abs(t);
    if tAbs < 1
      y = 1 - tAbs;
    else
      y = 0;
    endif

