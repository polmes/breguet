%% INIT

% A320ceo (CFM56-7B18 engines)
R = 6100e3; % nominal range [m]
M = 0.78; % cruise Mach
h = 11900; % ceiling [m]
m = 78000; % MTOW [kg]
sfc = 14e-6; % specific fuel consumption [kg/(N*s)]
S = 124; % wing surface area [m^2]
polar = @(CL) 0.02 + CL^2 / (pi * 35.8^2/S * 0.8); % CD = f(CL) (will be pchip)

% Integration
N = 1000; % steps

% Universal
g = 9.80665; % [m/s^2]

% Air
gamma_air = 1.4;
r_air = 287; % [J/(kg*K)]

% ISA
T_0 = 288.15; % [K]
rho_0 = 1.225; % [kg/m^3]
T_h = T_0 - 6.5e-3 * h;
rho = rho_0 * (T_h/T_0)^(g/(6.5e-3 * r_air) - 1);

% Speed of sound
a = sqrt(gamma_air * r_air * T_h);

% Variables
v = M * a; % constant speed
Wi = m * g;
Isp = 1 / (g * sfc); % n (# of engines) * sfc?

%% SOLVE

t_flight = R / v;
dt = t_flight / N;
W = Wi;

t = 0;
for i = 1:N
    % Flight Mechanics
    L = W;
    CL = (2 * L) / (rho * v^2 * S);
    CD = polar(CL);
    D = 1/2 * rho * v^2 * S * CD;
    T = D;
    
    % Reduction in weight
    dW = dt * T / Isp;
    W = W - dW;
    
    t = t + dt;
end

m_final = W / g;

%% PLOT

disp(['Final Weight: m = ' num2str(m_final) ' kg']);

%%% TODO
% Get real aircraft data
% Plot m_final convergence with increasing N (along error)
% Change Isp and L/D parameters to see changes in solution
