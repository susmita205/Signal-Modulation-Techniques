function pwm_signal = generate_pwm(t, msg, f_pwm)
    % msg must be in range [0, 1], representing duty cycle
    pwm_signal = zeros(size(t));
    T_pwm = 1/f_pwm;
    
    for i = 1:length(t)
        % Current PWM period start
        t0 = floor(t(i) * f_pwm) / f_pwm;
        % Time within the current PWM cycle
        tau = t(i) - t0;
        % Current duty cycle (based on message)
        duty = msg(i);
        if tau < duty * T_pwm
            pwm_signal(i) = 1;
        else
            pwm_signal(i) = 0;
        end
    end
end
