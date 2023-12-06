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
