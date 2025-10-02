clc; clear; close all;

k = 8.9875e9;       % Coulomb constant
cm2m = 1e-2;        % cm -> m
scaleQ = 1e-9;      % nC -> C

vector_Q = [];
coords_Q = [];

N = input('Number of source charges: ');

for i = 1:N
    X = input(sprintf('X Coordinate of Q%1.0f (cm): ', i));
    Y = input(sprintf('Y Coordinate of Q%1.0f (cm): ', i));
    Z = input(sprintf('Z Coordinate of Q%1.0f (cm): ', i));

    coords_Q = [coords_Q; X Y Z];
    vector_Q(i) = input(sprintf('Value of Q%1.0f (nC): ', i));
end

Xtest = input('X Coordinate of Field Point (cm): ');
Ytest = input('Y Coordinate of Field Point (cm): ');
Ztest = input('Z Coordinate of Field Point (cm): ');

coords_test = [Xtest Ytest Ztest];

% --- Convert units ---
coords_Q = coords_Q * cm2m;
coords_test = coords_test * cm2m;
vector_Q = vector_Q * scaleQ;

F_each = zeros(N,3);
F_total = [0 0 0];

% --- Compute force vectors ---
for i = 1:N
    rvec = coords_test - coords_Q(i,:);
    rmag = norm(rvec);

    F_each(i,:) = k * vector_Q(i) * rvec / (rmag^3);
    F_total = F_total + F_each(i,:);
    
    Magnitude = norm(F_each(i,:));
    fprintf(['For source charge Q%1.0f:\n' ...
        'Fx = %.3e\nFy = %.3e\nFz = %.3e\nMagnitude = %.3e\n\n'], ...
        i, F_each(i,1), F_each(i,2), F_each(i,3), Magnitude);
end

Fmag = norm(F_total);

fprintf('Total Force at Field Point:\nFx = %.3e\nFy = %.3e\nFz = %.3e\nMagnitude = %.3e\n', ...
    F_total(1), F_total(2), F_total(3), Fmag);

% --- Plot ---
figure; hold on; grid on; axis equal;
xlabel('X (m)'); ylabel('Y (m)'); zlabel('Z (m)');

% Scale vectors (like friend)
scale = 1/(100*Fmag);

% Blue arrows: individual contributions
for i = 1:N
    vecPlot3D(coords_test, F_each(i,:)*scale, 1, 'b', 0);
end

% Red arrow: total
vecPlot3D(coords_test, F_total*scale, 1, 'r', 1);

view(3);
