% Compute mean absolute error
function mae = mae(x, y)
    mae = (mean(abs(x - y)));
end