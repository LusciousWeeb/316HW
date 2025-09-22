vector_Q = [];

N = input('Number of source charges: ');

for i = 1:N
    X = input(sprintf('X Coordinate of Q%1.0f in units of cm: ', i));
    Y = input(fprintf('Y Coordinate of Q%1.0f in units of cm: ', i));
    Z = input(fprintf('Z Coordinate of Q%1.0f in units of cm: ', i));

    if ~(isnumeric([X Y Z]))
        fprintf('The inputed coordinate address is invalid!')
        break;
    end

    vector_Q(i) = input(fprintf('Value of Q%1.0 in nC: ', i));

end
