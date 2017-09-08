addpath('../data/')
% load frames
load aerialseq.mat

% implementation

for i = 2: size(frames,3)
   i
   It = frames(:,:,i-1); 
   It1 = frames(:,:,i); 
%    imshow(frames(:,:,i-1));
   
   Mask = SubtractDominantMotion(It, It1);
   temp(:,:,1) = It1;
   temp(:,:,2) = It1;
   temp(:,:,3) = It1;
   temp(:,:,1) = max(It1,uint8(225.*Mask));
   
   imshow(Mask);
%    pause(0.01);
    
end