
addpath('../data/')

load carseq.mat
rect = [60,117,146,152];
rect1 = rect;
stopFrame = [2, 100, 200, 300, 400];
It0 = frames(:,:,1);
rect_ = rect;
for i = 2:size(frames,3)
    It = frames(:,:,i-1);
    It1 = frames(:,:,i);
    [u1,v1] = LucasKanadeInverseCompositional(It,It1,rect_);
    [u,v] = LucasKanadeInverseCompositionalwithTemplateCorrection(It,It1,rect,It0,rect1);
    rect = rect + [u v u v];
    rect_ = rect_ + [u1 v1 u1 v1];
    i
    imshow(It1);
    hold on
    rectangle('Position',[rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],'EdgeColor','b');
    rectangle('Position',[rect_(1) rect_(2) rect_(3)-rect_(1) rect_(4)-rect_(2)],'EdgeColor','r');
    hold off
    
    if i == stopFrame
        pause(3)
    else
        pause(0.1)
    end
%     close all
end