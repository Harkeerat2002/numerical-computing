%% Excercise 3.1
function [x, rvec] = myCG(A, b, x0, maxIter, tol)
    rvec = [];	% residual vector
    x = x0;    % initial guess
    r = b - A * x0;     % initial residual
    d = r;     % initial direction
    pho_old = dot(r, r);   % initial pho
    
    
    for i = 1:maxIter
        s = A * d;
        alpha = pho_old / dot(d, s);
        x = x + alpha * d;
        r = r - alpha * s;
        pho_new = dot(r, r);

        beta = pho_new / pho_old;
        d = r + beta * d;
        pho_old = pho_new;
        
        rvec = [rvec, pho_new];

        if sqrt(pho_new) < tol
            disp('Converged');
            break;
        end
        
        
    end
end