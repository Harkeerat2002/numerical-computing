close all;
clear; clc;

%% Load Default Img Data
load('blur_data/B.mat');
B=double(B);
n = size(B,1);
sizeA = n * n;
disp(['Size of A: ', num2str(sizeA)]);


% Show Image
%figure
%im_l=min(min(B));
%im_u=max(max(B));
%% imshow(B,[im_l,im_u])
%title('Blured Image')

% Vectorize the image (row by row)
b=B';
b=b(:);



%% Validate Test values
load('test_data/A_test.mat');
load('test_data/x_test_exact.mat');
load('test_data/b_test.mat');

%res=||x^*-A^{-1}b||
res=x_test_exact-inv(A_test)*b_test
norm(res)
%(Now do it with your CG and Matlab's PCG routine!!!)

%% Excercise 3.2
x = ones(size(A_test, 1), 1);
maxit = 200;
tol = 1e-4;

[x, residuals] = myCG(A_test, b_test, x, maxit, tol);

figure;
semilogy(residuals)
ylim([-Inf,1e5]);
xlabel('Iterations');
ylabel('Residual value');
legend('Residuals');
title('Residuals vs Iterations for CG');
saveas(gcf, '../Template/graphs/residuals.png');

%% Excercise 3.3
eigenvalues = eig(A_test);

figure;
semilogy(eigenvalues);
ylim([-Inf,1e5]);
xlabel('Eigenvalue index');
ylabel('Eigenvalue value');
legend('Eigenvalues');
title('Eigenvalues vs Index');
saveas(gcf, '../Template/graphs/eigenvalues.png');

condition_number = cond(A_test);
disp(['Condition number: ', num2str(condition_number)]);

%% Excercise 4.1
loaded_A = load('blur_data/A.mat');
loaded_B = load('blur_data/B.mat');

A = loaded_A.A;
B = loaded_B.B;

img = B;
n = size(img, 1);
b = B(:);
guess = ones(size(A, 1), 1);
maxiter = 200;
tol = 1e-6;

% Display image
imagesc(reshape(img, [n, n]));
colormap('gray');
axis off;
saveas(gcf, '../Template/graphs/blurred.png');

augA = A' * A;
augA_shifted = augA + 0.01 * speye(size(augA));

L = ichol(augA_shifted, struct('type', 'nofill'));
M = L * L';
M1 = L';
M2 = L;
augB = A' * b;

[x_pcg, flag, relres, iter, resvec_pcg] = pcg(augA, augB, tol, maxiter, M1, M2);


% Draw deblurred image obtained with 'pcg'
imagesc(reshape(x_pcg, [n, n]));
colormap('gray');
axis off;
saveas(gcf, '../Template/graphs/deblurred_pcg.png');

semilogy(resvec_pcg);
xlabel('Iterations');
ylabel('Residual value');
legend('Residuals');
title('Residuals vs Iterations for PCG');
saveas(gcf, '../Template/graphs/residuals_pcg.png');

disp(['Convergence flag: ', num2str(flag)]);

[x, residuals] = myCG(A, b, guess, maxiter, tol);

imagesc(reshape(x, [n, n]));
colormap('gray');
axis off;
saveas(gcf, '../Template/graphs/deblurred_mycg.png');

semilogy(residuals);
xlabel('Iterations');
ylabel('Residual value');
legend('Residuals');
title('Residuals vs Iterations for myCG');
saveas(gcf, '../Template/graphs/residuals_mycg.png');

