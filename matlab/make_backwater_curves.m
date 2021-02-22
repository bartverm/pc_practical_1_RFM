B=Backwater;

%% The default curve is M2
B.x_end=B.x_target; plot(B);

%% We modify the boundary condition to create M1. We make a0 larger than
% a_equilibrium. The scale of this 
B.a0=8;
B.x_end=B.x_target; figure; plot(B)

%% make a0 smaller than a_critical for an M3
B.a0=1.5;
B.x_end=B.x_target; figure; plot(B)

%% We make a critical slope and obtain a C3 curve:
B.So=B.Sc;
B.x_end=B.x_target; figure; plot(B)

%% We make a C1 curve
B.a0=3;
B.x_end=B.x_target; figure; plot(B)

%% We create a steep slope (>Sc), resulting in an S1
B.So=0.007;
B.x_end=B.x_target; figure; plot(B)

%% We make an S2 (a_e< a0 < a_c )
B.a0=2;
B.x_end=B.x_target; figure; plot(B)

%% We make and S3 (a0 < ae)
B.a0=1;
B.x_end=B.x_target; figure; plot(B)

%% We make an H slope resulting in an H2
B.So=0;
B.x_end=B.x_target; figure; plot(B)

%% We make an H1 setting a0>ac
B.a0 = 3;
B.x_end=B.x_target; figure; plot(B)

%% We make an A2 setting a negative slope
B.So=-0.05;
B.x_end=B.x_target; figure; plot(B)

%% We make an A3 setting a negative slope
B.a0=1;
B.x_end=B.x_target; figure; plot(B)


