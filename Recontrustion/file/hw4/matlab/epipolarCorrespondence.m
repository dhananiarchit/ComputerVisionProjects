function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute   (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Explain your methods and optimization in your writeup

epipolarline = F*[x1,y1,1]';
epipolarline = epipolarline./norm(epipolarline);

patchwidth = 5;
filter = fspecial('gaussian', patchwidth*2 +1,patchwidth/2 );

pointx1 = 1:size(im2,2);
pointy1 = -(epipolarline(1)*pointx1 + epipolarline(3))/epipolarline(2);
temp1 = (pointx1 - patchwidth)>0 & (pointy1 - patchwidth)>0 & (pointx1 + patchwidth)<size(im2,2) & (pointy1 + patchwidth)<size(im2,1);  


pointy2 = 1:size(im2,1);
pointx2 = -(epipolarline(2)*pointy2 + epipolarline(3))/epipolarline(1);
temp2 = (pointx2 - patchwidth)>0 & (pointy2 - patchwidth)>0 & (pointx2 + patchwidth)<size(im2,2) & (pointy2 + patchwidth)<size(im2,1);  

pointx = pointx1;
pointy = pointy1;
temp = temp1;

if nnz(temp1) < nnz(temp2)
    pointx = pointx2;
    pointy = pointy2;
    temp = temp2;
end
indices = find(temp == 1);
template = double(im1(y1-patchwidth:y1+patchwidth,x1-patchwidth:x1+patchwidth));
besterror = Inf;
index = 0;

for i = indices
    
    if(((-pointx(i) + x1)^2 + (-pointy(i) + y1)^2)>50^2)
        continue;
    end
    
    patch =  double(im2(pointy(i)-patchwidth : pointy(i) + patchwidth ,pointx(i)-patchwidth : pointx(i)+patchwidth));
    diff = abs(template-patch).*filter;
    error = sum(diff(:));
    
    if besterror>error
        besterror = error;
        index = i;
    end
end

x2 = pointx(index);
y2 = pointy(index);