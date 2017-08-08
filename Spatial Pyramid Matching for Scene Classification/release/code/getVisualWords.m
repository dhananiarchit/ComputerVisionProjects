function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
    filter_response = extractFilterResponses(img,filterBank);
    response = reshape(filter_response,[],size(filter_response,3));

    dist = pdist2(response,dictionary');

    [~,wordMap] = min(dist,[],2);

    wordMap = reshape(wordMap,size(img,1),size(img,2));
    
end
