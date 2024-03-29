function [A,xy] = grid5(k)
% GRID5 : Generate 5-point finite difference mesh.
%
% [A,xy] = GRID5(k) returns a k^2-by-k^2 symmetric positive definite 
%        matrix A with the structure of the k-by-k 5-point grid,
%        and an array xy of coordinates for the grid points.

a = blockdiags ([-1 4 -1], -1:1, k, k);
I = speye (k, k);
A = blockdiags ([-I a -I], -1:1, k, k);
A  = diag(diag(A)) - A;


xy = zeros(k^2,2);
x  = ones(k,1) * (1:k);
y  = x';
xy(:,1) = x(:);
xy(:,2) = y(:);


end