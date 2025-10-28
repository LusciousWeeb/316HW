function A = matrixA(eps, dS, x, y, z)
    % Have to find out if 1-D, 2-D, or 3-D

    number = length(x);
    if (length(dS) == number)
        for i = 1:number
            for j = 1:number
                if nargin == 3
                    % 1-D
                    R = abs(x(j) - x(i));
                elseif nargin == 4
                    % 2-D
                    R = sqrt((x(j) - x(i))^2 + (y(j) - y(i))^2);
                elseif nargin == 5
                    % 3-D
                    R = sqrt((x(j) - x(i))^2 + (y(j) - y(i))^2 + (z(j) - z(i))^2);
                end
            if (i == j)
                A(i, j) = sqrt(dS(j)) / (2 * sqrt(pi) * eps);
            else
                A(i, j) = dS(j) / (4 * pi * R * eps);
            end

            end
        end
    else
        A = 0;
        disp('Incorrect Input');
    end;
end