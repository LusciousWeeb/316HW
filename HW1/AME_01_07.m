vector_Q = [];
coords_Q = [];
k = 1 ./ (4 * pi * 8.854E-12)

N = input('Number of source charges: ');

for i = 1:N
    X = input(sprintf('X Coordinate of Q%1.0f in units of cm: ', i));
    Y = input(sprintf('Y Coordinate of Q%1.0f in units of cm: ', i));
    Z = input(sprintf('Z Coordinate of Q%1.0f in units of cm: ', i));

    if ~(isnumeric([X Y Z]))
        fprintf('The inputed coordinate address is invalid!')
        break;
    end
    coords_Q = [[X Y Z]; coords_Q];
    vector_Q(i) = input(sprintf('Value of Q%1.0f in nC: ', i));
    
    

end

%Field Point

Xtest = input('X Coordinate of Field Point in units of cm: ');
Ytest = input('Y Coordinate of Field Point in units of cm: ');
Ztest = input('Z Coordinate of Field Point in units of cm: ');


coords_test = [Xtest Ytest Ztest];
% Plot the points
for i = 1:N
    
    rvec = coords_test - coords_Q(i, :)
    rmag = vectorMag(rvec)
    F_vec = (k * Qtest * vector_Q(i) * 10E-18 * rvec) ./ (rmag).^3;
    Magnitude = vectorMag([F_vec]);
    fprintf(['For source charge Q%1.0f, the force component is \n' ...
        'Fx = %.3e\n' ...
        'Fy = %.3e\n' ...
        'Fz = %.3e\n' ...
        'Magnitude = %.3e\n'], N, Fx, Fy, Fz, Magnitude)
    
    hold on;
    % Plot the dot

    scatter3(coords_Q(i,1), coords_Q(i,2), coords_Q(i,3), 80, 'blue', 'o')  %source
    hold on;
    plot3([coords_Q(i,1) Xtest], [coords_Q(i,2) Ytest], [coords_Q(i,3) Ztest], 'LineStyle', '-.', 'Color', 'b') %Plots the line
    
    
    Vend = coords_test + coords_Q(i, :);
    vecPlot3D(coords_test, Vend, 1, 'b', 0);
    hold on;


    Vstart = coords_test;
    Vend = coords_test + F_vec;
    vecPlot3D(Vstart, Vend, 0, 'r', 1);

end
scatter3(Xtest, Ytest, Ztest, 80, 'blue', 'o')
axis equal
grid on
view(3)   % force 3D view