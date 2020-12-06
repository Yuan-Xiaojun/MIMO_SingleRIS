function [results] = MIMO_EMS( optIn, PrioriIn )

EM.nit = 1 ; % iteration times of EM cycle
%EM.diff_stop = 1e-3 ;

N = optIn.N + 1;
M = optIn.M;
K = optIn.K;
T = optIn.T;
rho = optIn.rho;
H = PrioriIn.H;
H2 = abs(H).^2;
Y = PrioriIn.Y; 
Yvec = vec(Y);
Sam = PrioriIn.Sam;
% Initialization


% s = ones(1,N);
% p = randperm(N) ;
% s(p(1: floor(N * (1 - rho)))) = 0;
Es = rho*ones(1, N);
Es(1) = 1 ;
% ES = repmat(shiftdim(Es,-1),M,K); 
% Hhat = sum(ES .* H, 3);
Psvar = Es.*(1-Es);
%PSvar = repmat(shiftdim(Psvar,-1),M,K); 
nuwN = PrioriIn.noiseVar ;

%% Initialization
% xhat = zeros(K, T);
% xvar = ones(K,T); 
shat = Es' ;
svar = Psvar';
nuw = nuwN ;
for t = 1 : EM.nit 
%% GAMP estimste X   

% x_hat = xhat;
% tau_x = xvar ;
% [xhat,xvar] = SBL_GAMP(Y,Hhat,nuw,x_hat,tau_x) ;
% X_sam = zeros(K, T, length(Sam)) ;
% for i = 1 : length(Sam)
%     X_sam(:,:, i) = abs( Sam(i) - xhat );
% end
% [~,I] = min (X_sam, [], 3);
% xhat = Sam(I);
%[~ , Xerr] = symerr(PrioriIn.X , xhat)

%% EM update noisy varience


%Hhat2 = abs(Hhat).^2;
%nuw = sum(sum( abs(Y - Hhat * xhat).^2 + Hhat2 * xvar ))/(M*T) ;
%//////////////
%nuw =  sum(sum( sum(H2, 3) * xvar )) * rho * (1-rho)/M/T + nuwN ;
%////////////////////
% nuw = sum( PSvar.*H2, 3) * xvar;
%nuw(isnan(nuw)) = 1 ;
%////////////////
Z = zeros(M,T,N);
for n = 1 : N
    Z(:, :, n) = H(:,:,n) * PrioriIn.X ;
end
Zhat = reshape ( Z , M*T, N);

%% GAMP estimste S

s_hat = shat ;
tau_s = svar ;
[shat,svar] = SBL_GAMP_S(Yvec,Zhat,vec(nuw),s_hat,tau_s) ;
 shat = abs(shat) ;
 shat(shat>0.5) = 1;
 shat(shat<=0.5) = 0;
%[~ , Serr] = biterr(PrioriIn.s , shat') 

%% EM update noisy varience

%nuw_old = nuw ;
%Zhat2 = abs(Zhat).^2;
%nuw = sum(sum( abs(Yvec - Zhat * shat).^2 + Zhat2 * svar ))/(M*T) ;
%////////////////////
% nuw  = svar.' * reshape(sum(sum( H2 , 2), 1 ), N, 1) /M + nuwN;
% nuw(nuw == 'NAN') = 1 ;
%/////////////////////////

% Svar = repmat(shiftdim(svar.',-1),M,K);
% nuw = sum( Svar .* H2, 3) * ones(K, T);
% %nuw(isnan(nuw)) = 1 ;
% %//////////////////////
% Shat = repmat(shiftdim(shat', -1),M, K);
% Hhat = sum(Shat .* H, 3);
% 
% Shat = repmat(shiftdim(shat',-1),M,K); 
% Z = sum(Shat .* H, 3) * xhat;
% if norm(Y - Z, 'fro' )^2/numel(Y) - nuwN < 1e-3
%    break; 
% end
   
% if norm(nuw - nuw_old, 'fro' ) < 1e-5
%    break; 
% end

end 

results.xhat = PrioriIn.X ;
results.shat = shat' ;

end 