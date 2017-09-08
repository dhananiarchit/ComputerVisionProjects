% load frames

load sylvbases.mat
load sylvseq.mat
% implementation
It = frames(:,:,1);
rect =  [102, 62, 156, 108];
for i = 2:size(frames,3)
    It = frames(:,:,i-1);
    It1 = frames(:,:,i);
    
%     [u1,v1] = LucasKanadeInverseCompositional(It,It1,rect);
%     rect = rect + [u1 v1 u1 v1];
    [u,v] = LucasKanadeBasis(It, It1, rect, bases);
    rect = rect + [u v u v];
    
    imshow(frames(:,:,i));
    hold on 
    rectangle('Position',[rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],'EdgeColor','b');
    hold off
    pause(0.1);
end












% save the rects
% save sylvseqrects.mat rects