function f_images = filter_images(images, ratio, n)
% Filters the cell array of input images according to the frequency ratio
% (an n value for the Butterworth, if used).

num_images = length(images);
f_images = cell(1, num_images);

for i = 1:num_images
    [y, x] = size(images{i});
    D = ((y + x) / 2) * ratio;
    
    F = fft2(images{i});
    H = build_filter(y, x, D, n);
    FH = F .* H;
    f_images{i} = real(ifft2(FH));
end
end