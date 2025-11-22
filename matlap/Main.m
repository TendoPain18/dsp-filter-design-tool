function result = Main(method, length, window, Desired_Points, weights, Scale, cutoff)
    clc;
    close all;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% 1- audioread %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [audioSignal, fs] = audioread('input.wav');
    disp('Audio file loaded successfully.');
    if size(audioSignal, 2) > 1
        audioSignal = audioSignal(:, 1);
    end
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%% 2- upsample %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    upsampleFactor = 2;
    upsampledSignal = resample(audioSignal, upsampleFactor, 1);
    disp('Audio signal upsampled successfully.');

    %%%%%%%%%%%%%%%%%%% 3- Plot the frequency spectrum %%%%%%%%%%%%%%%%%%%%
    figure;
    [originalFreqResponse, fOriginal] = freqz(audioSignal, 1, 1024, fs);
    plot(fOriginal, abs(originalFreqResponse));
    title('Frequency Spectrum of Original Audio Signal');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([0, 0.7e4]);
    grid on;

    figure;
    [upsampledFreqResponse, fUpsampled] = freqz(upsampledSignal, 1, 1024, fs * upsampleFactor);
    plot(fUpsampled, abs(upsampledFreqResponse));
    title('Frequency Spectrum of Upsampled Audio Signal');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([0, 0.7e4]);
    grid on;
   
    %%%%%%%%%%%%%%% 4- Add a sinusoidal interference signal %%%%%%%%%%%%%%% 
    interferenceFrequency = 5000; % Select a frequency outside the useful range
    L = size(upsampledSignal);
    L_arr = 0:L-1;
    t = (L_arr) / (fs * upsampleFactor);
    interferenceSignal1 = 1 * sin(2 * pi * 5000 * t)';
    interferenceSignal2 = 1 * cos(2 * pi * 4000 * t)';
    interferenceSignal3 = 1 * sin(2 * pi * 6000 * t)';
    interferenceSignal4 = 1 * cos(2 * pi * 4500 * t)';
    interferenceSignal5 = 1 * sin(2 * pi * 5500 * t)';
    interferenceSignal = interferenceSignal1 + interferenceSignal2 + interferenceSignal3 + interferenceSignal4 + interferenceSignal5;
    audioWithInterference = upsampledSignal + interferenceSignal;

    figure;
    plot( t, audioWithInterference, 'g', t, interferenceSignal, 'r', t, upsampledSignal, 'b');
    title('Audio Signal and Interference Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Audio With Interference', 'Interference Signal', 'Audio');
    grid on;

    %%%% 5- Plot the frequency spectrum after adding the interference. %%%%
    figure;
    [interferenceFreqResponse, fInterference] = freqz(audioWithInterference, 1, 1024, fs * upsampleFactor);
    plot(fInterference, abs(interferenceFreqResponse));
    title('Frequency Spectrum of Audio Signal with Interference');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([0, 0.7e4]);
    grid on;

    %%%%%%%%%%%%%%%%%%%% 6- Listen to the audio signal %%%%%%%%%%%%%%%%%%%%
    % sound(audioWithInterference, fs * upsampleFactor);
    % pause(length(audioWithInterference) / (fs * upsampleFactor));

    %%%%%%%%%%%%%%%%%%% 7- Design a digital FIR filter %%%%%%%%%%%%%%%%%%%%
    if strcmp(method, "Windowed sinc")
        Filter = WindowedSync(length, window, cutoff, Scale);
    elseif strcmp(method, "LS")
        Filter = LC(length, Desired_Points, cutoff, Scale);
    elseif strcmp(method, "WLC")
        Filter = WLC(length, Desired_Points, cutoff, weights, Scale);
    else
        error('Invalid filter design method selected.');
    end
    disp('Filter designed successfully.');

    %%%%%%%%%%%%%%%%%%%%% 8- Filter the audio signal %%%%%%%%%%%%%%%%%%%%%%
    filteredSignal = filter(Filter, 1, audioWithInterference);
    filteredSignal = filter(Filter, 1, filteredSignal);
    filteredSignal = filter(Filter, 1, filteredSignal);

    disp('Audio signal filtered successfully.');

    %%%%%%%%%%% 9- Plot the frequency spectrum after filtering. %%%%%%%%%%%
    figure;
    [filteredFreqResponse, fFiltered] = freqz(filteredSignal, 1, 1024, fs * upsampleFactor);
    plot(fFiltered, abs(filteredFreqResponse));
    title('Frequency Spectrum of Filtered Audio Signal');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([0, 0.7e4]);
    grid on;

    %%%%%%%%%% 10- Listen to the audio signal after filtering. %%%%%%%%%%%%
    audiowrite("output1.wav", filteredSignal, fs*upsampleFactor);
    % sound(filteredSignal, fs * upsampleFactor);
    % pause(length(filteredSignal) / (fs * upsampleFactor));

    result = filteredSignal; % Return the filtered signal for further processing if needed


end
