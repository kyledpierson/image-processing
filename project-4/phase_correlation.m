function p = phase_correlation(image_1, image_2, ratio, n)
% Computes the phase correlation between two images, filtering using the
% frequency ratio an n

F = fft2(image_1);
G = fft2(image_2);

[y, x] = size(image_1);
D = ((y + x) / 2) * ratio;
H = build_filter(y, x, D, n);

FG = F .* conj(G);
HFG = H .* (FG ./ abs(FG));

p = real(ifft2(HFG));
end