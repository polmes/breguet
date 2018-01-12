function [m_final, ms, t_flight]  = breguet(R, M, h, m, sfc, S, polar, N)
    %% INIT

    % Universal
    g = 9.80665; % [m/s^2]

    % Air
    gamma_air = 1.4;
    r_air = 287; % [J/(kg*K)]

    % ISA
    T_0 = 288.15; % [K]
    rho_0 = 1.225; % [kg/m^3]
    k_isa = 6.5e-3;
    T_h = T_0 - k_isa * h;
    rho = rho_0 * (T_h/T_0)^(g/(k_isa * r_air) - 1);

    % Speed of sound
    a = sqrt(gamma_air * r_air * T_h);

    % Variables
    v = M * a; % constant speed
    Wi = m * g;
    Isp = 1 / (g * sfc);

    %% SOLVE

    t_flight = R / v;
    dt = t_flight / N;
    W = Wi;
    
    % Array of weights
    ms = zeros(1, N + 1);
    ms(1) = Wi;
    
	% while t < t_flight
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
        ms(i + 1) = W;
    end

    m_final = W / g;
    ms = ms / g;
end
