function demodulated = demodulate_pwm(t, pwm_signal, Fs, f_pwm)
    % Low-pass filter the PWM to extract envelope
    cutoff = f_pwm / 5;  % Should be below PWM carrier, above message
    [b, a] = butter(4, cutoff/(Fs/2));
    demodulated = filtfilt(b, a, pwm_signal);
end
