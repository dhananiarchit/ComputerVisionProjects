function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup


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

F1 = V(:,1);
F2 = V(:,2);

F1 = reshape(F1,[3 3]);

F2 = reshape(F2,[3 3]);
syms a

Func = det(a*F1 + (1-a)*F2);

alphas = solve(Func == 0);
alphas = double(alphas);
alphas = real(alphas);

T = diag([1/M,1/M,1]);

for i = 1:length(alphas)
    F{i} = alphas(i)*F1 + (1 - alphas(i))*F2;
    F{i} = refineF(F{i},pts1,pts2);
    F{i} = T'*F{i}*T;
end

