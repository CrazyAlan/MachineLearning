function [m] = meanNormalize(x)
    m = mean(x(:));
    x = x - m;
    m = x/std(x(:));
end