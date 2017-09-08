function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

% Normalization of the points.
pts1 = pts1/M;
pts2 = pts2/M;

% Computing matrix A.
x = pts1(:,1);
y = pts1(:,2);
x_ = pts2(:,1);
y_ = pts2(:,2);
A = [x.*x_ , x.*y_ , x , y.*x_ , y.*y_ , y , x_ , y_ , ones(length(x),1)];

Asq = A'*A;

[V,~] = eig(Asq);

F = V(:,1);

F = reshape(F,[3 3]);
[U,D,V] = svd(F);
D(3,3) = 0;
F = U*D*V';

F = refineF(F,pts1,pts2);
T = diag([1/M,1/M,1]);

F = T'*F*T;

end

