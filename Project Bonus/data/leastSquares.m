function [x_star, r, euclidian_norm, SE, RMSE] = leastSquares(A, b)
    AtA = A'*A;
    Atb = A'*b;    
    




    x = inv(AtA)*Atb;
    x_star = x;
    r = b - A*x_star;
    euclidian_norm = norm(r);
    SE = euclidian_norm^2;
    RMSE = sqrt(SE/length(b));
end