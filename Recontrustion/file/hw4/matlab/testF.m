clear all
close all
clc

addpath('../data')

im1 = imread('im1.png');
im2 = imread('im2.png');

load some_corresp.mat

M = max(size(im1));
F = eightpoint(pts1,pts2,M);

% F = sevenpoint(pts1,pts2,M);

% displayEpipolarF(im1, im2, F);

load intrinsics.mat

E = essentialMatrix(F,K1,K2);

M2s = camera2(E);

M1 = [eye(3), zeros(3,1)];

C1 = K1*M1;
C2 = K2*M2s(:,:,2);

[P,error] = triangulate(C1,pts1,C2,pts2);