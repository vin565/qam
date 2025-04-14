clc;
clear;
close all;

%% Parameters
M = 16;                   % Order of QAM (e.g., 16-QAM)
Fs = 1000;                % Sampling frequency (Hz)
t = (0:1/Fs:0.1)';        % Time vector (0 to 0.1 seconds)

%% Input Signal (Sine Wave)
messageSignal = sin(2*pi*50*t); % 50 Hz sine wave

%% QAM Modulation
data = floor((messageSignal + 1) * (M-1)/2); % Normalize and quantize sine wave
modulatedSignal = qammod(data, M);          % QAM modulation

%% Add Noise
SNR = 20; % Signal-to-Noise Ratio in dB
noisySignal = awgn(modulatedSignal, SNR, 'measured'); % Add white Gaussian noise

%% QAM Demodulation
demodulatedData = qamdemod(noisySignal, M); % QAM demodulation
Demodulated = 2 * demodulatedData / (M-1) - 1; % Reconstruct sine wave

%% Visualization
figure;

% Input Signal
subplot(3, 1, 1);
plot(t, messageSignal, 'b');
title('Input Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Modulated Signal (Real Part)
subplot(3, 1, 2);
plot(t, real(modulatedSignal), 'r');
title('QAM Modulated Signal (Real Part)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Demod
subplot(3, 1, 3);
plot(t, Demodulated, 'g');
title('Demodulated');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
