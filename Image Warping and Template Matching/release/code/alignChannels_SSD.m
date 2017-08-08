function [rgbResult] = alignChannels_SSD(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%       corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here
for i = 1:30
    size((red(1:end-i+1,:)));
    size(green(i:end,:));
    SSD(i) = sum(sum((red(1:end-i+1,:) - green(i:end,:)).^2));
end
[M,I] = min(SSD);
red_new = red;
green_new = [green(I:end,:);zeros(I-1,943)];

for i = 1:30
    size((red(1:end-i+1,:)));
    size(blue(i:end));
    SSD_(i) = sum(sum((red(1:end-i+1,:) - blue(i:end,:)).^2));
end
[M_blue,I_blue] = min(SSD_);
blue_temp = [blue(I_blue:end,:);zeros(I_blue-1,943)];


for i = 1:30
    size((red(1:end-i+1,:)));
    size(blue(i:end,:));
    SSD_1(i) = sum(sum((red(:,1:end-i+1) - blue_temp(:,i:end)).^2));
end
[M_blue_row,I_blue_row] = min(SSD_1);

blue_new = [blue_temp(:,I_blue_row:end),zeros(810,I_blue_row-1)];

q_(:,:,1) = red_new;
q_(:,:,2) = green_new;
q_(:,:,3) = blue_new;

figure
image(q_);

rgbResult = q_;




end
