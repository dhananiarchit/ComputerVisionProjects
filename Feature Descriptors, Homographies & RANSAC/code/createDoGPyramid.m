function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
%%Produces DoG Pyramid
% inputs
% Gaussian Pyramid - A matrix of grayscale images of size
%                    (size(im), numel(levels))
% levels      - the levels of the pyramid where the blur at each level is
%               outputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%               created by differencing the Gaussian Pyramid input
DoGPyramid = zeros(size(GaussianPyramid)-[0 0 1]);

for i = 2:size(GaussianPyramid,3)
    DoGPyramid(:,:,i-1) = GaussianPyramid(:,:,i)-GaussianPyramid(:,:,i-1);
    DoGLevels(i-1) = levels(i);
end
