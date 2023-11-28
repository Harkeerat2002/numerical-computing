function [x_star, norm_r, SE, RMSE] = leastSquares(A, b)
    x_star = (A' * A) \ (A' * b);
    r = b - A * x_star;
    norm_r = norm(r);
    SE = r' * r;
    RMSE = sqrt(SE / length(b));
end