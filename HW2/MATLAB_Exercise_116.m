clc; clear; close all;
L_cm = input('Enter the Length of the line in cm: ');
L = L_cm * 10^-2;
Q_prime = input('Enter the density of charge in nC/m: ');

Q = Q_prime * 10^-9;
% Set up Constant
eps0 = 8.854e-12;
k = 1 / (4 * pi * eps0);

D_vector = linspace(L*0.1, 2*L, 100);
E_vector_finite = zeros(1, length(D_vector));
E_vector_infinite = zeros(1, length(D_vector));
k_vector = zeros(1, length(D_vector));
% Electric Field with Infinite Length

for i = 1:length(D_vector)
    theta1 = atan(-L/2 / D_vector(i));
    theta2 = atan(L/2 / D_vector(i));

    Ex = ((k*Q) / D_vector(i)) * (sin(theta2) - sin(theta1));
    Einfinite = Q / (2 * pi * eps0 * D_vector(i));
    E_vector_finite(i) = Ex;
    E_vector_infinite(i) = Einfinite;
    k_vector(i) = D_vector(i) / L;
end

error = (abs(E_vector_finite - E_vector_infinite) ./ E_vector_infinite) * 100;
figure;
title('Comparison of E-Fields Due to Finite and Infinite Lines of Charge')
xlabel('E [V/m]')
ylabel('k = D/L')

plot(k_vector, E_vector_finite, 'LineStyle', '-');
hold on;
plot(k_vector,E_vector_infinite, 'LineStyle', '--');

idx = find(error < 10)
fprintf('The max distance D is: %.3f m\n', D_vector(idx(end)))
