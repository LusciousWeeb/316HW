clear; 
clc; 
close all;

EPS0 = 8.854e-12;   
a = 1;         
n = 6;              
fprintf('Running MoM cube analysis with %d subdivisions per edge...\n', n);

[p_face, q_face, S_face] = localCoordinates(n, n, a, a);

% Each face has n^2 patches; total = 6 * n^2
Nface = n * n;
N = 6 * Nface;

% Pre-allocate arrays for all 6 faces
x = zeros(1, N);
y = zeros(1, N);
z = zeros(1, N);
S = repmat(S_face, 1, 6);

% Place six cube faces in 3D ----
% Face 1: +z
x(1:Nface) = p_face;
y(1:Nface) = q_face;
z(1:Nface) =  a/2;

% Face 2: –z
x(Nface+1:2*Nface) = p_face;  
y(Nface+1:2*Nface) = q_face;  
z(Nface+1:2*Nface) = -a/2;

% Face 3: +y
x(2*Nface+1:3*Nface) = p_face;  
y(2*Nface+1:3*Nface) =  a/2;  
z(2*Nface+1:3*Nface) = q_face;

% Face 4: –y
x(3*Nface+1:4*Nface) = p_face;  
y(3*Nface+1:4*Nface) = -a/2;  
z(3*Nface+1:4*Nface) = q_face;

% Face 5: +x
x(4*Nface+1:5*Nface) =  a/2;  
y(4*Nface+1:5*Nface) = p_face;  
z(4*Nface+1:5*Nface) = q_face;

% Face 6: –x
x(5*Nface+1:6*Nface) = -a/2;  
y(5*Nface+1:6*Nface) = p_face;  
z(5*Nface+1:6*Nface) = q_face;

% Compute MoM matrix [A] ----
fprintf('Constructing MoM matrix (size %d x %d)...\n', N, N);
A = matrixA(EPS0, S, x, y, z);

% Solve for surface charge density for V0 = 1 V ----
V0 = 1;                       
rhos = A \ (V0 * ones(N, 1));   

% Total charge and surface plot ----
%Q = totalCharge(S, rhos);       
%Q_pC = Q * 1e12;                

%fprintf('Total charge for V = 1 V: %.3f pC\n', Q_pC);

% 3-D plot for one face (use first face only)
rhos_face = reshape(rhos(1:Nface), n, n);
[p_mat, q_mat] = meshgrid(linspace(-a/2, a/2, n), linspace(-a/2, a/2, n));

figure;
surf(p_mat, q_mat, rhos_face);
xlabel('x (m)'); ylabel('y (m)'); zlabel('\rho_s (C/m^2)');
title('Surface Charge Density on One Face (V = 1 V)');
shading interp; colorbar;

%sweep voltages from 1 V to 10 V ----
Vrange = 1:10;
Qvals = zeros(size(Vrange));

for k = 1:length(Vrange)
    rhos = A \ (Vrange(k) * ones(N, 1));
    Qvals(k) = totalCharge(S, rhos);
end

Qvals_pC = Qvals * 1e12;   % convert to pC

%Step 8. Plot Q vs V 
figure;
plot(Vrange, Qvals_pC, '-', 'LineWidth', 1.5);   
xlabel('Voltage (V)');
ylabel('Total Charge Q (pC)');
title('Total Charge vs Voltage');
grid on;

% Compute capacitance from slope (V=1 to 10) 
%C = (Qvals(10) - Qvals(1)) / (Vrange(10) - Vrange(1));  % [F]
%fprintf('Capacitance of the cube = %.3e F\n', C)