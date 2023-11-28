% Define the matrices A1, A2 and vectors b1, b2 for the two systems
A1 = [2 -1; 1 2; 2 -1];
b1 = [3 7 4]';


% Use leastSquares to find the solutions
[x_star1, norm_r1, SE1, RMSE1] = leastSquares(A1, b1);



