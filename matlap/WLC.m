function Filter = WLC(length, Desired_Points, omega_cutoff, weights_array, Scale)
    L = (length - 1) / 2;
    k = Desired_Points;
    omega = linspace(0, pi, k);
    omega_c = omega_cutoff;
    H_d = ones(k, 1);
    H_d(omega > omega_c) = 0;

    F = zeros(k, L + 1);
    for i = 1:k
        F(i, 1) = 1;
        for j = 2:L + 1
            F(i, j) = 2 * cos(omega(i) * (j - 1));
        end
    end

    w_pass = weights_array(1);
    w_trans = weights_array(2);
    w_stop = weights_array(3);

    weights = ones(size(omega));
    weights(omega <= omega_c - 0.1) = w_pass;
    weights((omega > omega_c - 0.1) & (omega <= omega_c + 0.1)) = w_trans;
    weights(omega > omega_c + 0.1) = w_stop;

    W = diag(weights);
    h = pinv(W * F) * (W * H_d);
    h_combined = [flip(h(2:end)); h];

    freq = linspace(0, pi, k);
    H = abs(freqz(h_combined, 1, freq));

    figure;
    subplot(3, 1, 1);
    if strcmpi(Scale, 'Linear Scale')
        plot(freq, H);
        title('Magnitude Spectrum (Linear Scale)');
        xlabel('Frequency (rad/sample)');
        ylabel('Magnitude');
    elseif strcmpi(Scale, 'Log Scale')
        semilogy(freq, H);
        title('Magnitude Spectrum (Logarithmic Scale)');
        xlabel('Frequency (rad/sample)');
        ylabel('Magnitude (Log Scale)');
    else
        error('Invalid scale. Use "Linear Scale" or "Log Scale".');
    end

    subplot(3, 1, 2);
    stem(0:length-1, h_combined, 'filled');
    title('Filter Coefficients (h\_combined)');
    xlabel('Sample Index');
    ylabel('Coefficient Value');

    subplot(3, 1, 3);
    plot(omega, H_d, 'r--', 'LineWidth', 2);
    title('Desired Frequency Response (H\_d)');
    xlabel('Frequency (rad/sample)');
    ylabel('Magnitude');

    Filter = h_combined;
end
