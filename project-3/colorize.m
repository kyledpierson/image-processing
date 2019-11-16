function colorized_image = colorize(gray_image, color_image)
% Splits a color image up into its channels, matches the gray image to the
% histogram of each of the channels, and then returns the combined 3
% matched channels as a colorized image.
gray_transform = histogram_equalize_transform(gray_image);

red_image = color_image(:, :, 1);
green_image = color_image(:, :, 2);
blue_image = color_image(:, :, 3);

red_inverse = inverse_histogram_equalize_transform(red_image);
green_inverse = inverse_histogram_equalize_transform(green_image);
blue_inverse = inverse_histogram_equalize_transform(blue_image);

red_transform = create_mapping(gray_transform, red_inverse);
green_transform = create_mapping(gray_transform, green_inverse);
blue_transform = create_mapping(gray_transform, blue_inverse);

red_equalized = intensity_transform(gray_image, red_transform);
green_equalized = intensity_transform(gray_image, green_transform);
blue_equalized = intensity_transform(gray_image, blue_transform);

colorized_image = cat(3, uint8(red_equalized), uint8(green_equalized), uint8(blue_equalized));
end
