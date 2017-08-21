function [points_normalized,T] = normalizePoints(p)

origin = mean(p,2);
points_origin = p - repmat(origin,1,size(p,2));

points_sq = points_origin.^2;

meandist = sum(sqrt(points_sq(1, :) + points_sq(2, :))) / size(p, 2);
factor = sqrt(2) / meandist;
points_normalized = factor * points_origin;

% Create the normalization matrix
T = factor * [  1   0   -origin(1)
                0   1   -origin(2)
                0   0   1/factor ];


end