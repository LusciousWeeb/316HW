clc; close all;

coordinates = {'Cartesian', 'Spherical', 'Cylindrical'};

f = uifigure('Name', 'Coordinate Converter', 'Position', [500 350 500 500], 'WindowStyle', 'modal');
% Coordinate Selector
welcomeMessage = uilabel(f, ...
    'Text', 'Select Coordinate to Convert From:', ...
    'Position', [100 440 300 30], ...
    'FontSize', 16);


% Coordinate Label
coordLabel = uilabel(f, ...
    'Text', sprintf('x [m]\n\ny [m]\n\nz [m]'), ...
    'Position', [70 270 100 150], ...
    'FontSize', 16);


% input box
xField = uieditfield(f, 'numeric', 'Position', [120 373 100 22]);
yField = uieditfield(f, 'numeric', 'Position', [120 330 100 22]);
zField = uieditfield(f, 'numeric', 'Position', [120 295 100 22]);

inputFields = [xField yField zField];
% Data Enter
coord_dropdown = uidropdown(f, ...
    'Items', coordinates, ...
    'Position', [100 410 150 25], ...
    'ValueChangedFcn', @(src, event) displayCorrect(src, coordLabel, coordinates));
% Converter Selector

converter_selector = uidropdown(f, ...
    'Items', coordinates, ...
    'Position', [100 245 150 25]);

% Output

outputLabel = uilabel(f, ...
    'Text', ' ', ...
    'Position', [70 145 300 150], ...
    'FontSize', 12);

% Submit Button
submitButton = uibutton(f, ...
    'Text', 'Submit', ...
    'ButtonPushedFcn', @(btn, event) valueSubmit(inputFields, coord_dropdown, converter_selector, outputLabel));




% Callback function
function displayCorrect(src, target, coordinates)
    if strcmp(src.Value, coordinates{1}) % Cartesian
        target.Text = sprintf('x [m]\n\ny [m]\n\nz [m]');
    elseif strcmp(src.Value, coordinates{2}) % Spherical
        target.Text = sprintf('r [m]\n\nθ [rad]\n\nφ [rad]');
    elseif strcmp(src.Value, coordinates{3}) % Cylindrical
        target.Text = sprintf('r [m]\n\nθ [rad]\n\nz [m]');
    end
end

function valueSubmit(inputFields, coord_dropdown, converter_selector, outputLabel)
   a = inputFields(1).Value;
   b = inputFields(2).Value;
   c = inputFields(3).Value;

   from = coord_dropdown.Value;
   to = converter_selector.Value;

   if strcmp(from, to)
       outputLabel.Text = 'Please select different coordinate systems.';
       return;
   end
  
   if (strcmp(from, 'Spherical')  && strcmp(to, 'Cartesian')) % Sph -> Car
       [x y z] = sph2Car(a, b, c);
       outputLabel.Text = sprintf('x = %.3f m\t y = %.3f m\t z = %.3f m', x, y, z);
   elseif (strcmp(from, 'Cartesian') && strcmp(to, 'Spherical')) % Car -> Sph
       [p, theta, phi] = car2Sph(a, b, c);
       outputLabel.Text = sprintf('ρ = %.3f\tθ = %.3f rad\tφ = %.3f rad', p, theta, phi);
   elseif (strcmp(from, 'Cylindrical') && strcmp(to, 'Cartesian')) % Cyl -> Car
       [x y z] = cyl2Car(a, b, c);
       outputLabel.Text = sprintf('x = %.3f m\t y = %.3f m\t z = %.3f m', x, y, z);
   elseif (strcmp(from, 'Cartesian') && strcmp(to, 'Cylindrical')) % Car -> Cyl
       [r, theta, z] = car2Cyl(a, b, c);
       outputLabel.Text = sprintf('r = %.3f m\tθ = %.3f rad\tz = %.3f m', r, theta, z);
   elseif (strcmp(from, 'Cylindrical') && strcmp(to, 'Spherical')) % Cyl -> Sph
       [x y z] = cyl2Car(a, b, c);
       [p, theta, phi] = car2Sph(x, y, z);
       outputLabel.Text = sprintf('ρ = %.3f\tθ = %.3f rad\tφ = %.3f rad', p, theta, phi);
   elseif (strcmp(from, 'Spherical') && strcmp(to, 'Cylindrical')) % Sph -> Cyl
       [x y z] = sph2Car(a, b, c);
       [r, theta, z] = car2Cyl(x, y, z);
       outputLabel.Text = sprintf('r = %.3f m\tθ = %.3f rad\tz = %.3f m', r, theta, z);
   end
end