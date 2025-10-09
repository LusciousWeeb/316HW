f = uifigure('Name','Material Permittivity','Position', [500 350 500 500]);

% List out the values and materials
materials = {'Vaccuum', 'Freon', 'Air', 'Styrofoam', 'Polyurethane foam', 'Paper', 'Wood', 'Dry soil', 'Paraffin', 'Teflon', 'Vaseline', 'Polyethylene', 'Oil', 'Rubber', 'Polystyrene', ...
    'PVC', 'Amber', 'Plexiglass', 'Nylon', 'Fused silica', 'Sulfur', 'Glass', 'Bakelite', 'Quartz', 'Diamond', 'Wet Soil', 'Mica (ruby)', 'Steatite', 'Sodium chloride', 'Porcelain', 'Neoprene',...
    'Silicon nitride', 'Marble', 'Alumina', 'Animal and human muscle', 'Silicon', 'Gallium arsenide', 'Germanium', 'Ammonia (Liquid)', 'Alcohol (Ethyl)', 'Tantalum pentoxide', 'Glycerin' ,'Ice',...
    'Water', 'Rutile', 'Barium Titnate'};

epsr = {1, 1, 1.0005, 1.03, 1.1, [1.3 3], [2 5], [2 6], 2.1, 2.1, 2.16, 2.25, 2.3, [2.4 3], 2.56, 2.7, 2.7, 3.4, [3.6 4.5], 3.8, 4, [4 10], 4.74, 5, [5 6], [5 15], 5.4, 5.8, 5.9, 6, 6.6, 7.2, ...
    8, 8.8, 10, 11.9, 13, 16, 22, 25, 25, 50, 75, 81, [89 173], 1200};
valueMessage = uilabel(f, "Text", ' ', 'Position', [50 290 250 30], 'FontSize', 16);
dropdown = uidropdown(f, 'Items', materials, 'ItemsData', epsr, 'Position', [50 325 250 30], 'ValueChangedFcn', @(src, event) displayValue(src, valueMessage));

welcomeMessage = uilabel(f, "Text", 'Select a Material', 'Position', [50 350 250 40], 'FontSize', 16);


function displayValue(src, target)
    value = src.ItemsData{src.ValueIndex};

    if numel(value) == 1
        target.Text = ['Relative Permittivity: ', num2str(value)];
    else
        target.Text = ['Relative Permittivity: ', num2str(value(1)), '-', num2str(value(2))];
    end
end
