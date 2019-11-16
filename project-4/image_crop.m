function new_image = image_crop(image, y, x, i)
% Crops the image to have a size of [y x].  The corner from which the
% function crops depends on i
% i=1:top-left
% i=2:top-right
% i=3:bottom-left
% i=4:bottom-right

if i == 1
    new_image = image(end-y+1:end, end-x+1:end);
elseif i == 2
    new_image = image(end-y+1:end, 1:x);
elseif i == 3
    new_image = image(1:y, end-x+1:end);
else
    new_image = image(1:y, 1:x);
end