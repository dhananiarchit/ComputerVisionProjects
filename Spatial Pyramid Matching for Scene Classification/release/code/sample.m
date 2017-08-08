% clc
% clear all 
% close all
addpath('C:/Users/archi/Desktop/Somaiya drive/Sem2/16720/hw1/release/data/');
% addpath('C:\Users\archi\Desktop\Somaiya drive\Sem2\16720\hw1\release\data\ice_skating');
load traintest.mat


im = imread(['C:/Users/archi/Desktop/Somaiya drive/Sem2/16720/hw1/release/data/',char(train_imagenames(194))]);
figure
image(im);

% im1 = imread(all_imagenames{1});
im = imread('sun_advbapyfkehgemjf.jpg');
% im2 = imread(all_imagenames(1));
figure
image(im);

filters = createFilterBank();
if length(size(im))==3
    im1_gray = RGB2Lab(im);
else
    im1_gray = im
end
collage = [];
for i = 1:length(filters)

filter1 = cell2mat(filters(i));

filteredim1 = imfilter(im1_gray,filter1);
collage = cat(4,collage,filteredim1);

clear filter1

end
figure
montage(collage,'Size',[4 5]);
