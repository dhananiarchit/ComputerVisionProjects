function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');

	% TODO Implement your code here
    c = zeros(length(mapping));
    
    for i = 1:length(test_labels)
        name = ['../data/',test_imagenames{i}];
        fprintf('%d\n',i);
        guess = find(strcmp(guessImage(name),mapping));
        
        c(test_labels(i),guess) = c(test_labels(i),guess)+1;
    end
    
    accuracy = trace(c)/sum(c(:))
    conf = c
end

