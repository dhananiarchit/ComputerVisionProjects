function [ warp_im ] = warpA( im, A, out_size )
% warp_im=warpAbilinear(im, A, out_size)
% Warps (w,h,1) image im using affine (3,3) matrix A 
% producing (out_size(1),out_size(2)) output image warp_im
% with warped  = A*input, warped spanning 1..out_size
% Uses nearest neighbor mapping.
% INPUTS:
%   im : input image
%   A : transformation matrix 
%   out_size : size the output image should be
% OUTPUTS:
%   warp_im : result of warping im by A
warp_im = zeros(out_size);
p_og = [];
im_gray = im;
for i = 1:150
    for j = 1:200
        p_temp = [i j 1];
        p_og = [p_og;p_temp];
    end
end
p = inv(A)*p_og';

p = p';
for i = 1:length(p)
   if(floor(p(i,2))>=1 && floor(p(i,2))<=size(im_gray,1) && floor(p(i,1))>=1 && floor(p(i,1))<=size(im_gray,2))
        warp_im(p_og(i,2),p_og(i,1)) = im_gray(floor(p(i,2)),floor(p(i,1)));
   end 
    
end
