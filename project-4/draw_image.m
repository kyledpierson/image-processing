function canvas = draw_image(canvas, image, origin)
% Draws the given image on the given canvas, at the specified origin

[size_y, size_x] = size(image);

origin_y = origin(1);
origin_x = origin(2);

% Draw each image at its specified origin
for i = 1:size_y
    for j = 1:size_x
        %         if i == 1 || i == size_y || j == 1 || j == size_x
        %             canvas(origin_y + i, origin_x + j) = 0;
        %         end
        %         if canvas(origin_y + i, origin_x + j) ~= 0
        canvas(origin_y + i, origin_x + j) = image(i, j);
        %         end
    end
end
