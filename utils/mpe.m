% Compute mean absolute percentile error
function mpe = mpe(x, y)
    mpe = mean(abs((x - y)./(y+0.0000000001)));
end