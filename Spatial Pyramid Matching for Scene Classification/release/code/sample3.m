
addpath('C:/Users/archi/Desktop/Somaiya drive/Sem2/16720/hw1/release/data/');

addpath('C:\Users\archi\Desktop\Somaiya drive\Sem2\16720\hw1\release\data\ice_skating');

load sun_aamerccwdeptadrz.mat
load dictionary.mat
% imagesc(wordMap);
imshow('sun_aamerccwdeptadrz.jpg')
h = getImageFeaturesSPM(3,wordMap,size(dictionary,2));
guessImage('sun_aamerccwdeptadrz.jpg')