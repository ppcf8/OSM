function alpha = strong_wolfe(func,grad,x0,f0,d)
% function alpha = strong_wolfe(func,grad,x0,f0,d)
% Compute a line search to satisfy the strong Wolfe conditions.
% Based on algorithm 3.5. Page 60. "Numerical Optimization". Nocedal & Wright.
% INPUTS:
%  func: objective function handle
%  x0: starting point
%  f0: initial function evaluation
%  d:  search direction
% OUTPUTS:
% alpha: step length

% Variables Initialization
g0 = grad(x0(1),x0(2));
c1 = 1e-4;
c2 = 0.9;
alpha_max = 2.5;
alpha_im1 = 0;
alpha_i   = 1;
f_im1 = f0;
dphi0 = g0.'*d;
i = 0;
max_iters = 20;

% Search for alpha satisfying the Strong-Wolfe conditions
while true
  
  x   = x0 + alpha_i*d;
  f_i = func(x(1),x(2));
  g_i = grad(x(1),x(2));

  if (f_i > f0 + c1*dphi0) || ( (i > 1) && (f_i >= f_im1) )
    alpha = alpha_zoom(func,grad,x0,f0,g0,d,alpha_im1,alpha_i);
    break;
  end
  dphi = g_i.'*d;
  if ( abs(dphi) <= -c2*dphi0 )
    alpha = alpha_i;
    break;
  end
  if ( dphi >= 0 )
    alpha = alpha_zoom(func,grad,x0,f0,g0,d,alpha_i,alpha_im1);
    break;
  end
  
  % Update alpha
  alpha_im1 = alpha_i;
  f_im1 = f_i;
  alpha_i = alpha_i + 0.8*(alpha_max-alpha_i);

  if isnan(alpha_i)
      break
  end
  
  if (i > max_iters)
    alpha = alpha_i;
    break;
  end
  
  i = i+1;
  
end

end

function alpha = alpha_zoom(func,grad,x0,f0,g0,d,alpha_lo,alpha_hi)
% function alpha = alpha_zoom(func,x0,f0,g0,d,alpha_lo,alpha_hi)
% Based on algorithm 3.6, Page 61. "Numerical Optimization". Nocedal & Wright.
% INPUTS:
%  func: objective function handle
%  x0: starting point
%  f0: initial function evaluation
%  d:  search direction
% OUTPUTS:
%  alpha: zoomed in alpha.

% Variables Initialization
c1 = 1e-4;
c2 = 0.9;
i = 0;
max_iters = 20;
dphi0 = g0.'*d;

while true
  alpha_i = 0.5*(alpha_lo + alpha_hi);
  alpha = alpha_i;
  x = x0 + alpha_i*d;
  [f_i] = func(x(1),x(2));
  g_i   = grad(x(1),x(2));
  x_lo = x0 + alpha_lo*d;
  f_lo = func(x_lo(1),x_lo(2));
  if ( (f_i > f0 + c1*alpha_i*dphi0) || ( f_i >= f_lo) )
    alpha_hi = alpha_i;
  else
    dphi = g_i.'*d;
    if ( ( abs(dphi) <= -c2*dphi0 ) )
      alpha = alpha_i;
      break;
    end
    if ( dphi * (alpha_hi-alpha_lo) >= 0 )
      alpha_hi = alpha_lo;
    end
    alpha_lo = alpha_i;
  end
  i = i+1;
  if (i > max_iters)
    alpha = alpha_i;
    break;
  end
end

end