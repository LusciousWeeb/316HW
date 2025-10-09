function [x, y, z] = sph2Car(p, theta, phi)
    x = p .* sin(phi) .* cos(theta);
    y = p .* sin(phi) .* sin(theta);
    z = p .* cos(phi);


end