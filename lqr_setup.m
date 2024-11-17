clc
clear

% x1k = sym("x1k");
% x2k = sym("x2k");
% x3k = sym("x3k");
% uk = sym("uk");
% xk = [x1k; x2k+x3k; x3k+uk];

A = [1, 0, 0;
     0, 1, 1;
     0, 0, 1];
B = [0;
     0;
     1];
% A_p stands for A_partial
% This is needed because the LQR controller is only dependent on x2, x3
A_p = [1,1;
       0,1];
B_p = [0;
       1];

% We don't use C or D for LQR control
% C = [cos(x2k), -x1k*sin(x2k), 0;
     % cos(x2k-x3k+uk), -x1k*sin(x2k-x3k+uk), x1k*sin(x2k-x3k+uk)];
% D = [0, 0;
     % 0, 0];

Q_LQR = [30, 0;
          0,  1];
R_LQR = 1000;

[K_LQR, S, P] = dlqr(A_p, B_p, Q_LQR, R_LQR);
K_LQR