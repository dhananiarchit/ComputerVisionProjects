function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'  
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear 
%         equation


for i = 1:length(p1)
    A = [p1(i,1) p1(i,2) 1 0 0 0 0 0;
        0 0 0 p1(i,1) p1(i,2) 1 0 0;
        0 0 0 0 0 0 p1(i,1) p1(i,2)];
    
end
