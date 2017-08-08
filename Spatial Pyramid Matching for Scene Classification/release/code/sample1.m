% clc
% clear all
% close all

load('../data/traintest.mat'); 

interval= 1;
train_imagenames = train_imagenames(1:interval:end);
imPaths = strcat(['../data/'],train_imagenames);
% [filterBank,dictionary] = getFilterBankAndDictionary(strcat(['../data/'],train_imagenames));

filterBank  = createFilterBank();

% TODO Implement your code here
dictionary = [];
filter_responses = [];
for i = 1:length(imPaths)
    im = imread(char(imPaths(i)));

    collage = extractFilterResponses(im,filterBank);
    data = datasample(collage,1,'Replace',false);
    data1 = datasample(data,50,2,'Replace',false);
    d = reshape(data1(:),[50 60]);
%     data = datasample(collage,50,'Replace',false);
%     data3 = datasample(data,1,3);
%     data1 = datasample(data3,3*20,2,'Replace',false);
    filter_responses = [filter_responses;d];

end

a = 'done'
% K = 200;    
% [~,dictionary] = kmeans(double(filter_responses),K, 'EmptyAction','drop');

% save('dictionary.mat','filterBank','dictionary');