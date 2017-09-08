% Q2.7 - Todo:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3

addpath('../data/');

im1 = imread('im1.png');
im2 = imread('im2.png');

load some_corresp.mat

M = max(size(im1));
F = eightpoint(pts1,pts2,M);

% [coordsIM1, coordsIM2] = epipolarMatchGUI(im1, im2, F);
% Q2.7
load templeCoords.mat
load intrinsics.mat

E = essentialMatrix(F,K1,K2);

M2s = camera2(E);

M1 = [eye(3), zeros(3,1)];

C1 = K1*M1;
C2 = K2*M2s(:,:,2);
x2 = [];
y2 = [];
for i = 1:length(x1)
    [ x2_, y2_ ] = epipolarCorrespondence( im1, im2, F, x1(i), y1(i) );
    x2 = [x2;x2_];
    y2 = [y2;y2_];
end

pts1 = [x1 y1];
pts2 = [x2 y2]; 
[P,error] = triangulate(C1,pts1,C2,pts2);

