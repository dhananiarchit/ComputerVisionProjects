function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC
nIter = 500; 
tol = 5;
max = [];

p1 = locs1(matches(:,1),1:2);
p2 = locs2(matches(:,2),1:2);

for i = 1:nIter
   randommatches = datasample(1:length(matches),4,'Replace',false);
   points_randmatches = matches(randommatches,:);
   randp1 = locs1(points_randmatches(:,1),1:2);
   randp2 = locs2(points_randmatches(:,2),1:2);
   
   H2to1 = computeH(randp1,randp2);
   
   p1_computeH = H2to1*[p2, ones(size(p2,1),1)]';
   
   p1_computeH = (p1_computeH./repmat(p1_computeH(3,:),3,1))';
   
   diff = (p1(:,1) - p1_computeH(:,1)).^2 + (p1(:,2) - p1_computeH(:,2)).^2;
   inlier = diff<tol^2;
   
   if nnz(inlier) > nnz(max)
       max = inlier;
   end
end

p1best = p1(max,:);
p2best = p2(max,:);
bestH = computeH(p1best,p2best);