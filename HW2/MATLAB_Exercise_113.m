clear; close all; clc

N = input('Number of subdivision of the line: ');
L_cm = input('Length of the line in cm: ');
Q_u = input('Total charge in nC:');
L = L_cm * 10^-2
Q = Q_u * 10^-9

eps0 = 8.854e-12;

k = 1 / (4 * pi * eps0);

% Set up bounds
xvalue = linspace(-0.6*L, 0.6*L, 10);
yvalue = linspace(-0.2*L, 0.2*L, 10);

[X, Y] = meshgrid(xvalue, yvalue);

dQ = Q / N

line_endpoint = linspace(-L/2, L/2, N);

[rows cols] = size(X);

for i = 1:rows
    for j = 1:cols
        r_x = X(i, j) - line_endpoint;
        r_y = Y(i, j) - line_endpoint;

        R = sqrt(r_x.^2 + r_y.^2);

        dEx = k * dQ * (r_x ./ R.^3);
        dEy = k * dQ * (r_y ./ R.^3);

        Ex(i , j) = sum(dEx);
        Ey(i, j) = sum(dEy);
    end
end
% Diagnostic
E_mag = sqrt(Ex.^2 + Ey.^2);
fprintf('N subdivisions = %d, Q Charge = %.3e C, L = %.3e m\n', N, Q, L);
fprintf('Min E-Field Mag: %.e3 V/m, Max E-Field Mag: %.e3', min(E_mag(:)), max(E_mag(:)));

% Prepare for plot
U = Ex; V = Ey;

Magnitude = sqrt(U.^2 + V.^2);

U = U ./ Magnitude;
V = V ./ Magnitude;
% Scale
E_mag = sqrt(Ex.^2 + Ey.^2);
scale = log10(1 + E_mag);
if max(scale(:)) == 0
    scale = ones(size(scale));
else
    scale = scale / max(scale(:));
end
U = U .* scale;
V = V .* scale;

figure('Name', 'Electric Field from Finite Line Charge');
quiver(X, Y, U, V, 1.1, 'AutoScale', 'off');

axis equal;
xlabel('X (m)');
ylabel('Y (m)');

title(sprintf('Electric Field from finite line charge, N=%d, Q=%.3e C, L=%.3e m', N, Q, L));
hold on;
plot([-L /2, L/2], [0,0], 'r-', 'LineWidth', 3);

scatter(X(:), Y(:), 40, 'yellow', 'filled')