function new_transform = create_mapping(transform, inverse)
% Creates a mapping as follows:
%   If transform goes from a -> b and inverse goes from b -> c, then
%   returns a mapping from a -> c
% 
% Each mapping is represented as an array
transform_length = length(transform);
new_transform = zeros(1, transform_length);

for i = 1:transform_length
    index = transform(i) + 1;
    range_value = find_range_value(inverse, index, i);
    new_transform(i) = range_value;
end
end
