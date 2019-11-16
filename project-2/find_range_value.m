function range_value = find_range_value(inverse, index, original_value)
% This function is used to map s -> s', as shown in class.  In other words,
% when mapping an image to an equalized histogram image, and then mapping
% that histogram image to another image, some values in the range of the
% first mapping might not be in the domain of the second mapping.  In this
% case, we need to find the closest value to our original pixel intensity,
% and then map to that.
inverse_length = length(inverse);
diff = inverse_length;

% Make sure we don't go out of bounds
if(index > inverse_length)
    index = inverse_length;
end

% Check the closest darker value
for i = index:-1:1
    if(inverse{i})
        match = inverse{i};
        diff = index - i;
        break;
    end
end

% Check the closest lighter value
for i = index:inverse_length
    if(inverse{i})
        if(i - index < diff)
            match = inverse{i};
        end
        break;
    end
end

% Use whichever of the two values is closer
[~, min_index] = min(abs(match - (original_value - 1)));
range_value = match(min_index);
end
