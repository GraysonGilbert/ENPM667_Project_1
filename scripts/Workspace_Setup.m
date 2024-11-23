% Script to set up workspace for Simulink Model
load('x1_timeseries.mat', 'x1_ts');
load('x2_timeseries.mat', 'x2_ts');
load('x3_timeseries.mat', 'x3_ts');
load('x1_stable_timeseries.mat', 'x1_stable_ts');
%load('psi_timeseries.mat', 'psi_ts');

psi_data = readtable('X1_X2_X3_data.xlsx', 'Sheet','psi_k');
% Extract Columns
psi_time = psi_data{:,1};
psi_vals = psi_data{:,2};


% Initial Conditions

x_k = [4.99;2.5;3];
x1_0 = x1_ts.getsampleusingtime(0).Data;

A = [ 1, 0, 0; 0, 1, 1; 0, 0, 1];
B = [0; 0; 1];

% Given Parameters

% System Noise Parameters

Q_sys = [0.0025, 0, 0; 0, 0.0025, 0; 0, 0, 0.0025];

R_sys = 0.001;

w = [0; 0; 0];

v = 0;


% Extended Kalman Filter Parameters

prev_P_k = [100, 0, 0; 0, 100, 0; 0, 0, 100];

Q_ekf = [0.0025, 0, 0; 0, 0.0025, 0; 0, 0, 0.0025];

R_ekf = [1, 0; 0, 1];

prev_x_hat = [5; 2; 3];
%prev_x_hat = [2; 10; 5];

G = [0.1, 0.4];     % Proportional Gain


prev_u_k_ekf = (-G(1)*prev_x_hat(2) - (G(2)*prev_x_hat(3)));


% LQR Parameters

Q_lqr = [30, 0; 0, 1];

R_lqr = 1000;
%R_lqr = 1000;

K_lqr = [0.1287, 0.5764];

u_k_lqr = -K_lqr * [prev_x_hat(2);prev_x_hat(3)];

A_lqr = [1, 1; 0, 1];
B_lqr = [0; 1];



%K_lqr = lqr(A_lqr, B_lqr, Q_lqr, R_lqr);



