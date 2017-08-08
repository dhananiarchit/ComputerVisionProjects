
load dictionary.mat
addpath('C:/Users/archi/Desktop/Somaiya drive/Sem2/16720/hw1/release/data/');
addpath('C:\Users\archi\Desktop\Somaiya drive\Sem2\16720\hw1\release\data\ice_skating');

img = imread('sun_advbapyfkehgemjf.jpg');

filterBank = createFilterBank();

filter_response = extractFilterResponses(img,filterBank);
response = reshape(filter_response,[],size(filter_response,3));
img = RGB2Lab(img);

dist = pdist2(response,dictionary');

[~,wordMap] = min(dist,[],2);

wordMap = reshape(wordMap,size(img,1),size(img,2));
% for j = 1:(size(filter_response,1))
%     for k = 1:(size(filter_response,2))
%         for i = 1:length(dictionary)
%             temp = filter_response(j,k,:);
%             x(i) = pdist2(temp(:)',dictionary(:,i)');
%         end
%         [~,p] = min(x);
%         t = reshape(dictionary(:,p)',[3 20]);
%         tx = double(img(j,k,:));
%         for i = 1:size(t,2)
%             b(i) = pdist2(tx(:)',t(:,i)');
%         end
%         [~,abc] = min(b);
%         wordMap(j,k,:) = t(:,abc)';
%         j
%     end
% end