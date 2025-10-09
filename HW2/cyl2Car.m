function [x y z] = cyl2Car(r, theta, z_cycl)
    x = r .* cos(theta);
    y = r .* sin(theta);
    z = z_cycl;

end