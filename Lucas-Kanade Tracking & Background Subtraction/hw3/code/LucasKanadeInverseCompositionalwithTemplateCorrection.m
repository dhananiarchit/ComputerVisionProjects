function [u,v] = LucasKanadeInverseCompositionalwithTemplateCorrection(It,It1,rect,It0,rect_)

epilson = 2;
[u_,v_] = LucasKanadeInverseCompositional(It,It1,rect);
rect_new = rect + [u_ v_ u_ v_];


% change the initial guess
[unew,vnew] = LucasKanadeInverseCompositional(It0,It1,rect_);

unew = unew - (rect(1) - rect_(1));
vnew = vnew - (rect(2) - rect_(2));

if norm([unew-u_;vnew-v_])<=epilson
    u = unew;
    v = vnew;
else
    u = u_;
    v = v_;
end