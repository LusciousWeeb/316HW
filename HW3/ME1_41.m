clc; clear all;
% Constants: Adjust as needed
a = 1; % in meter
V = 1:10;
eps0 = 8.8542E-12;
N = 100;
nface = sqrt(N);
nfaces_total = 6*N;
x = zeros(1,nfaces_total);
y = zeros(1,nfaces_total);
z = zeros(1,nfaces_total);
[x_center y_center S] = localCoordinates(nface, nface, a, a);
dS = S(1) .* ones(1, nfaces_total);
% Since this is subdivision, per edge, we need to square root N


% Constructing Cube Section

% coords = [top, base, right, left, front, back]

% Top +z

x(1:N) = x_center;
y(1:N) = y_center;
z(1:N) = a;

% Bottom 0z
x(N+1:2*N) = x_center;
y(N+1:2*N) = y_center;
z(N+1:2*N) = 0;

% Right +x
x(2*N+1:3*N) = a;
y(2*N+1:3*N) = y_center;
z(2*N+1:3*N) = x_center;

% Left 0x
x(3*N+1:4*N) = 0;
y(3*N+1:4*N) = y_center;
z(3*N+1:4*N) = x_center;

% Front +y
x(4*N+1:5*N) = x_center;
y(4*N+1:5*N) = 0;
z(4*N+1:5*N) = y_center;

% Back 0y
x(5*N+1:6*N) = x_center;
y(5*N+1:6*N) = a;
z(5*N+1:6*N) = y_center;

A = matrixA(eps0, dS, x, y, z);

Beta = V(1) .* ones(nfaces_total, 1);

rhos = A \ Beta;

flat_rhos = reshape(rhos(1:N), nface, nface);


[x_mesh y_mesh] = meshgrid(linspace(0, a, nface), linspace(0, a, nface));

figure;
surf(x_mesh, y_mesh, flat_rhos);
hold on;
xlabel('x (m)'); 
ylabel('y (m)'); 
zlabel('\rho_s (C/m^2)');
title('Surface Charge Density on One Face');

Qtotal = totalCharge(dS, rhos)*1e12;
Qlist = zeros(size(V));
for i = 1:length(V)
    rhos = A \ (V(i) .* ones(nfaces_total, 1));
    Qlist(i) = totalCharge(dS, rhos)*1e12;
end

figure;
plot(V, Qlist, 'LineWidth', 1, 'Color', 'b');
xlabel('Voltage V [Volts]');
ylabel('Total Charge Q [pC]');
title('Qtotal [pC] vs. Voltage [Volts]');

% 4

C = (Qlist(end) - Qlist(1)) / (V(end) - V(1));
disp(['The capacitance is ', num2str(C), ' pF']);


