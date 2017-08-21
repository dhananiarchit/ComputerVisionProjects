
addpath('../data');

% im1 = imread('model_chickenbroth.jpg');
% im2 = imread('chickenbroth_01.jpg');

img1 = imread('incline_L.png');
img2 = imread('incline_R.png');

% Converting to Gray Scale
if size(im1,3) == 3
    im1 = (rgb2gray(img1));
end

if size(im2,3) == 3
    im2 = (rgb2gray(img2));
end

% im1 = im2double(im1);
% im2 = im2double(im2);


% Computing Brief Descirptor
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);

% Finding the matches
[matches]= briefMatch(desc1,desc2,0.2);

% Plotting the matching descriptors
plotMatches(im1,im2,matches,locs1,locs2);