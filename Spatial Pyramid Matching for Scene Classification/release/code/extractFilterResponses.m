function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses

    
% TODO Implement your code here
filters = filterBank;

if length(size(img))==3
    im1_gray = RGB2Lab(img);
else
    img_gray(:,:,1) = img;
    img_gray(:,:,2) = img;
    img_gray(:,:,3) = img;
    im1_gray = RGB2Lab(img_gray);
end
collage = [];
filterResponses = [];
for i = 1:length(filters)

filter1 = cell2mat(filters(i));

filteredim1 = imfilter(im1_gray,filter1);
collage = cat(4,collage,filteredim1);
filterResponses = cat(3,filterResponses,filteredim1);
clear filter1

end
% figure
% montage(collage,'Size',[4 5]);

% filterResponses = collage;
end
