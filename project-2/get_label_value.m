function label_value = get_label_value(label_image, labels, old_val)
% This function determines which label value shares the most perimeter with
% the label image at the connected component labelled 'old_val'.  Note,
% this is intended to be used directly before calling flood_fill on this
% connected component with the returned label_value, since it has the side
% effect of setting each explored pixel to 0.

x = labels{old_val}(1);
y = labels{old_val}(2);

% Initialize the queue, set the value at the seed to 0 (to show that we've
% explored it) and set up a map to keep track of votes.
next{1} = [x y];
label_image(x, y) = 0;
size_x = size(label_image, 1) + 1;
size_y = size(label_image, 2) + 1;
votes = containers.Map('KeyType', 'double', 'ValueType', 'double');

while not(isempty(next))
    % Convoluted way of looping through four adjacent pixels
    for i = 0:1
        for j = -1:2:1
            if(i == 0)
                adj_x = next{1}(1) + j;
                adj_y = next{1}(2);
            else
                adj_x = next{1}(1);
                adj_y = next{1}(2) + j;
            end
            
            % Bounds check
            if(0 < adj_x && adj_x < size_x && 0 < adj_y && adj_y < size_y)
                label = label_image(adj_x, adj_y);
                
                % If the label is the old value, its part of the connected
                % component, so keep exploring
                if(label == old_val)
                    label_image(adj_x, adj_y) = 0;
                    next{end + 1} = [adj_x, adj_y];
                    % In this case, we've reach the perimeter, and can update
                    % the votes
                elseif(label ~= 0)
                    if isKey(votes, label)
                        votes(label) = votes(label) + 1;
                    else
                        votes(label) = 1;
                    end
                end
            end
        end
    end
    next(1) = [];
end

% This just figures out the label with the maximum votes
maximum = 0;
label_value = 1;
vote_keys = keys(votes);
for i = 1:length(vote_keys)
    val = vote_keys{i};
    if(votes(val) > maximum)
        label_value = val;
        maximum = votes(val);
    end
end
end