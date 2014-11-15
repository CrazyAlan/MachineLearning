function [m] = meanNormalize(x) % x is Double zscore
    m = mean(x(:));
    x = x - m;
    m = x/std(x(:));
end