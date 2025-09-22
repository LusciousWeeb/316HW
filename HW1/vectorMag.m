function f = vectorMag(vector)
    if ~(isrow(vector) || iscolumn(vector))
        f = 0;
        fprintf('The magnitude of the given vector is: %4.2\n', f)
        return;
    end
    a = 0;
    if isrow(vector) %if row
        sz = length(vector);
        for i = 1:sz;
            a = a + vector(i).^2;
        end
        f = sqrt(a);
        fprintf('The magnitude of the given vector is: %4.2\n', f)
        return;
    elseif iscolumn(vector)
        sz = length(vector);
        for i = 1:sz;
            a = a + vector(i).^2;
        end
        f = sqrt(a);
        fprintf('The magnitude of the given vector is: %4.2\n', f)
        return;
    else
        f = 0;
        fprintf('The magnitude of the given vector is: %4.2\n', f)
        return;
    end
end
        
