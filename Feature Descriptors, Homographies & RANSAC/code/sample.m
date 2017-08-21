
testMatches

p1 = locs1(matches(:,1),1:2);
p2 = locs2(matches(:,2),1:2);

% H2to1 = computeH(p1,p2);
BestH = ransacH(matches,locs1,locs2,500,5);

panoImag = imageStitching(img1,img2,BestH);

panoImag1 = imageStitching_noClip(img1,img2,BestH);