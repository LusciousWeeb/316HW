function f = vecPlot3D(Vstart, Vend, Scaling, Colour, Origin)

    if length(Vstart) ~= 3 || length(Vend) ~= 3
        f = 0;
        fprintf('Vectors must be 3-dimensional\n');
        return;
    end

    hold on;

    % Optional marker at the endpoint
    if Origin
        scatter3(Vend(1), Vend(2), Vend(3), 'filled', 'o', 'MarkerFaceColor', Colour);
    end

    % Draw arrow from Vstart to Vend
    Vdiff = Vend - Vstart;
    f = quiver3(Vstart(1), Vstart(2), Vstart(3), ...
                Vdiff(1), Vdiff(2), Vdiff(3), ...
                Scaling, 'Color', Colour, 'LineWidth', 2);

    view(3);
    grid on;
    xlabel('X'); ylabel('Y'); zlabel('Z');

end
