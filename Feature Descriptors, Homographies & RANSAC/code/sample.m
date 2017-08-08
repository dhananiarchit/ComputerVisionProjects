
addpath('C:\Users\archi\Desktop\Somaiya drive\Sem2\16720\hw2\data');
im = imread('pf_scan_scaled.jpg');
% imshow(im)

% im = rgb2gray(im);
im = im2double(im);
% [A,B] = briefLite(im);
sigma0 = 1;
k = sqrt(2);
levels = -1:1:4;

th_contrast = 0.03;
th_r = 12;


[locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, ...
                                        levels, th_contrast, th_r);
patchWidth = 9;
nbits = 256;
locs = [];
[compareA, compareB] = makeTestPattern(patchWidth, nbits);
for i = 1:length(locsDoG)
    if ((locsDoG(i,1)>floor(patchWidth(1)/2)) & locsDoG(i,1)< (size(GaussianPyramid,1) - floor(patchWidth(1)/2)) & ...
           (locsDoG(i,2)>floor(patchWidth(1)/2)) & (locsDoG(i,2)< size(GaussianPyramid,2) - floor(patchWidth(1)/2)))
       locs = [locs;locsDoG(i,:)];
    end
end

[~,levels_index] = ismember(locs(:,3),levels);  

[Xx,Xy] = ind2sub([patchWidth,patchWidth],compareA);


[Yx,Yy] = ind2sub([patchWidth,patchWidth],compareB);
                                    
Xx = repmat((Xx-floor(patchWidth/2)-1)',size(locs,1),1);
Xy = repmat((Xy-floor(patchWidth/2)-1)',size(locs,1),1);
Yx = repmat((Yx-floor(patchWidth/2)-1)',size(locs,1),1);
Yy = repmat((Yy-floor(patchWidth/2)-1)',size(locs,1),1);

compX1 = repmat(locs(:,1),1,nbits)+Xx;
compY1 = repmat(locs(:,2),1,nbits)+Xy;
compX2 = repmat(locs(:,1),1,nbits)+Yx;
compY2 = repmat(locs(:,2),1,nbits)+Yy;
compL = repmat(levels_index,1,nbits);

comp1 = sub2ind(size(GaussianPyramid),compX1,compY1,compL);
comp2 = sub2ind(size(GaussianPyramid),compX2,compY2,compL);

desc = GaussianPyramid((comp1))<GaussianPyramid((comp2));   