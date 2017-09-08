
addpath('../data/ice_skating');
addpath('../data/');
load sun_aamerccwdeptadrz.mat
load dictionary.mat
% imagesc(wordMap);
imshow('sun_aamerccwdeptadrz.jpg')
h = getImageFeaturesSPM(3,wordMap,size(dictionary,2));
guessImage('sun_aamerccwdeptadrz.jpg')