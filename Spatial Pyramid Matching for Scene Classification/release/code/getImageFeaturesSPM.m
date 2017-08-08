function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
    h = zeros((4^layerNum - 1)/3,dictionarySize);
    s = size(h);
    count = 0;
    
    histTemp = zeros(2^(layerNum-1),2^(layerNum-1));
    
    
    for l = layerNum-1:-1:0
        numOfcells = 2^l;
        
        cellSize = floor(size(wordMap)/numOfcells);
        
        for i = 1:numOfcells
            for j = 1:numOfcells
                count = count+1;
                
                if l == layerNum-1
                    h(count,:) = getImageFeatures(wordMap(((i-1)*cellSize(1)+1):(i*cellSize(1)),((j-1)*cellSize(2)+1):(j*cellSize(2))),dictionarySize)/2;
                else
                    h(count,:) = h(histTemp(i*2-1, j*2-1), :) + ...
                                 h(histTemp(i*2, j*2-1), :) + ...
                                 h(histTemp(i*2-1, j*2), :) + ...
                                 h(histTemp(i*2, j*2), :);
                    if l~=0
                        h(count,:) = h(count,:)/2;
                    end
                end
                histTemp(i,j) = count;
            end
        end        
    end
    
    h = h(:)/sum(h(:));

end