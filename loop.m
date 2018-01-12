%% INPUT

% Aircraft data
data;

% Integration
N_min = 1; % min steps
N_max = 100; % max steps
N_tot = 100; % total number of step iterations
N = linspace(N_min, N_max, N_tot); % array of steps

%% SOLVE

m_final = zeros(1, N_tot);
for k = 1:N_tot
    m_final(k) = breguet(R, M, h, m, sfc, S, polar, N(k));
    disp(['Final Weight: m = ' num2str(m_final(k)) ' kg']);
end

%% PLOT

figure;
grid('on');
xlabel('Integration steps', 'Interpreter', 'latex');

yyaxis left;
plot(N, m_final / 1000);
ylabel('Final Weight [1000 kg]', 'Interpreter', 'latex');

yyaxis right;
plot(N, 100 * abs(m_final - m_final(end)) / m_final(end));
ylabel('Integration error [\%]', 'Interpreter', 'latex');
