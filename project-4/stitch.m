function canvas = stitch(images, ratio, n, p_thresh)
% Stitches the input images into a mosaic, filtering with the frequency
% ratio and n.  Usess the p_thresh to determine if images overlap.

% Filter the images
f_images = filter_images(images, ratio, n);
p_images = pad_images(images);

% Set up the origins array
num_images = length(images);
origins = zeros(num_images, 3); origins(1, 1) = 1;

% Origins which have been set and not set
set = 1;
not_set = find(origins(:, 1) == 0);

% While there are still origins unset
while not(isempty(not_set))
    i = set(1); set(1) = [];
    
    % Find the unset origins that may relate to the current set origin
    for k = 1:length(not_set)
        j = not_set(k);
        p = phase_correlation(p_images{i}, p_images{j}, ratio, n);
        [mp, idx] = max(p(:));
        
        % Is the phase greater than some threshold?
        if mp > p_thresh
            [py, px] = size(p);
            [y, x] = ind2sub([py px], idx);
            [size_y, size_x] = size(f_images{i});
            
            % Edge case, wrap around
            if y > size_y
                y = py-y+1;
            end
            if x > size_x
                x = px-x+1;
            end
            
            % Determine which of the 4 ambiguous cases it is
            offset = get_offset(f_images{i}, f_images{j}, y, x);
            origins(j, :) = [i offset];
            set = [set j];
        end
    end
    not_set = find(origins(:, 1) == 0);
end

for i = 1:num_images
    while origins(i, 1) ~= 1
        new_origin = origins(origins(i, 1), :);
        origins(i, 1) = new_origin(1);
        origins(i, 2:3) = origins(i, 2:3) + new_origin(2:3);
    end
end
origins = origins(:, 2:3);

shift = abs(min(origins, [], 1));
origins = origins + repmat(shift, num_images, 1);

[mo, idx] = max(origins, [], 1);
canvas_size = [
    mo(1)+size(f_images{idx(1)}, 1)
    mo(2)+size(f_images{idx(2)}, 2)];

canvas = zeros([canvas_size(1) canvas_size(2)]);
for i = 1:num_images
    canvas = draw_image(canvas, f_images{i}, origins(i, :));
end
end