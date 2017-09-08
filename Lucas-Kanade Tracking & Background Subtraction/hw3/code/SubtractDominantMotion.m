function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size

M = LucasKanadeAffine(image1,image2);

im = image1;
out_size = size(image1);
warp_im = warpH(im, M, out_size);

diff = image2 - warp_im;

level = graythresh(diff);

mask = imbinarize(diff,level);
end