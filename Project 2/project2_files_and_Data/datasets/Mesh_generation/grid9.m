function [A,xy] = grid9(k)
% GRID9 : Generate 9-point finite difference mesh.
%
% [A,xy] = GRID9(k) returns a k^2-by-k^2 symmetric positive definite 
%        matrix A with the structure of the k-by-k 9-point grid,
%        and an array xy of coordinates for the grid points.


a = blockdiags ([-4 20 -4], -1:1, k, k);
b = blockdiags ([-1 -4 -1], -1:1, k, k);
A = blockdiags ([b a b], -1:1, k, k);
A = diag(diag(A)) - A;

xy = zeros(k^2,2);
x  = ones(k,1) * (1:k);
y  = x';


xy(:,1) = x(:);
xy(:,2) = y(:);


end
