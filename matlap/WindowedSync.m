function Filter = WindowedSync(length, windowType, cutoff_frq, Scale)
    fc = cutoff_frq;
    N = (length -1) / 2; % Ensure the length matches symmetry
    i = -N:N; % Indices for Sinc signal
    Sinc_Signal = 2 * fc * sinc(2 * fc * i);

    switch windowType
        case 'Rectangular'
            window = ones(1, length); 
        case 'Blackman'
            n = 0:(length - 1);
            window = 0.42 - 0.5 * cos(2 * pi * n / (length - 1)) + 0.08 * cos(4 * pi * n / (length - 1));
        case 'Chebyshev'
            ripple = 100;
            window = chebwin(length, ripple)';
        case 'Kaiser'
            beta = 5;
            window = kaiser(length, beta)';
        otherwise
            error('Invalid window type. Choose Rectangular, Blackman, Chebyshev, or Kaiser.');
    end

  
    Filter = Sinc_Signal .* window;

  
    switch Scale
        case 'Linear Scale'
            Filter = Filter / sum(Filter);
        case 'Log Scale'
            Filter = log10(abs(Filter));
        otherwise
            error('Invalid Scale type. Use "linear" or "log".');
    end

    % Compute DTFT
    fft_points = 1024;
    freq = linspace(-0.5, 0.5, fft_points);
    DTFT_Magnitude = abs(fft(Filter, fft_points));
    DTFT_Magnitude = fftshift(DTFT_Magnitude);

    % Plot the results
    figure;

    subplot(2, 1, 1);
    if strcmpi(Scale, 'Linear Scale')
        plot(freq, DTFT_Magnitude / max(DTFT_Magnitude));
        title('Magnitude Spectrum (Linear Scale)');
    elseif strcmpi(Scale, 'Log Scale')
        semilogy(freq, DTFT_Magnitude);
        title('Magnitude Spectrum (Logarithmic Scale)');
    end
    xlabel('Normalized Frequency');
    ylabel('Magnitude');

    subplot(2, 1, 2);
    stem(0:length-1, Filter, 'filled');
    title('Filter Coefficients');
    xlabel('Sample Index');
    ylabel('Coefficient Value');
end
