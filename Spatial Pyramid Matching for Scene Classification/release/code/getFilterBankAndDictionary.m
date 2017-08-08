function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    filterBank  = createFilterBank();

    % TODO Implement your code here
    dictionary = [];
    filter_responses = [];
for i = 1:length(imPaths)
    im = imread(char(imPaths(i)));

    collage = extractFilterResponses(im,filterBank);
    data = datasample(collage,1,'Replace',false);
    data1 = datasample(data,100,2,'Replace',false);
    data2 = reshape(data1(:),[100 60]);
    filter_responses = [filter_responses;data2];
end

K = 100;    
[~,dictionary] = kmeans(double(filter_responses),K, 'EmptyAction','drop');
dictionary = dictionary';
end
