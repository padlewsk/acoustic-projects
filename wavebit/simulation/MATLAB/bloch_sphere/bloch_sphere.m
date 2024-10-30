function [output] = bloch_sphere(params,rho,theta,phi)
% Define polar angles (in radians)



% Create the Bloch sphere (transparent)
[x_sphere, y_sphere, z_sphere] = sphere(128);
colormap gray
surf(x_sphere, y_sphere, z_sphere, 'FaceAlpha', 0.1, 'EdgeColor', 'k'); % Transparent sphere
shading interp
hold on
%cmap = jet(numel(rho));
cmap = [1.0 0.0 0.0
        0.0 0.0 1.0
        ];
ii_cmap = 1;
for ii = 1:size(rho,1) %number of qubits
    for jj = 1:size(rho,2) %number of gates
        % Calculate Bloch coordinates
        x = 1 * sin(theta(ii,jj)) * cos(phi(ii,jj)); 
        y = 1 * sin(theta(ii,jj)) * sin(phi(ii,jj));
        z = 1 * cos(theta(ii,jj));

        % Add the state vector (as an arrow)
        arrow_length = rho(ii,jj); % (adjust as desired)
        arrow_start = [0, 0, 0];
        arrow_end = [x, y, z];
        arrow_dir = arrow_end - arrow_start;
        quiver3(arrow_start(1), arrow_start(2), arrow_start(3), ...
        arrow_dir(1), arrow_dir(2), arrow_dir(3), arrow_length, ...
        'Color',cmap(ii_cmap,:),'LineWidth', 2);
        ii_cmap = ii_cmap + 1;
    end
end


% Customize the plot (optional)
axis equal;
% Set the axis limits symmetrically around the origin
axis auto;
a = 1.4;
amax = max(abs(a));
axis([-amax, amax, -amax, amax, -amax, amax]);

% Add lines for the axes intersecting at the origin
hold on;
line(xlim, [0, 0], [0, 0], 'Color', 'k');  % X-axis
line([0, 0], ylim, [0, 0], 'Color', 'k');  % Y-axis
line([0, 0], [0, 0], zlim, 'Color', 'k');  % Z-axis

text(-0.05, -0.05, 1.1*amax, '|0\rangle')
text(-0.05, -0.05, -1.1*amax, '|1\rangle')
%text(x(end), y(end), z(end), 'End Point')
hold off
box off
grid off
axis off

% Adjust view angle
view(-45, 30); % (adjust as desired)