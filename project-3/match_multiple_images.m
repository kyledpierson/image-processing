function [images, X, Y] = match_multiple_images(images, X, Y, N, hg)
% Matches the size and color of two images, using rescaling and histogram
% matching.  Also scales the X and Y correspondenc vectors.

% Find the max size
sizes = cellfun(@size, images, 'UniformOutput', 0);
sizes = cell2mat(sizes);
max_y = max(sizes(:, 1));
max_x = max(sizes(:, 2));

% Rescale the images
for i = 1:N
    images{i} = imresize(images{i}, [max_y max_x]);
    
    % Rescale the correspondences
    a = sizes(i, :);
    new_y = max_y / a(1);
    new_x = max_x / a(2);
    X(:,i) = round(X(:,i)*new_x);
    Y(:,i) = round(Y(:,i)*new_y);
end

% Equalize the histograms
if hg
    avg_image = uint8(mean(cat(3, images{:}), 3));
    inverse = inverse_histogram_equalize_transform(avg_image);
    for i = 1:N
        if i > 1
            transform = histogram_equalize_transform(images{i});
            mapping = create_mapping(transform, inverse);
            images{i} = intensity_transform(images{i}, mapping);
        end
    end
end
end