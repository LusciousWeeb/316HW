p_s = input('Enter Surface Charge Density in C/m^2: ');
a = input('Enter radius of the hemi-spherical shell in metres: ');
N = input('Enter number of rings used in the numerical sum: ');
z_f = input('Enter the z coordinate of the field point in meters: ');


% Constant
k = 8.897E9;
eps0 = 8.854E-12;


% Numerically Integrated
constant = (1/ (4 * pi * eps0)) * (2 * pi * p_s * a^2);
dtheta = pi / (2 * N);
theta = ((1:N) - 0.5) * dtheta;

sin_i = sin(theta);
cos_i = cos(theta);

num = sin(theta) .* (z_f - (a .* cos(theta)));
den = (z_f^2 + a^2 - (2 .* a .* z_f .* cos(theta))).^(3/2);

E_z_prior = constant .* (num ./ den) .* dtheta;

E_z = sum(E_z_prior);

% Analytically Integrated

Ez = ((p_s * a^2) / (2*eps0*z_f^2)) * ((a / (sqrt(z_f^2 + a^2)) ) + ((z_f - a) / abs(z_f - a)));



fprintf(['The numerical solution outputs: %.3e V/m\n' ...
    'The analytical solution outputs: %.3e V/m\n'], E_z, Ez)