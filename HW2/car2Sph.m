function [p, theta, phi] = car2Sph(x, y, z)
    p = sqrt(x.^2 + y.^2 + z.^2)
   
    theta = acos(max(min(z ./ p, 1), -1))
    phi = atan2(y, x);


end