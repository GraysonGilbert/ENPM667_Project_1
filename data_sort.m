% Load data from Excel
x1_data = readtable('X1_X2_X3_data.xlsx', 'Sheet','x1');
x2_data = readtable('X1_X2_X3_data.xlsx', 'Sheet','x2');
x3_data = readtable('X1_X2_X3_data.xlsx', 'Sheet','x3');
psi_data = readtable('X1_X2_X3_data.xlsx', 'Sheet','psi_k');

% Extract columns
x1 = x1_data{:,1}; % Column 1: independent variable
y1 = x1_data{:,2}; % Column 2: dependent variable

% Extract columns
x2 = x2_data{:,1}; % Column 1: independent variable
y2 = x2_data{:,2}; % Column 2: dependent variable

% Extract columns
x3 = x3_data{:,1}; % Column 1: independent variable
y3 = x3_data{:,2}; % Column 2: dependent variable

% Extract Columns
psi_time = psi_data{:,1};
psi_vals = psi_data{:,2};

% x1 Data Organizing
[x1, idx1] = sort(x1);
y1 = y1(idx1);

% Remove duplicates by averaging `y1` values for duplicate `x1`
[unique_x1, ~, idx] = unique(x1);
y1_unique = accumarray(idx, y1, [], @mean);

x1_new = linspace(min(x1), max(x1), 5001);
x1_new = x1_new(:);

% Perform interpolation
y1_new = interp1(unique_x1, y1_unique, x1_new, 'linear');
y1_new = y1_new(:);

%{
% Plot the original and interpolated data
figure;
plot(x1, y1, 'o', 'DisplayName', 'Original Data'); % Original points
hold on;
plot(x1_new, y1_new, '-', 'DisplayName', 'Interpolated Data'); % Interpolated points
legend;
xlabel('x');
ylabel('y');
title('Data Interpolation');
grid on;
%}


% x2 Data Organizing
[x2, idx2] = sort(x2);
y2 = y2(idx2);

% Remove duplicates by averaging `y1` values for duplicate `x1`
[unique_x2, ~, idx2] = unique(x2);
y2_unique = accumarray(idx2, y2, [], @mean);

x2_new = linspace(min(x2), max(x2), 5001);
x2_new = x2_new(:);

% Perform interpolation
y2_new = interp1(unique_x2, y2_unique, x2_new, 'linear');
y2_new = y2_new(:);

%{
% Plot the original and interpolated data
figure;
plot(x2, y2, 'o', 'DisplayName', 'Original Data'); % Original points
hold on;
plot(x2_new, y2_new, '-', 'DisplayName', 'Interpolated Data'); % Interpolated points
legend;
xlabel('x');
ylabel('y');
title('Data Interpolation');
grid on;
%}


% x3 Data Organizing
[x3, idx3] = sort(x3);
y3 = y3(idx3);

% Remove duplicates by averaging `y1` values for duplicate `x1`
[unique_x3, ~, idx3] = unique(x3);
y3_unique = accumarray(idx3, y3, [], @mean);

x3_new = linspace(min(x3), max(x3), 5001);
x3_new = x3_new(:);

% Perform interpolation
y3_new = interp1(unique_x3, y3_unique, x3_new, 'linear');
y3_new = y3_new(:);


%{
% Plot the original and interpolated data
figure;
plot(x3, y3, 'o', 'DisplayName', 'Original Data'); % Original points
hold on;
plot(x3_new, y3_new, '-', 'DisplayName', 'Interpolated Data'); % Interpolated points
legend;
xlabel('x');
ylabel('y');
title('Data Interpolation');
grid on;
%}


x1_ts = timeseries(y1_new, x1_new);
x2_ts = timeseries(y2_new, x2_new);
x3_ts = timeseries(y3_new, x3_new);
psi_ts = timeseries(psi_vals, psi_time);

save('x1_timeseries.mat', 'x1_ts');
save('x2_timeseries.mat', 'x2_ts');
save('x3_timeseries.mat', 'x3_ts');
save('psi_timeseries.mat', 'psi_ts');