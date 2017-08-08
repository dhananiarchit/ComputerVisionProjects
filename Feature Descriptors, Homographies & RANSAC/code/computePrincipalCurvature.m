function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid

% PrincipalCurvature = zeros(size(DoGPyramid));
[Dx,Dy] = gradient(DoGPyramid);
[Dxx,Dxy] = gradient(Dx);
[Dyx,Dyy] = gradient(Dy);

Tr = Dxx+Dyy;
Det = Dxx.*Dyy - Dxy.^2;
PrincipalCurvature = (Tr.^2)./Det;


end
