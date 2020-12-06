function results = MIMO_algorithm(optIn, SNR)


%% System setting
K = optIn.K;
M = optIn.M;
N = optIn.N;
T = optIn.T;
rho = optIn.rho;

%SNR = optIn.SNR;
QAM = optIn.QAM;
%rho = optIn.rho;
nuw = 10^(-SNR/10) ;
Rete_ite = 0 ;
%% Produce System Model 

if QAM == 4
    Sam = [1+1i -1+1i -1-1i 1-1i]./sqrt(2);    
elseif QAM == 16    
    Sam = [1+1i -1+1i -1-1i 1-1i 3+1i -1+3i -3-1i 1-3i 3+3i -3+3i -3-3i 3-3i 1+3i -3+1i -1-3i 3-1i]./sqrt(10);
end
% produce s
s = ones(1,N);
p = randperm(N) ;
s(p(1: floor(N * (1 - rho)))) = 0;
s = [1, s];
S = repmat(shiftdim(s,-1),M,K); 
%% produce H
[H0, G1, G2] = Generate_H( optIn );
% Optimal theta
if  optIn.Optimal == 0
    theta = randn(1, N) + 1i*randn(1, N);
    theta = diag(theta ./(abs(theta)));
elseif  optIn.Optimal == 1
        %theta = CVX_Optimal_SIMO( G1, G2, H0, rho, nuw);
        theta = CVX_Optimal_Simplify( G1, G2, H0, rho, nuw, s(2 : end));
else         
        [theta, Rete_ite]  = CVX_Optimal_SAA( G1, G2, H0, rho, nuw, s(2 : end));
end
% generate equivalent channel 
H = zeros(M, K, N+1);
H(:, :, 1) = H0 ;
for n = 1 : N
    H(:, :, n+1) = theta(n,n) * G2(:, n) * G1(n, :) ;
end
% produce X 
B = randi([0,1], sqrt(QAM)*K, T);
X = Constell_Modulate(B, Sam);
% produce Y
A = sum(S .* H, 3) ;
Z = A * X;
%aa = norm( Z , 'fro')^2 / numel(Z)
Y = Z + sqrt(nuw/2)*(randn(size(Z))+1i*randn(size(Z)));

%% Initialize results as empty and send PrioriIn information 
results = [] ;
PrioriIn.noiseVar = nuw ;
PrioriIn.H = H ;
PrioriIn.X = X ;
PrioriIn.s = s ;
PrioriIn.Y = Y ;
PrioriIn.Sam = Sam ;
PrioriIn.rho = rho ;

%%  EM  module

    [results1] = MIMO_EM( optIn, PrioriIn );
    [resultsX] = MIMO_EMX( optIn, PrioriIn );
    [resultsS] = MIMO_EMS( optIn, PrioriIn );
    
    xhat = results1.xhat ;
    shat = results1.shat ;
    
    LB_xhat = resultsX.xhat ;
    LB_shat = resultsS.shat ;
    
%%
    Bhat = Constell_Mapping(xhat, Sam) ;
    [~ , Xerr] = biterr(B , Bhat);
    [~ , Serr] = biterr(s , shat);
    
    LB_Bhat = Constell_Mapping(LB_xhat, Sam) ;
    [~ , LB_Xerr] = biterr(B , LB_Bhat);
    [~ , LB_Serr] = biterr(s , LB_shat);
     
  
%      Xerr = 0 ;
%      Serr = 0 ;
%      LB_Xerr = 0 ;
%      LB_Serr = 0 ;

     results.Xerr = Xerr ;
     results.Serr = Serr ;
     results.LB_Xerr = LB_Xerr ;
     results.LB_Serr = LB_Serr ;

     results.Rete_ite = Rete_ite ;   
     RateX = 0 ;
     for i = 1 : 1000
         d_S = ones(1,N);
         p = randperm(N) ;
         d_S(p(1: floor(N * (1 - rho)))) = 0;
         H_X = G2 * theta * diag(d_S) * G1 + H0 ;
         RateX = RateX + real( log2(det( eye(K) + (H_X' * H_X )/nuw)) ) ; 
     end 
    results.RateX = RateX/1000 ; 
    
%      RateX1 = real( log2(det( eye(K) + (H0' * H0 )/nuw)) ) ;
%      results.RateX = RateX1 ;
    
end
%%







