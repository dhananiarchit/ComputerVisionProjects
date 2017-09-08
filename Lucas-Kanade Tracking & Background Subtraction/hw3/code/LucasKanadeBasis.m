function [u,v] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [u,v] in the x- and y-directions.
It = im2double(It);
It1 = im2double(It1);
tol = 0.1;

p = [0 0]';


lambda = zeros(size(bases,3),1);
m = size(bases,3);
[X, Y] = meshgrid((rect(1) : rect(3)+0.1),(rect(2) : rect(4)+0.1));
T = interp2(It, X, Y);
flag = 1;

while norm(lambda) >= tol || flag == 1
    deltap = 2*[tol tol]';
    flag = 0;
    for i = 1:m
        T = T + lambda(i)*bases(:,:,i);
    end
    [Tx,Ty] = gradient(T);
    SDQ = [Tx(:) Ty(:)]';
    for i=1:m
        temp = bases(:,:,i);
        SDQ = SDQ - (temp(:)'*[Tx(:) Ty(:)])'*temp(:)';
    end
    
    
    H = SDQ*SDQ';
    while norm(deltap) >= tol
        [X, Y] = meshgrid((rect(1) : rect(3)+0.1) + p(1),(rect(2) : rect(4)+0.1) + p(2));
        Iw = interp2(It1, X, Y);
        diff = Iw - T;
        s = SDQ*diff(:);
        deltap = H\s;
        p = p - deltap;
    end
    u = p(1);
    v = p(2);
    
    [X, Y] = meshgrid((rect(1) : rect(3)+0.1) + u ,(rect(2) : rect(4)+0.1) + v);
    Iw = interp2(It1, X, Y);
    diff = Iw - T;
    for i = 1:m
        temp = bases(:,:,i);
        lambda(i) = temp(:)'*diff(:);
    end
end

