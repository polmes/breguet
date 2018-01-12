%% INPUT

% A320neo (CFM LEAP-1A engines)
R = 6228e3; % range [m]
M = 0.78; % cruise Mach
h = 11900; % ceiling [m]
m = 79000; % MTOW [kg]
sfc = 12e-6; % specific fuel consumption [kg/(N*s)]
S = 124; % wing surface area [m^2]
b = 35.80; % wingspan [m]
A = b^2/S; % aspect ratio

% Polar
CD0 = 0.020; % high-subsonic jet aircraft
phi = 0.75; % efficiency
polar = @(CL) CD0 + CL.^2 / (pi * A * phi); % CD = f(CL)
