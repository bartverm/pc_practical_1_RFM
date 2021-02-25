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

%% Roughness transition
clearvars
B(2)=Backwater; % create two backwater objects
[B(:).So]=deal(5e-3); % set the slope for the two reaches
B(1).Chez=65; % set roughness for upstream reach
B(2).Chez=55; % set roughness for downstream reach
B(1).a0=B(1).a_equilibrium; % Set the downstream reach to equilibrium
B(1).x_end=200; % Set end of computation to positive 
B(2).x0=B(1).x_end; % Set start of downstream reach to match end of upstream reach
B(2).a0=B(1).a_equilibrium; % Set bounday condition of donwstream reach to equilibrium depth of upstream end
B(2).x_end=B(2).x_target; % Set the end of the downstream reach to the estimated end of the backwater
B(2).zb0=B(1).bed_level(end); % Adjust the inital bed level of the downstream reach
plot(B) % plot the backwater objects

%% Change of slope
clearvars
B(2)=Backwater; % create two backwater objects
[B(:).Chez]=deal(40); % set the roughness for the two reaches
B(1).So=2e-3; % set slope for upstream reach
B(2).So=5e-3; % set slope for downstream reach
B(2).x_end=-800; % set a suitable scale
B(2).a0=B(2).a_equilibrium; % Set the downstream reach to equilibrium
B(1).x0=B(2).x_end; % Set start of upstream reach to match end of downstream reach
B(1).a0=B(2).a_equilibrium; % Set bounday condition of upstream end to equilibrium depth of downstream end
B(1).x_end=B(1).x_target; % Set the end of the upstream reach to the estimated end of the backwater
B(1).zb0=B(2).bed_level(end); % Adjust the inital bed level of the upstream reach
plot(B) % plot the backwater objects

%% Change of slope steep
clearvars
B(2)=Backwater; % create two backwater objects
[B(:).Chez]=deal(75); % set the roughness for the two reaches
B(1).So=2e-3; % set slope for upstream reach
B(2).So=5e-3; % set slope for downstream reach
B(1).a0=B(1).a_equilibrium; % Set the downstream reach to equilibrium
B(1).x_end=400; % set a suitable scale
B(2).x0=B(1).x_end; % Set start of upstream reach to match end of downstream reach
B(2).a0=B(1).a_equilibrium; % Set bounday condition of upstream end to equilibrium depth of downstream end
B(2).x_end=B(2).x_target; % Set the end of the upstream reach to the estimated end of the backwater
B(2).zb0=B(1).bed_level(end); % Adjust the inital bed level of the upstream reach
plot(B) % plot the backwater objects

