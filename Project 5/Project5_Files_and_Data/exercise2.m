close all;
clear;
clc;

type = 'max';



A = [1,0,0,0, 1,0,0,0 ,1,0,0,0 ,1,0,0,0;
     0,1,0,0 ,0,1,0,0 ,0,1,0,0 ,0,1,0,0;
     0,0,1,0 ,0,0,1,0 ,0,0,1,0 ,0,0,1,0;
     0,0,0,1 ,0,0,0,1 ,0,0,0,1 ,0,0,0,1;
     320,0,0,0 ,510,0,0,0 ,630,0,0,0 ,125,0,0,0;
     0,320,0,0 ,0,510,0,0 ,0,630,0,0 ,0,125,0,0;
     0,0,320,0 ,0,0,510,0 ,0,0,630,0 ,0,0,125,0;
     0,0,0,320 ,0,0,0,510 ,0,0,0,630 ,0,0,0,125;
     1,1,1,1 ,0,0,0,0 ,0,0,0,0 ,0,0,0,0;
     0,0,0,0 ,1,1,1,1 ,0,0,0,0 ,0,0,0,0;
     0,0,0,0 ,0,0,0,0 ,1,1,1,1 ,0,0,0,0;
     0,0,0,0 ,0,0,0,0 ,0,0,0,0 ,1,1,1,1;];





h = [18; 32; 25; 17; 11930; 22552; 11209; 5870; 16; 32; 40; 28];

c = [135, 135*1.1, 135*1.2, 135*1.3, 200, 200*1.1, 200*1.2, 200*1.3, 410, 410*1.1, 410*1.2, 410*1.3, 520, 520*1.1, 520*1.2, 520*1.3];

sign = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];


[z, x_B, index_B] = simplex(type, A, h, c, sign);
fprintf('z = %d\n', z);
fprintf('x_B = \n');
disp(x_B);
fprintf('index_B = \n');
disp(index_B);

bar(x_B);
title('Solution (x_B)');
xlabel('Index');
ylabel('Value');
saveas(gcf, 'solution.png');