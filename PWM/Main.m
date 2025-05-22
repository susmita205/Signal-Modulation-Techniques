clc;
clear;

% Parameters
Fs = 1e5;                  % Sampling frequency
duration = 0.05;           % Signal duration in seconds
t = 0:1/Fs:duration;

% Message signal (e.g., 10 Hz sine wave)
f_msg = 10;
msg = 0.5 * sin(2*pi*f_msg*t) + 0.5;  % Normalize between 0 and 1

% PWM carrier frequency
f_pwm = 1000;

% Step 1: Generate PWM signal with modulated duty cycle
pwm_signal = generate_pwm(t, msg, f_pwm);

% Step 2: Plot PWM signal
figure;
plot(t(1:2000), pwm_signal(1:2000), 'Color', [0.2 0.2 0.8], 'LineWidth', 1.2);  % Navy blue
xlabel('Time (s)');
ylabel('Amplitude');
title('PWM Signal (Modulated Duty Cycle)');% modulating the duty cycle — changing it dynamically based on the amplitude of your input (message) signal.
xlim([t(1), t(2000)]);
ylim([-0.2, 1.2]);
grid on;
set(gca, 'FontSize', 12);

% Step 3: PSD of PWM signal
plot_psd(pwm_signal, Fs);

% Step 4: Demodulate the PWM signal
demodulated = demodulate_pwm(t, pwm_signal, Fs, f_pwm);

% Step 5: Plot message vs demodulated signal
figure;
plot(t, msg, 'b', 'LineWidth', 1.5); hold on;
plot(t, demodulated, 'r--', 'LineWidth', 1.2);
xlabel('Time (s)'); ylabel('Amplitude');
title('Original Message vs Demodulated Signal');
legend('Original Message', 'Demodulated');
grid on;

