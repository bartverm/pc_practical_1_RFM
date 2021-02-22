% clean the workspace
clearvars
close all % close all figures

% Set parameters
So = 1e-4; % define bed slope
L = 2e3; % define length of the river

% Compute bed level
x = [0 L]; % x vector
z_b = -So*x; % compute bed elevation (- since So = -dz/dx)

% Plot the bed level
plot(x, z_b, 'k-', 'Linewidth', 2) % plot black line 2pt thick

% Add some eye-candy
xlabel('x (m)') % set the x-axis label
ylabel('z (m)') % set the y-axis label
legend('River bed') % set the legend
