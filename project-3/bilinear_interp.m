function p_interp = bilinear_interp(image, x, y)
% Computes the bilinear interpolation of x, y on the image
% NOTE: this function has the invariant that the inputs are positive

% Set some variables that will be used
x_floor = floor(x);
x_ceil = ceil(x);
x_under = mod(x, 1);
x_over = 1 - x_under;

y_floor = floor(y);
y_ceil = ceil(y);
y_under = mod(y, 1);

% Bilinear interpolation
R1 = x_over*image(y_floor, x_floor) + x_under*image(y_floor, x_ceil);
R2 = x_over*image(y_ceil, x_floor) + x_under*image(y_ceil, x_ceil);
p_interp = (1 - y_under)*R1 + y_under*R2;

end