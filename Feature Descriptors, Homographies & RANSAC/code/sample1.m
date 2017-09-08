clc
clear all
close all

addpath('..\Feature Descriptors, Homographies & RANSAC\data');


im1 = imread('incline_L.png');
% im1 = imread('model_chickenbroth.jpg');
if size(im1,3) == 3
    im1 = im2double(rgb2gray(im1));
end
im1 = im2double(im1);
im2 = imread('incline_R.png');
% im2 = imread('chickenbroth_01.jpg');
im2 = im2double(rgb2gray(im2));


% [locs1, desc1] = briefLite(im1);
% [locs2, desc2] = briefLite(im2);
% 
% [matches]= briefMatch(desc1,desc2,0.5);
% 
plotMatches(im1,im2,matches,locs1,locs2)