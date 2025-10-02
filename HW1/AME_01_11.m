syms r z sigma a eps0 real;


%p = 0.002;
%a = 0.1;
%eps0 = 8.8542E-12;

f = sigma / (2*eps0);
t = z*r / (r^2 + z^2)^(3/2);

% Calculation

Esymbol = integral(f, t, r, 0, a);

pretty(Esymbol);


% Analytical

Eanalytical = sigma / (2*eps0) * (sign(z) - z/sqrt(a^2+z^2));

pretty(Eanalytical);


% Plug in

value_sigma = 2E-3;
Val_A = 0.1;
value_eps0 = 8.8542E-12;

zvec = [linspace(-2*Val_A, -1e-6, 500), 0, linspace(1e-6, 2*Val_A, 500)];

Esymbol_value = zeros(size(zvec));

Eanalytical_value = zeros(size(zvec));

for i = 1:length(zvec)
    zvec_part = zvec(i);
    if zvec_part == 0
        Eanalytical_value(i) = value_sigma/(2*value_eps0);
        Esymbol_value(i) = value_sigma/(2*value_eps0);
    else
        Eanalytical_value(i) = double(subs(Eanalytical, {sigma, a, eps0, z}, {...
            value_sigma, Val_A, value_eps0, zvec_part}));
        Esymbol_value(i) = double(subs(Esymbol, {sigma, a, eps0, z}, {...
            value_sigma, Val_A, value_eps0, zvec_part}));
    end
end


plot(zvec, Esymbol_value, 'x');
hold on;
plot(zvec, Eanalytical_value);

xlabel('z[m]');
ylabel('Ez[V/m]');
title('Charged Disk');
legend('Symbolic Solution', 'Analytical solution');