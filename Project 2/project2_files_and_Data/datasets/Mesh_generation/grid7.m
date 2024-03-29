function [A,xy] = grid7(k)
% GRID7 : Generate 7-point finite difference mesh.
%
% [A,xy] = GRID7(k) returns a k^2-by-k^2 symmetric positive definite 
%        matrix A with the structure of the k-by-k 7-point grid,
%        and an array xy of coordinates for the grid points.

a = blockdiags ([-1 6 -1], -1:1, k, k);
b = blockdiags ([-1 -1], [0 1], k, k);
A = blockdiags ([b a b'], -1:1, k, k);
A = diag(diag(A)) - A;


xy = zeros(k^2,2);
x  = ones(k,1) * (1:k);
y  = x';
xy(:,1) = x(:);
xy(:,2) = y(:);


end