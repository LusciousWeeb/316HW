function [p, q, S] = localCoordinates(n, m, a, b)
    dS = (a / n) * (b / m);             % area of one patch
    x_centers = linspace(a/(2*n), a - a/(2*n), n);
    y_centers = linspace(b/(2*m), b - b/(2*m), m);
    [X, Y] = meshgrid(x_centers, y_centers);
    p = X(:)';   % flatten to N x 1
    q = Y(:)';  % flatten to N x 1
    S = dS * ones(size(p));  % initialize S with the area of each patch
end
