% Script to set up workspace for Simulink Model


%x = [(C_p * I_theta * exp(-c * d)) / d^2; phi; phi_dot];    % State Vector

A = [ 1, 0, 0; 0, 1, 1; 0, 0, 1];
B = [0; 0; 1];

% Given Parameters

Q_sys = [0.0025, 0, 0; 0, 0.0025, 0; 0, 0, 0.0025];

R_sys = 0.001;

P_0 = [100, 0, 0; 0, 100, 0; 0, 0, 100];

Q_ekf = [0.0025, 0, 0; 0, 0.0025, 0; 0, 0, 0.0025];

R_ekf = [1, 0; 0, 1];

Q_lqr = [30, 0; 0, 1];

R_lqr = 1000;

x_hat_0 = [5; 2; 3];

G = [0.1, 0.4];     % Proportional Gain

K_lqr = [0.1287, 0.5764];

psi_k = [-2, -4, -6, -8, -10, -8, -6, -4, -2, 0, 2, 4, 6, 8, 10, 8, 6, 4, 2, 0];

%x_1k = ;

%x_k = [x_1k; x_2k; x_3k];

function x = myStateTransitionFcn(x, u)

% dt = 0.01 %Sample Time
x1 = x(1);
x2 = x(2) + x(3);
x3 = x(3) + u;

x = [x1; x2; x3];

% Make function inside here

end

function yk = meaurement(x)

y = 

end 