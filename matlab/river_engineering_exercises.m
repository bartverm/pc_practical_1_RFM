restoredefaultpath
clearvars
close all
addpath ~/src/backwater/

%% Roughness transition
B(2)=Backwater; % create two backwater objects
[B(:).So]=deal(1e-4); % set the slope for the two reaches
B(1).Chez=65; % set roughness for upstream reach
B(2).Chez=55; % set roughness for downstream reach
B(2).a0=B(2).a_equilibrium; % Set the downstream reach to equilibrium
B(1).x0=B(2).x_end; % Set start of upstream reach to match end of downstream reach
B(1).a0=B(2).a_equilibrium; % Set bounday condition of upstream end to equilibrium depth of downstream end
B(1).x_end=B(1).x_target; % Set the end of the upstream reach to the estimated end of the backwater
B(1).zb0=B(2).bed_level(end); % Adjust the inital bed level of the upstream reach
plot(B) % plot the backwater objects