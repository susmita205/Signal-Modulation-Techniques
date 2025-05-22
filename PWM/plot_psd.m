function plot_psd(signal, Fs)
    % Power Spectral Density of demodulated signal using Welch method
    window = hamming(1024);
    nfft = 2048;
    noverlap = 512;

    [Pxx, f] = pwelch(signal, window, noverlap, nfft, Fs);

    % Plot in dB
    figure;
    plot(f, 10*log10(Pxx), 'LineWidth', 1.5);
    xlabel('Frequency (Hz)');
    ylabel('Power/Frequency (dB/Hz)');
    title('PSD of PWM signal');
    grid on;
    xlim([0 Fs/10]);  % Focus on baseband
end
