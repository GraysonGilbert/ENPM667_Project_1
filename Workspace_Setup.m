clear

A = [ 1, 0, 0; 
      0, 1, 1; 
      0, 0, 1];
B = [0; 
     0; 
     1];

% Given Parameters

Q_EKF = [0.0025, 0, 0; 
         0, 0.0025, 0; 
         0, 0, 0.0025];

R_EKF = 0.001;

P_0 = [100, 0, 0;
       0, 100, 0;
       0, 0, 100;];

xhat_0_1 = 5;
xhat_0_2 = 2;
xhat_0_3 = 3;
xhat_0 = [xhat_0_1;
          xhat_0_2;
          xhat_0_3];

% Calculate C_0 matrix
C11 = cosd(xhat_0_2);
C12 = -xhat_0_1 * sind(xhat_0_2);
C13 = 0;
C21 = cosd(xhat_0_2 - xhat_0_3 + 0);  % 0 represents uk-1
C22 = -xhat_0_1 * sind(xhat_0_2 - xhat_0_3 + 0);
C23 = xhat_0_1 * sind(xhat_0_2 - xhat_0_3 + 0);
C_0 = [C11, C12, C13;
       C21, C22, C23;]

% Calculate K_kal_0 matrix
K_kal_0 = P_0 * C_0' * inv(C_0 * P_0 * C_0' + R_EKF) 
