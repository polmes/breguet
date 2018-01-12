%% INPUT

% Aircraft data
data;

% Integration
N = 100; % steps

%% SOLVE

[m_final, ms, t_flight] = breguet(R, M, h, m, sfc, S, polar, N);

%% FINAL VALUES

disp(['Final Weight: m = ' num2str(m_final) ' kg']);
disp(['Time of Flight: t = ' num2str(t_flight / 3600) ' h']);

%% PLOT EVOLUTION

figure;

ts = linspace(0, t_flight / 3600, N + 1);
plot(ts, ms / 1000);

grid('on');
xlabel('Time [h]', 'Interpreter', 'latex');
ylabel('Weight [1000 kg]', 'Interpreter', 'latex');
