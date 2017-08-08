% function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features
    for i = 1:length(train_imagenames)
        j=i
         wordmapfile = strrep(['../data/', train_imagenames{i}], '.jpg', '.mat');
         load(wordmapfile);
         
         train_features(:,i) = getImageFeaturesSPM(3,wordMap,size(dictionary,2));
    end

	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

% end