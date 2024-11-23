% Predict 
x_prediction = table();
ts = 0;
for i = 2:500
% Predict state & error covariance
%disp(prev_x_hat)
%x_hat = A * prev_x_hat;
x_hat = [prev_x_hat(1); prev_x_hat(2) + prev_x_hat(3); prev_x_hat(3) + prev_u_k];

P_k = A * prev_P_k* A' + Q_ekf;


% Work Needed to Compute Kalman Gain

%prev_u_k = -G(1) * prev_x_hat(2) - G(2) * prev_x_hat(3);

% Output Meaurements

y_k = [x1_ts.Data(i); x1_ts.Data(i-1)];
%disp('y_k')
%disp(y_k)

%y_hat_k = [x_hat(1) * cos(x_hat(2) + psi_vals(i)); prev_x_hat(1) * cos(prev_x_hat(2) + psi_vals(i-1))];

% New h
h = [x_hat(1) * cosd(x_hat(2) + psi_vals(i));
    x_hat(1) * cosd(x_hat(2) - x_hat(3) + prev_u_k + psi_vals(i-1))];

% New h no psi test
%h = [x_hat(1) * cosd(x_hat(2) + psi_vals(1));
%    x_hat(1) * cosd(x_hat(2) - x_hat(3) + prev_u_k + psi_vals(1))];



y_hat_k = h;
%disp('y_hat_k')
%disp(y_hat_k)

% New Jacobian
C = [cosd(x_hat(2) + psi_vals(i)), -x_hat(1) * sind(x_hat(2) + psi_vals(i)), 0;
    cosd(x_hat(2)-x_hat(3) + prev_u_k + psi_vals(i-1)), -x_hat(1) * sind(x_hat(2)-x_hat(3)+ prev_u_k + psi_vals(i-1)), x_hat(1) * sind(x_hat(2) - x_hat(3) + prev_u_k + psi_vals(i-1))];

% New Jacobian No psi test
%C = [cosd(x_hat(2) + psi_vals(1)), -x_hat(1) * sind(x_hat(2) + psi_vals(1)), 0;
%    cosd(x_hat(2)-x_hat(3) + prev_u_k + psi_vals(1)), -x_hat(1) * sind(x_hat(2)-x_hat(3)+ prev_u_k + psi_vals(1)), x_hat(1) * sind(x_hat(2) - x_hat(3) + prev_u_k + psi_vals(1))];


% Compute Kalman Gain
K_k = P_k * C' * ((C * P_k * C') + R_ekf)^-1;


% Compute the Estimate

x_hat = x_hat + K_k*(y_k - y_hat_k);

% Compute the Error Covariance

P_k = P_k - (K_k * C * P_k);

u_k = (-G(1) * x_hat(2)) - (G(2) * x_hat(3));

prev_u_k = u_k;
prev_x_hat = x_hat;
prev_P_k = P_k;

ts = ts + 0.1;
x_prediction = [x_prediction; table(ts, x_hat(1), x_hat(2), x_hat(3), 'VariableNames', {'time', 'x1', 'x2', 'x3'})];

end


% Plot the predicted data vs the actual data
figure;
plot(x1_ts.Time, x1_ts.Data, 'DisplayName', 'Original X1 Data'); % Original points
hold on;
plot(x_prediction.time, x_prediction.x1, '-', 'DisplayName', 'Estimated Value'); % Interpolated points
legend;
xlabel('x');
ylabel('y');
title('Data Interpolation');
grid on;

% Plot the predicted data vs the actual data
figure;
plot(x2_ts.Time, x2_ts.Data, 'DisplayName', 'Original X2 Data'); % Original points
hold on;
plot(x_prediction.time, x_prediction.x2, '-', 'DisplayName', 'Estimated Value'); % Interpolated points
legend;
xlabel('x');
ylabel('y');
title('Data Interpolation');
grid on;

% Plot the predicted data vs the actual data
figure;
plot(x3_ts.Time, x3_ts.Data, 'DisplayName', 'Original X3 Data'); % Original points
hold on;
plot(x_prediction.time, x_prediction.x3, '-', 'DisplayName', 'Estimated Value'); % Interpolated points
legend;
xlabel('x');
ylabel('y');
title('Data Interpolation');
grid on;

