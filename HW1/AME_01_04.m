clc; clear; close all;

k = 8.9875e9;
coords_Q = [];
vector_Q = [];

N = input('Number of source charges: ');

for i = 1:N
    X = input(sprintf('X Coordinate of Q%1.0f in cm: ', i));
    Y = input(sprintf('Y Coordinate of Q%1.0f in cm: ', i));
    Z = input(sprintf('Z Coordinate of Q%1.0f in cm: ', i));

    coords_Q = [coords_Q; X Y Z];
    vector_Q(i) = input(sprintf('Value of Q%1.0f in nC: ', i));
end

Xtest = input('X Coordinate of Qtest (cm): ');
Ytest = input('Y Coordinate of Qtest (cm): ');
Ztest = input('Z Coordinate of Qtest (cm): ');
Qtest = input('Value of Qtest (nC): ');

coords_Q = coords_Q * 1e-2;
coords_test = [Xtest Ytest Ztest] * 1e-2;
vector_Q = vector_Q * 1e-9;
Qtest = Qtest * 1e-9;

F_singular = zeros(N,3);
F_total = [0 0 0];

for i = 1:N
    
    rvec = coords_test - coords_Q(i,:);
    rmag = norm(rvec);

    F_singular(i,:) = k * Qtest * vector_Q(i) * rvec / (rmag^3);
    F_total = F_total + F_singular(i,:);

    Magnitude = norm(F_singular(i,:));
    fprintf(['For source charge Q%1.0f:\n' ...
        'Fx = %.3e\nFy = %.3e\nFz = %.3e\nMagnitude = %.3e\n\n'], ...
        i, F_singular(i,1), F_singular(i,2), F_singular(i,3), Magnitude);

    
end
Fmag = norm(F_total);
scale = 1/(100*Fmag);
figure; hold on; grid on;
xlabel('X (cm)'); ylabel('Y (cm)'); zlabel('Z (cm)');
title('Force Vectors on Test Charge');
axis equal; view(3);

for i = 1:N
    scatter3(coords_Q(i,1), coords_Q(i,2), coords_Q(i,3), 80, 'blue', 'o');
    plot3([coords_Q(i,1) Xtest], [coords_Q(i,2) Ytest], [coords_Q(i,3) Ztest], 'LineStyle', '-.', 'Color', 'b');
    vecPlot3D([Xtest Ytest Ztest], [Xtest Ytest Ztest] + scale*F_singular(i,:)/1e-2, 0, 'b', 0); 
end

scatter3(Xtest, Ytest, Ztest, 80, 'red', 'o', 'filled');
vecPlot3D([Xtest Ytest Ztest], [Xtest Ytest Ztest] + scale*F_total/1e-2, 0, 'r', 1); 

fprintf('Total Force:\nFx = %.3e\nFy = %.3e\nFz = %.3e\nMagnitude = %.3e\n', ...
    F_total(1), F_total(2), F_total(3), Fmag);
