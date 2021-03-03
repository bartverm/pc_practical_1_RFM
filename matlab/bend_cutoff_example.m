close all
restoredefaultpath
clearvars

addpath ~/src/backwater/

%% Setup initial situation
B(3)=Backwater; % three backwater object for the three reaches
[B(:).Chez]=deal(50); % set the roughness for the three reaches
[B(:).So]=deal(1e-4); % set the slope
[B(:).b]=deal(200); % set the width
[B(:).Q]=deal(1118); % set the discharge
B(3).x0=0; % Downstream reach start (notice downstream to upstream reasoning for subcritical flow)
B(3).x_end=-5000; % Downstream reach end
B(2).x0=B(3).x_end; % Middle reach start
B(2).x_end=B(3).x_end-10000; % Middle reach end 
B(1).x0=B(2).x_end; % Upstream reach start
B(1).x_end=B(2).x_end-10000; % Upstream reach end
B(3).zb0=0; % Bed elevation at downstream reach
B(2).zb0=B(3).bed_level(end); % Bed elevation at downstream end of middle reach
B(1).zb0=B(2).bed_level(end); % Bed elevation at downstream end of upstream reach
[B(:).a0]=deal(B(1).a_equilibrium); % Set all to equilibrium for initial situation
plot(B) % plot the initial situation

%% Shorten middle reach (bend cut_off) and adapt slope
B(2).So=2*B(2).So; % change the slope
B(2).x_end=B(2).x0-5e3; % shorten the middle reach
B(1).x0=B(1).x0+5e3; % move upstream reach downstream
B(1).x_end=B(1).x_end+5e3; % move upstream reach downstream
[x,a]=B(2).solve;
B(1).a0=a(end); % set the correct bc. for upstream part
plot(B) % plot the new situation

%% Get depth at upstream end of cutoff and at the upstream end of upstream reach
hP=B(2).a0; % Extract depth at downstream end of cutoff
[~,a]=B(2).solve; % Get depth in middle reach
hR=a(end); % Extract depth at most upstream point

%% plot the initial erosion and sedimentation
figure % new figure
B.plot_initial_ersed() % plot the initial erosion and sedimentation

%% plot the morphological equilibrium
[B(:).qs_morf_eq]=deal(B(1).m_sed_transp*B(1).u_equilibrium.^B(1).n_sed_transp); % set the right sed transport matching the initial equilibrium flow
figure % create a new figure
B.plot_morf_equilibrium % plot morphological equilibrium

