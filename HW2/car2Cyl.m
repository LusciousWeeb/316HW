function [r, theta, z_cyl] = car2Cyl(x, y, z)
    r = sqrt(x.^2 + y.^2);

    theta = atan2(y, x);
    
    z_cyl = z;
end
