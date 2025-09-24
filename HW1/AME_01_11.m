syms r z;

p = 0.002;
a = 0.1;
eps0 = 8.8542E-12;


% Calculation

R = sqrt(r^2 + z.^2);
f = z./R.^3;
t = (p*2*r*pi)/(4*pi*eps0);
E = simplify(integral(f, t, r, 0, a))




% Analytical Solving
zvec = linspace(-2*a, 2*a, 200);
Ez = double(subs(E, z, zvec));
Eanalytical = sign(zvec) .* ((p/(2*eps0)) .* (1 - abs(zvec)./sqrt(zvec.^2 + a^2)));
Eanalytical(zvec==0) = p/(2*eps0);

% Plotting time!
plot(zvec, Ez, 'rx', zvec, Eanalytical, 'k', 'LineWidth', 2);
xlabel('z (m)');
ylabel('Electric Field in z axis [V/m]');

title('MATLAB EXERCISE 1.11');