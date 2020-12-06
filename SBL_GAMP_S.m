function [x_hat,tau_x] = SBL_GAMP_S(y,A,sigma_noise,x_hat,tau_x)
% lambda corresponds to pi_in

% sigma_h = sigma_h + eps;
% sigma_noise = sigma_noise + eps;
% sigma_h = max(sigma_h,epsilon);
% sigma_noise = max(sigma_noise,epsilon);

%% 
T = size(y,2);
[M, K] = size(A);                      % the no. of antenas.
Ahat2 = abs(A).^2;
epsilon = 1e-5; 
s = zeros(M,T);
iter_num = 1000; 
%nuX = ones(K,1);
nuX = tau_x ;
nuX = max(nuX, epsilon);
%%
%       gXbase = CAwgnEstimIn(meanX, nuX);
%       gX = SparseScaEstim(gXbase,lambda);
% gX = BGZeroMeanEstimIn(sigma_h,lambda_f);
gOut = CAwgnEstimOut(y,sigma_noise);
%gX = AwgnEstimIn(x_hat, nuX);
Lamda = 1.1 * norm(A, 2)^2/norm(A,'fro')^2 ;
% theta_s = 0.2;
% theta_x = 2 * (2 * M + (K - M)*theta_s)/(Lamda * theta_s * M * K);
theta_x = 0.2;
theta_s = 2 * (2 * K + (M - K)*theta_x)/(Lamda * theta_x * M * K);

%% 
for k = 1:10
  gX = AwgnEstimIn(x_hat, nuX);
    for iter = 1:iter_num
      %  x_hat_pre = x_hat;
       %% output node update
        tau_p = Ahat2*tau_x;  % vector 
        tau_p = tau_p + epsilon;
        p = A*x_hat-s.*tau_p;
        [z_hat,tau_z] = gOut.estim(p,tau_p);  
        s_old = s;
        s = (z_hat - p)./(tau_p);
        s = (1-theta_s)*s_old + theta_s*s;   
        tau_s = (1-tau_z./(tau_p))./(tau_p) + epsilon ;
       %% input node update
        tau_r_inverse = Ahat2.'*tau_s +epsilon;
        tau_r = 1./tau_r_inverse;
        r = x_hat+(A'*s).*tau_r;
    %%
        x_hat_old = x_hat;
        [x_hat,tau_x,~] = gX.estim(r, tau_r);
         x_hat(1) = 1 ;
         tau_x(1) = eps ;
       %  x_hat = min(max (x_hat, epsilon ), 10^5 );
        tau_x(abs(tau_x)<eps) = eps;
        x_hat = (1-theta_x)*x_hat_old + theta_x*x_hat;
    %%    
        if norm(( x_hat -  x_hat_old), 'fro')^2/norm((x_hat), 'fro')^2 < 1e-10
           break; 
        end

    end
nuX = min(max (abs(x_hat).^2 + tau_x, epsilon ), 10^5 );
% gXbase = CAwgnEstimIn(x_hat, nuX);
% gX = SparseScaEstim(gXbase,rho);
end
return





