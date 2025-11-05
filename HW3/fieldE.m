function [E, Eunit, Emag] = fieldE(EPS0, x0, y0, z0, rhos, S, x, y, z)
    k = 1 / (4 * pi * EPS0);
    dx = x0 - x;
    dy = y0 - y;
    dz = z0 - z;
    Ri = sqrt(dx.^2 + dy.^2 + dz.^2);
    inside = (rhos(:)' .* S) ./ Ri.^3;
    R = [dx; dy; dz;];
    E = k .* (R .* inside);










    E = sum(E, 2);
    Emag = norm(E);
    Eunit = E / Emag;
end
