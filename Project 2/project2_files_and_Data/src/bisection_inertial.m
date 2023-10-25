function [part1,part2] = bisection_inertial(A,xy,picture)
% bisection_inertial: Inertial partition of a graph.
%
% [part1,part2] = bisection_inertial(A,xy,picture) returns a list of the vertices on one side of a partition
%     obtained by bisection with a line or plane normal to a moment of inertia
%     of the vertices, considered as points in Euclidean space.
%     Input A is the adjacency matrix of the mesh (used only for the picture!);
%     each row of xy is the coordinates of a point in d-space.
%
% bisection_inertial(A,xy,1) also draws a picture.



% disp(' ');
% disp(' Numerical Computing @ USI Lugano:   ');
% disp(' Implement inertial bisection');
% disp(' ');


% Steps
% 1. Calculate the center of mass.
% 2. Construct the matrix M.
%  (Consult the pdf of the assignment for the creation of M) 
% 3. Calculate the smallest eigenvector of M.  
% 4. Find the line L on which the center of mass lies.
% 5. Partition the points around the line L.
%   (you may use the function partition.m)

% 1. Calculate the center of mass.
x = xy(:,1);
y = xy(:,2);

x = sum(x)/length(x);
y = sum(y)/length(y);

center_of_mass = [x,y];

% 2. Construct the matrix M.
%  (Consult the pdf of the assignment for the creation of M)

Sxx = sum((xy(:,1) - center_of_mass(1)).^2);
Syy = sum((xy(:,2) - center_of_mass(2)).^2);
Sxy = sum((xy(:,1) - center_of_mass(1)).*(xy(:,2) - center_of_mass(2)));
M = [Sxx, Sxy; Sxy, Syy];

% 3. Calculate the smallest eigenvector of M.
[V,D] = eigs(M,2,'sm');
v = V(:,1);


% 4. Find the line L on which the center of mass lies.
orthogonal_vector = [v(2), -v(1)];

% 5. Partition the points around the line L.
%   (you may use the function partition.m)
[part1,part2] = partition(xy,orthogonal_vector);


% <<<< Dummy implementation to generate a partitioning
% n   = size(A,1);
% map = zeros(n,1);
% map(1:round((n/2)))     = 0; 
% map((round((n/2))+1):n) = 1;
% 
% 
% [part1,part2] = other(map);

% if picture == 1
%     gplotpart(A,xy,part1);
%     title('Inertial bisection (dummy) using the Fiedler Eigenvector');
% end

% Dummy implementation to generate a partitioning >>>>

end
