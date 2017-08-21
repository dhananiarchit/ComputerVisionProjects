function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'  
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear 
%         equation
[p1,T1] = normalizePoints(p1);
[p2,T2] = normalizePoints(p2);
A_total = [];
for i = 1:length(p1)
    x2 = p1(i,1);
    y2 = p1(i,2);
    x1 = p2(i,1);
    y1 = p2(i,2);
    A = [-x1 -y1 -1 0 0 0 x1*x2 y1*x2 x2;
        0 0 0 -x1 -y1 -1 x1*y2 y1*y2 y2];
    A_total = [A_total; A];
end

Asq = A'*A;
[V,~] = eig(Asq);


H = V(:,1);

H2to1 = reshape(H,[3,3])';

H2to1 = T1 \ H2to1 * T2;

% Normalize the Homography matrix to have determinant = 1
H2to1 = real(H2to1 ./ det(H2to1)^(1/3));