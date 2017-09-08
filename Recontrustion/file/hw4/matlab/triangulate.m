function [ P, error ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%

x = p1(:,1);
y = p1(:,2);
x_ = p2(:,1);
y_ = p2(:,2);

p3T = C1(3,:);
p2T = C1(2,:);
p1T = C1(1,:);
p3T_ = C2(3,:);
p2T_ = C2(2,:);
p1T_ = C2(1,:);


P = zeros(length(x),3);
for i = 1:length(x)
A = [x(i)*p3T - p1T;y(i)*p3T - p2T;x_(i)*p3T_ - p1T_;y_(i)*p3T_ - p2T_];

[~,~,V] = svd(A);


P(i,:) = V(1:3,end)/V(4,end);

end

P = [P ones(length(x),1)];

pcap1 = C1 * P';
pcap1 = pcap1(1:2,:)'./[pcap1(3,:);pcap1(3,:)]';

pcap2 = C2 * P';
pcap2 = pcap2(1:2,:)'./[pcap2(3,:);pcap2(3,:)]';

error = sum((p1(:) - pcap1(:)).^2 + (p2(:) - pcap2(:)).^2);

end

