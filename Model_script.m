% Predict 
x_prediction = table();
ts = 0;
for i = 2:500
% Predict state & error covariance
%disp(prev_x_hat)
x_hat = A * prev_x_hat;
P_k = A * prev_P_k* A' + Q_ekf;


% Work Needed to Compute Kalman Gain

% Output Meaurements
%y_hat_k = [x_hat(1) * cos(x_hat(2) + psi_vals(i)); prev_x_hat(1) * cos(prev_x_hat(2) + psi_vals(i-1))];
h = [x1_ts.Data(i) * cos(x2_ts.Data(i) + psi_vals(i)); x1_ts.Data(i) * cos(x2_ts.Data(i) - x3_ts.Data(i) + prev_u_k + psi_vals(i-1))];
y_hat_k = h;

% Jacobian
C = [cos(x2_ts.Data(i) + psi_vals(i)), -x1_ts.Data(i) * sin(x2_ts.Data(i)+psi_vals(i)), 0;
    cos(x2_ts.Data(i)-x3_ts.Data(i) + prev_u_k + psi_vals(i-1)), -x1_ts.Data(i)*sin(x2_ts.Data(i)-x3_ts.Data(i)+ prev_u_k + psi_vals(i-1)), x2_ts.Data(i)-x3_ts.Data(i) + prev_u_k + psi_vals(i-1)];


% Compute Kalman Gain
K_k = P_k * C' * ((C * P_k * C') + R_ekf)^(-1);


% Compute the Estimate

x_hat = x_hat + K_k*(h - (C*x_hat));

% Compute the Error Covariance

P_k = P_k - (K_k * C * P_k);

prev_x_hat = x_hat;
prev_P_k = P_k;

ts = ts + 0.1;
x_prediction = [x_prediction; table(ts, x_hat(1), x_hat(2), x_hat(3), 'VariableNames', {'time', 'x1', 'x2', 'x3'})];

end


% Plot the predicted data vs the actual data
figure;
plot(x1_ts.Time, x1_ts.Data, 'DisplayName', 'Original Data'); % Original points
hold on;
plot(x_prediction.time, x_prediction.x1, '-', 'DisplayName', 'Estimated Value'); % Interpolated points
legend;
xlabel('x');
ylabel('y');
title('Data Interpolation');
grid on;

%disp(C)
%disp(K_k)
%disp(x_hat)
%disp(P_k)
%disp(x_prediction)