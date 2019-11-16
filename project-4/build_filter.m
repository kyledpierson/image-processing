function H = build_filter(size_y, size_x, D, n)
% Builds a filter of the given size, using D as the frequency cutoff, and n
% as the exponent to the denominator of the Butterworth

y = size_y/2;
x = size_x/2;

% Build filter at center of image
H = zeros(size_y, size_x);
for i = 1:size_y
    for j = 1:size_x
        Duv = sqrt((i-y)^2+(j-x)^2);
        
        % Ideal low pass
        % if Duv < D
        % H(i, j) = 1;
        % end
        
        % Butterworth
        H(i, j) = 1/(1+(Duv/D)^(2*n));
    end
end

% Relocate origin at corners
top_left = H(y+1:end, x+1:end);
top_right = H(y+1:end, 1:x);
bottom_left = H(1:y, x+1:end);
bottom_right = H(1:y, 1:x);

H = [top_left top_right; bottom_left bottom_right];
