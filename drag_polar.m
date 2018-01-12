%% INPUT

% Aircraft data
data;

% Polar
N = 100; % points
maxCL = 1.5; % 

%% POLAR

CLs = linspace(-maxCL, +maxCL, N);
CDs = polar(CLs);

%% PLOT

figure;

plot(CLs, CDs);

grid('on');
xlabel('$$C_L$$', 'Interpreter', 'latex');
ylabel('$$C_D$$', 'Interpreter', 'latex');
