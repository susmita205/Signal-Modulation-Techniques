clc;
clear;
close all;

% Parameters
fs = 1000;        % Sampling frequency (Hz)
T = 1;            % Signal duration (seconds)
t = 0:1/fs:T;     % Time vector
N = length(t);    % Number of samples

fm = 10;          % Message signal frequency (Hz)
fc = 100;         % Carrier frequency (Hz)
kf = 40;          % Frequency sensitivity
Am = 1;           % Amplitude of message signal

% Message signal (cosine wave)
m = Am * cos(2 * pi * fm * t);

% Integrate the message signal for FM phase term
phi = 2 * pi * kf * cumsum(m) / fs;  % Numerical integration

% Frequency Modulated (FM) signal
f_m = cos(2 * pi * fc * t + phi);

% FFT of FM signal
f_ft = fft(f_m, N);
f = (-N/2:N/2-1) * (fs/N);           % Frequency axis
f_ft_shift = fftshift(f_ft);        % Shift zero frequency to center
fft_v = abs(f_ft_shift);            % Magnitude spectrum

% Spectral Power Density (in linear scale)
spd = abs(f_ft_shift).^2 / (N * fs);

% Convert to Decibel (dB) scale
spd_dB = 10 * log10(spd);

% Plot Message Signal
figure;
plot(t, m, 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Message Signal (Cosine Wave)');
grid on;

% Plot FM Signal
figure;
plot(t, f_m, 'r', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Frequency Modulated (FM) Signal');
grid on;

% Plot Power Spectral Density
figure;
plot(f, spd_dB, 'm', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Power (dB/Hz)');
title('Power Spectral Density of FM Signal');
grid on;
