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


%x = [(C_p * I_theta * exp(-c * d)) / d^2; phi; phi_dot];    % State Vector

A = [ 1, 0, 0; 0, 1, 1; 0, 0, 1];
B = [0; 0; 1];
clear

A = [ 1, 0, 0; 
      0, 1, 1; 
      0, 0, 1];
B = [0; 
     0; 
     1];

% Given Parameters

Q_sys = [0.0025, 0, 0; 0, 0.0025, 0; 0, 0, 0.0025];

R_sys = 0.001;

prev_P_k = [100, 0, 0; 0, 100, 0; 0, 0, 100];

Q_ekf = [0.0025, 0, 0; 0, 0.0025, 0; 0, 0, 0.0025];

R_ekf = [1, 0; 0, 1];

Q_lqr = [30, 0; 0, 1];

R_lqr = 1000;

prev_x_hat = [5; 2; 3];
%prev_x_hat = [2; 10; 5];

G = [0.1, 0.4];     % Proportional Gain

K_lqr = [0.1287, 0.5764];

%psi_k = [-2, -4, -6, -8, -10, -8, -6, -4, -2, 0, 2, 4, 6, 8, 10, 8, 6, 4, 2, 0];

prev_u_k = 0;

%x_1k = ;

%x_k = [x_1k; x_2k; x_3k];

function x = myStateTransitionFcn(x, u)

dt = 0.1; %Sample Time

x = x + [x(1); x(2) + x(3); x(3) + u] * dt;

% Make function inside here

end

%function yk = meaurement(x)

%y =; 

%end 