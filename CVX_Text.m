% Input  data
m = 16;
n = 8;
A = randn(m,n);
b = randn(m,1); 
% cvx version:
cvx_begin    
     variable x(n);    
     minimize( norm(A*x-b));
cvx_end 
disp('cvx_version:');
x_cvx = x 
% matlab version:
disp('matlab version:');
x_ls = A\b
