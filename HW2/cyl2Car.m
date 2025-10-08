function [x y z] = cyl2Car(r, theta, z_cycl)
    x = r .* cos(theta);
    y = r .* sin(theta);
    z = z_cycl;

    fprintf('The cartesian coordinates of the given input are: \nx = %.3f\ny = %.3f\nz =%.3f\n', x, y, z);
end