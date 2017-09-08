% Problem 1: Image Alignment

clc
clear all
close all
addpath('..\data\');

%% 1. Load images (all 3 channels)
red1 = load('red.mat'); % Red channel
green1 = load('green.mat');  % Green channel
blue1 = load('blue.mat');  % Blue channel

red= (red1.red);
green = (green1.green);
blue = (blue1.blue);


q(:,:,1) = (red);
q(:,:,2) = green;
q(:,:,3) = blue;

figure
image(q);

%%
% SSD_ = [];
for i = -30:1:30
    for j = -30:30
        green_temp = circshift(green,[i j]);
        SSD_green(i+31,j+31) = sum(sum((red - green_temp).^2));
    end
end
[M,I] = min(SSD_green);
[M_,I_] = min(M);


x = I(I_)-31;
y = I_-31;

green_new = circshift(green,[x y]);

q(:,:,1) = (red);
q(:,:,2) = green_new;
q(:,:,3) = zeros(size(green));

figure
image(q)


%%
for i = -30:1:30
    for j = -30:30
        blue_temp = circshift(blue,[i j]);
        SSD_blue(i+31,j+31) = sum(sum((red - blue_temp).^2));
    end
end
[Mb,Ib] = min(SSD_blue);
[Mb_,Ib_] = min(Mb);


xb = Ib(Ib_)-31;
yb = Ib_-31;

blue_new = circshift(blue,[xb yb]);

q(:,:,1) = (red);
q(:,:,2) = green_new;
q(:,:,3) = blue_new;

figure
image(q)


%% 2. Find best alignment
% Hint: Lookup the 'circshift' function
rgbResult = alignChannels(red, green, blue);

%% 3. Save result to rgb_output.jpg (IN THE "results" folder)

