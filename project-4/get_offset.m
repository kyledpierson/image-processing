function offset = get_offset(image_1, image_2, y_off, x_off)
% Computes the actual offset of image_2 from image_1, by resolving the four
% cases of ambiguity at the specified offset

[size_y2, size_x2] = size(image_2);

% Get the four overlapping sections of image_1
sections_1 = cell(1, 4);
sections_1{1} = image_1(1:y_off, 1:x_off);
sections_1{2} = image_1(1:y_off, x_off:end);
sections_1{3} = image_1(y_off:end, 1:x_off);
sections_1{4} = image_1(y_off:end, x_off:end);

% Get the four overlapping sections of image 2, and crop both sections
% where necessary
sections_2 = cell(1, 4);
for i = 1:4
    [new_y, new_x] = size(sections_1{i});
    new_y = min([new_y size_y2]);
    new_x = min([new_x size_x2]);
    
    sections_1{i} = image_crop(sections_1{i}, new_y, new_x, i);
    sections_2{i} = image_crop(image_2, new_y, new_x, i);
end

offsets = [
    y_off-size_y2 x_off-size_x2; y_off-size_y2 x_off;
    y_off x_off-size_x2; y_off x_off;];

% Find the sections with the highest correlation, and choose that offset as
% the true offset
cur_min = 1;
for i = 1:4
    corr = abs(normxcorr2(sections_1{i}, sections_2{i}));
    corr = (corr ./ max(corr(:)));
    new_min = mean2(corr);
    
    if new_min < cur_min
        cur_min = new_min;
        offset = offsets(i, :);
    end
end