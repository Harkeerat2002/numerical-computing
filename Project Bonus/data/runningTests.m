A1 = [2 -1; 1 2; 2 -1];
b1 = [3 7 4]';

A2 = [1 0; 1 0; 1 0];
b2 = [5 2 4]';

A3 = [1 1 0; 0 1 1; 1 2 1; 1 0 1];
b3 = [2 2 3 4]';

% Use leastSquares to find the solutions
[x_star1, r1, euclidian_norm1, SE1, RMSE1] = leastSquares(A1, b1);
[x_star2, r2, euclidian_norm2, SE2, RMSE2] = leastSquares(A2, b2);
[x_star3, r3, euclidian_norm3, SE3, RMSE3] = leastSquares(A3, b3);

% Print the results
disp('-----------------------------------------')
disp('Results from Slides Example');
disp('-----------------------------------------')
disp('x_star1 = ');
disp(x_star1);
disp('r1 = ');
disp(r1);
disp('euclidian_norm1 = ');
disp(euclidian_norm1);
disp('SE1 = ');
disp(SE1);
disp('RMSE1 = ');
disp(RMSE1);


disp('-----------------------------------------')
disp('Results from Problem 1');
disp('-----------------------------------------')
disp('x_star2 = ');
disp(x_star2);
disp('r2 = ');
disp(r2);
disp('euclidian_norm2 = ');
disp(euclidian_norm2);
disp('SE2 = ');
disp(SE2);

disp('-----------------------------------------')
disp('Results from Problem 2');
disp('-----------------------------------------')
disp('x_star3 = ');
disp(x_star3);
disp('r3 = ');
disp(r3);
disp('euclidian_norm3 = ');
disp(euclidian_norm3);
disp('SE3 = ');
disp(SE3);
disp('RMSE3 = ');
disp(RMSE3);




