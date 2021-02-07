% Compute root mean squared error
function rmse = rmse(x, y)
    rmse = sqrt(mean((x - y).^2));
end