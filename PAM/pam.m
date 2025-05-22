clc; clear; close all;

% Parameters
Fs = 1000;                % Sampling frequency in Hz
t = 0:1/Fs:1-1/Fs;        % Time vector of 1 second
fm = 5;                   % Frequency of message signal (Hz)
pulse_width = 0.01;       % Width of each pulse (10 ms)
pulse_period = 0.05;      % Period between pulses (50 ms)

% Message signal (sinusoidal)
m = sin(2*pi*fm*t);

% Generate pulse train: periodic rectangular pulses
pulse_train = zeros(size(t));
samples_per_pulse = round(pulse_width * Fs);
samples_per_period = round(pulse_period * Fs);

for k = 1:samples_per_period:length(t)
    pulse_train(k:min(k+samples_per_pulse-1, length(t))) = 1;
end

% PAM signal = message signal * pulse train
pam_signal = m .* pulse_train;

% Plot the message signal
figure;
plot(t, m,'LineWidth',1.5);
title('Message Signal m(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Plot the pulse train
figure;
plot(t, pulse_train,'LineWidth',1.5);
title('Pulse Train p(t)');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.2]);
grid on;

% Plot the PAM signal
figure;
plot(t, pam_signal,'LineWidth',1.5);
title('PAM Signal s(t)');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.2]);
grid on;

% --- Demodulation ---

% Sample the PAM signal at the center of each pulse
pulse_centers = [];
for k = 1:samples_per_period:length(t)
    idx = k + floor(samples_per_pulse / 2);
    if idx <= length(t)
        pulse_centers = [pulse_centers, idx];
    end
end

% Extract the PAM amplitudes at those pulse centers
sampled_values = pam_signal(pulse_centers);
t_samples = t(pulse_centers);

% Interpolate the signal between the sampled points
reconstructed_message = interp1(t_samples, sampled_values, t, 'linear', 'extrap');

% Low-pass filter to smooth the demodulated signal
cutoff_freq = 2 * fm / Fs;
[b,a] = butter(5, cutoff_freq);
filtered_reconstructed = filtfilt(b,a,reconstructed_message);

% Scale to match original amplitude
scale_factor = max(abs(m)) / max(abs(filtered_reconstructed));
amplitude_corrected = filtered_reconstructed * scale_factor;

% Plot original and demodulated signals
figure;
plot(t, m, 'b', 'LineWidth', 1.5); hold on;
plot(t, amplitude_corrected, 'r--', 'LineWidth', 1.5);
legend('Original Message', 'Demodulated Signal');
title('PAM Demodulation (with Amplitude Matching)');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.5]);
grid on;
