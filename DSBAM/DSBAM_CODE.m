clc; clear; close all;

f_m=100;
f_c=1000;
A_m=1;
A_c=2;
mI=A_m/A_c; %Modulating Index
f_s=10000;
t = 0:1/f_s:0.035;

c = A_c * cos(2*pi*f_c*t );
m = A_m * cos(2*pi*f_m*t );

s = A_c * (1 + mI*cos(2*pi*f_m*t )).*cos(2*pi*f_c*t );%modulated signal(Conventioanl AM)

figure
plot(t, s, 'b', 'LineWidth', 1.5);
title('DSB-AM Signal (s(t))');
xlabel('Time (s)'); ylabel('Amplitude'); grid on;

n=length(t);
F=fft(s,n);
f= (-n/2:n/2-1) * f_s/n;

figure
%S_f = abs(fftshift(fft(s, n)));
%plot(f, S_f, 'k', 'LineWidth', 1.5);
plot(f, fftshift(abs(F)) , 'b', 'LineWidth', 1.5);
title('Frequency Spectrum of DSB-AM Signal');
xlabel('Frequency (Hz)'); ylabel('Magnitude'); grid on;

figure
PSD = (abs(F)/n).^2 / (f_s/n);
plot(f, 10*log10(fftshift(PSD)), 'b', 'LineWidth', 1.5);
title(" Spectral Power Density ");
xlabel("Frequency (Hz)");
ylabel(" Power/Frequency (dB/Hz) "); grid on


