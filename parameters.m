%% INPUT

% Aircraft data
data;

% Integration
N = 100; % steps

% Parameters
P = 100; % iterations

%% SOLVE

% sfc
sfcs = linspace(sfc * 0.5, sfc * 1.5, P);
m_sfc = zeros(1, P);
for k = 1:P
    m_sfc(k) = breguet(R, M, h, m, sfcs(k), S, polar, N);
end

% CD0
CD0s = linspace(CD0 * 0.5, CD0 * 1.5, P);
m_CD0 = zeros(1, P);
for k = 1:P
    polars = @(CL) CD0s(k) + CL^2 / (pi * A * phi);
    m_CD0(k) = breguet(R, M, h, m, sfc, S, polars, N);
end

% phi
phis = linspace(phi * 0.5, phi * 1.5, P);
m_phi = zeros(1, P);
for k = 1:P
    polars = @(CL) CD0 + CL^2 / (pi * A * phis(k));
    m_phi(k) = breguet(R, M, h, m, sfc, S, polars, N);
end

% h
hs = linspace(h * 0.5, 12500, P);
m_h = zeros(1, P);
for k = 1:P
    m_h(k) = breguet(R, M, hs(k), m, sfc, S, polar, N);
end

% M
Ms = linspace(M * 0.5, 0.82, P);
m_M= zeros(1, P);
for k = 1:P
    m_M(k) = breguet(R, Ms(k), h, m, sfc, S, polar, N);
end

%% PLOT

% sfc
figure;

plot(sfcs * 1e6, m_sfc / 1000);

grid('on');
xlabel('Specific Fuel Consumption [g/(kN$\cdot$s)]', 'Interpreter', 'latex');
ylabel('Final Weight [1000 kg]', 'Interpreter', 'latex');

% CD0 + phi
figure;
grid('on');
xlabel('Final Weight [1000 kg]', 'Interpreter', 'latex');

yyaxis left;
plot(m_CD0 / 1000, CD0s);
ylabel('$$C_{D_0}$$', 'Interpreter', 'latex');

yyaxis right;
plot(m_CD0 / 1000, phis);
ylabel('$$\varphi$$', 'Interpreter', 'latex');

% h
figure;
hold('on');

[mv, mi] = max(m_h);
plot(hs, m_h / 1000);
plot(hs(mi), mv / 1000, 'kx');

grid('on');
xlabel('Altitude [m]', 'Interpreter', 'latex');
ylabel('Final Weight [1000 kg]', 'Interpreter', 'latex');

% M
figure;

plot(Ms, m_M / 1000);

grid('on');
xlabel('Cruise Mach', 'Interpreter', 'latex');
ylabel('Final Weight [1000 kg]', 'Interpreter', 'latex');
