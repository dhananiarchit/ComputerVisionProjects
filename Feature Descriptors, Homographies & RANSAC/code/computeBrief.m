function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, ...
                                        levels, compareA, compareB)
%%Compute BRIEF feature
% INPUTS
% im      - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels  - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
%		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
%        valid descriptors in the image and will vary
patchWidth = 9;
nbits = length(compareA);
locs = [];
% to make sure that the patch around the locsDoG are width the image
% that is eliminating the points beyond the half patch of the image
for i = 1:length(locsDoG)
    if ((locsDoG(i,1)>floor(patchWidth(1)/2)) & locsDoG(i,1)< (size(GaussianPyramid,2) - floor(patchWidth(1)/2)) & ...
           (locsDoG(i,2)>floor(patchWidth(1)/2)) & (locsDoG(i,2)< size(GaussianPyramid,1) - floor(patchWidth(1)/2)))
       locs = [locs;locsDoG(i,:)];
    end
end
% halfPatch = floor(patchWidth / 2);
% locs = locsDoG(locsDoG(:,1) > halfPatch & ...
%     locsDoG(:,1) < size(GaussianPyramid, 2) - halfPatch & ...
%     locsDoG(:,2) > halfPatch & ...
%     locsDoG(:,2) < size(GaussianPyramid, 1) - halfPatch, :);
% Getting the index of the level in the point is present
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

comp1 = sub2ind(size(GaussianPyramid),compY1,compX1,compL);
comp2 = sub2ind(size(GaussianPyramid),compY2,compX2,compL);

% nbits(256) vector for each point is defined in the following way
desc = GaussianPyramid(comp1)<GaussianPyramid(comp2);

