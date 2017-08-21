function [u,v] = LucasKanadeInverseCompositional(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u,v] in the x- and y-directions.
It = im2double(It);
It1 = im2double(It1);
tol = 0.1;
[X, Y] = meshgrid((rect(1) : rect(3)),(rect(2) : rect(4)));
T = interp2(It, X, Y);


p = [0 0]';
deltap = 2*[tol tol]';
[Tx,Ty] = gradient(T); 
H = [Tx(:) Ty(:)]'*[Tx(:) Ty(:)];
while norm(deltap) >= tol
    [X, Y] = meshgrid((rect(1) : rect(3)) + p(1),(rect(2) : rect(4)) + p(2));
    Iw = interp2(It1, X, Y);
    diff = Iw - T;
    s = [Tx(:) Ty(:)]'*diff(:);
    deltap = H\s;
    p = p - deltap;
end
u = p(1);
v = p(2);