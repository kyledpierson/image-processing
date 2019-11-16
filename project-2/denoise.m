function label_image = denoise(threshold_image, threshold_size)
% This function takes a threshold image (an image which has been divided
% into thresholds) and a threshold size, finds the connected components in
% the threshold image, and then returns a new label image where all
% components smaller than the threshold size have been merged into the
% label with which they share the most perimeter.

[label_image, labels] = connected_components(threshold_image);
label_length = length(labels);

h = waitbar(0, 'Denoising...');

for i = 1:label_length
    if(labels{i}(3) < threshold_size)
        label_value = get_label_value(label_image, labels, i);
        [label_image, ~] = flood_fill(label_image, label_value, [labels{i}(1) labels{i}(2)], threshold_image);
    end
    
    waitbar(i/label_length);
end

close(h);
end