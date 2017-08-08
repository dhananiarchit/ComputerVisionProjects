% Problem 1: Image Alignment

clc
clear all
close all
addpath('C:\Users\archi\Desktop\Somaiya drive\Sem2\16720\hw0\release\data');

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


image(q);

%%
% SSD_ = [];
for i = 1:30
    size((red(1:end-i+1,:)));
    size(green(i:end,:));
    red_double = double(red);
    red_norm = norm(red_double,2);
    NCC(i) = sum(sum((red(1:end-i+1,:) - green(i:end,:)).^2));
end
[M,I] = min(NCC);
red_new = red;
green_new = [green(I:end,:);zeros(I-1,943)];

for i = 1:30
    size((red(1:end-i+1,:)));
    size(blue(i:end));
    SSD_(i) = sum(sum((red(1:end-i+1,:) - blue(i:end,:)).^2));
end
[M_blue,I_blue] = min(SSD_);
blue_temp = [blue(I_blue:end,:);zeros(I_blue-1,943)];


for i = 1:30
    size((red(1:end-i+1,:)));
    size(blue(i:end,:));
    SSD_1(i) = sum(sum((red(:,1:end-i+1) - blue_temp(:,i:end)).^2));
end
[M_blue_row,I_blue_row] = min(SSD_1);

blue_new = [blue_temp(:,I_blue_row:end),zeros(810,I_blue_row-1)];

q_(:,:,1) = red_new;
q_(:,:,2) = green_new;
q_(:,:,3) = blue_new;

figure
image(q_);

%% 2. Find best alignment
% Hint: Lookup the 'circshift' function
rgbResult = alignChannels_SSD(red, green, blue);

%% 3. Save result to rgb_output.jpg (IN THE "results" folder)

