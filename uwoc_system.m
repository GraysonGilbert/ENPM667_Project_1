function [x, y, prev_w, prev_v] = uwoc_system(x_km1, u_km1, Q_sys, R_sys, prev_w, prev_v)

% Noise Parameters
mu = 0;
w = Q_sys * randn(3,1) + mu;
v = R_sys * randn(1,1) + mu;


x1 = x_km1(1) + prev_w(1);
x2 = x_km1(2) + x_km1(3) + prev_w(2);
x3 = x_km1(3) + u_km1 + prev_w(3);

y1 = x1*cosd(x2) + v;
y2 = x_km1(1) * cosd(x_km1(2)) + prev_v;

x = [x1; x2; x3];
y = [y1; y2];

prev_w = w;
prev_v = v;

end