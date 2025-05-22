%phase modulation 
%continous singal 

Am=5;
Ac=5;

fm=20;
fc=100;

fs=10000;
t=0:1/fs:1;
kp=pi/2;

mt=Am*sin(2*pi*fm*t);            %for PM modulation it is better to use sin wave than cos function for better representation 
ct=Ac*sin(2*pi*fc*t);

pm_t=Ac*sin(2*pi*fc*t+kp*mt);

% Compute FFT
N = length(pm_t);                % Number of points
Y = fft(pm_t, N);                % Compute FFT
Y_mag = abs(Y)/N;              % Normalize magnitude
f = (-N/2:N/2-1) * (fs/N);       % Frequency axis (centered)

% Shift FFT for better visualization
Y_shifted = fftshift(Y_mag); 

Pxx = (abs(Y).^2) / (N * fs);          % Power Spectral Density (PSD)
Pxx_shifted = fftshift(Pxx);           % Shift PSD for centering at 0 Hz



%subplot(5,1,1)
figure(1)
plot(t,mt);
title('message signal');
xlabel("time");
ylabel('amplitude');

%subplot(5,1,2)
figure(2)
plot(t,ct);
title('carrier signal');
xlabel('time');
ylabel('amplitude');

%subplot(5,1,3)
figure(3)
plot(t,pm_t);
title('phase modulated signal');
xlabel('time');
ylabel('amplitude');

%subplot(5,1,4)
figure(4)
plot(f, Y_shifted, 'm');
title('Frequency Spectrum of Phase Modulated Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
xlim([-2*fc 2*fc]); % Focus on important frequency range

%subplot(5,1,5)
figure(5)
plot(f, 10*log10(Pxx_shifted), 'm');   % Convert to dB scale
title('Power Spectral Density (PSD) of PM Signal using FFT');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
grid on;
xlim([-2*fc 2*fc]); 

