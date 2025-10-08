function [x, y, z] = sph2Car(p, theta, phi)
    x = p .* sin(phi) .* cos(theta);
    y = p .* sin(phi) .* sin(theta);
    z = p .* cos(phi);


    fprintf('The cartesian coordinates of the given input are: \nx = %.3f\ny = %.3f\nz =%.3f\n', x, y, z);
end