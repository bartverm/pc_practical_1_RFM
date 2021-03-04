%% Cleaning the workspace
restoredefaultpath
clearvars
close all
addpath ~/src/backwater/

%% Setting parameters
Q=0.025;
b=0.405;
C=50;
So=0;
L_flume=5;
weir_level=0.05; % level over which the water has to flow downstream
undershot_height=0.03; % level under which the water has to flow upstream

%% Set parameters
R(2)=Backwater; % create two Backwater objects (first is upstream second is downstream backwater)
[R.Q]=deal(Q); 
[R.b]=deal(b);
[R.Chez]=deal(C);
[R.So]=deal(So);
[R.bed_offset]=deal(0.02);

%% Initial computation over entire flume
% set start and end of computation and boundary condition for downstream part
R(2).x0=L_flume; % computation starts downstream for subcritical case
R(2).a0=weir_level+R(2).a_critical; % set downstream bc at weir level plus critical depth (free overflow)
R(2).x_end=0; % set end of computation (we will compute backwater over entire flume)

% set start and end of computation and boundary condition for upstream part
R(1).x0=0; % computation starts upstream in supercritical case
R(1).a0=undershot_height; % set depth at undershot height
R(1).x_end=L_flume; % computation stops at end of flume (compute this backwater also over entire flume)
R(1).zb0=R(2).bed_level(2); % set correct bed level

%% Plot initial situation
figure % new figure
ax(2)=subplot(2,1,1); % create a subplot on a 2x1 grid and select the first plot
R(1).plot % plot the backwater
hold on % Make sure next plots (undershot gate) is added to the plot
title('Supercritical curve') % give the plot a title
ax(1)=subplot(2,1,2); % select the second plot
R(2).plot % plot the subcritical curve
title('Subcritical curve') % give a title to the plot
linkaxes(ax,'xy') % make sure two plots have same axes limits
hold on % make sure next plot (weir) is added to the plot
plot(ax(2), ax(2).XLim(1)*[1 1], [undershot_height ax(2).YLim(2)],'k','Linewidth',4); % plot undershot gate
plot(ax(1), ax(1).XLim(2)*[1 1], [-R(1).bed_offset weir_level],'k','Linewidth',4); % plot weir

%% Localize hydraulic jump
[x1,a1]=R(1).solve(); % solve upstream backwater curve (at x with depth a)
froude2=R(1).Q^2/R(1).g/R(1).b^2./a1.^3; % compute fr^2 for hydraulic jump formula
a1_jump=a1/2.*(sqrt(1+8*froude2)-1); % compute depth at which water would jump from upstream depth and froude number

[x2,a2]=R(2).solve(); % solve downstream backwater curve (note that this is solved at different locations as first backwater)

% Interpolate the depths either to locations us or ds curve
if numel(x2)>numel(x1) % if ds curve has more points than us curve interpolate to ds curve
    xint=x2;
    a1_jump=interp1(x1,a1_jump,xint); % check matlab's help to understand this interpolation function (help interp1)
else % otherwise interpolate to us curve
    xint=x1;
    a2=interp1(x2,a2,xint);
end

% jump is where the predicted jump depth from us curve matches ds curve
adiff=a2-a1_jump; % this is ds depth minus jump depth. Hydraulic jump will occur when this is 0

if all(adiff>0) % if ds depth is larger than jump depth everywhere ds weir is too high, i.e. there will be no jump, only subcritical flow
    R(1).x_end=R(1).x0;
elseif all(adiff<0) % if ds depth is smaller than jump depth everywere, ds weir is too low, i.e there will be no jump, only supercritical flow
    R(2).x_end=R(2).x0;
else
    id_jump=find(diff(adiff>0)~=0); % find the jump location
    if numel(id_jump)~=1 % if more than one jump is found... 
        error('something is wrong here') % this should not happen, check your settings.
    end
    x_jump=xint(id_jump)-(xint(id_jump+1)-xint(id_jump))/(adiff(id_jump+1)-adiff(id_jump))*adiff(id_jump); % compute the exact location where adiff is 0
    [R.x_end]=deal(x_jump); % set this as ending location for us and ds backwater computation
end


%% Plot result
plot(R) % plot backwaters
hold on

% plot undershot gate and weir
plot(R(2).x0*[1 1], [ylim*[1; 0] R(2).bed_level(1)+weir_level],'k-','linewidth',2)
plot(R(1).x0*[1 1], [R(1).bed_level(1)+undershot_height ylim*[0; 1]],'k-','linewidth',2)
