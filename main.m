% W.J.Yan, 3.2019

%clc;
clear;
tic
% randn('state',1);
% rand('state',1);
% randi('state',1);
%setup_DL 
% core_number = 6;
% parpool('local', core_number);

N_Rec = [32];   % receiver antenna
N_IRS = [32];   % IRS antenna
SNR = [90]; 
SimLen = 100;   % average simulation time

optIn.K = 4;       % transmitter antenna
optIn.T = 50;       % coherencr time
%optIn.rho = 0.5 ;  % mean_s
rho_Range = [0.5];
optIn.QAM = 4;   % modulate style,  only for: 4 : QPSK;  16 : 16QAM.
optIn.Optimal = 1; % 0 : random theta;  
%1 : optimize theta by simplified P-BF algorithm; 
%2 : optimize theta by SAA-based P-BF algorithm

optIn.L0 = 10;  % Large-scale fadding of user-BS link
optIn.L1 = 13;  % Large-scale fadding of user-RIS link
optIn.L2 = 0;  % Large-scale fadding of RIS-BS link
optIn.K1 = 3;  % Rician factor of user-RIS link
optIn.K2 = 10;  % Rician factor of RIS-BS link
optIn.M = N_Rec;
optIn.N = N_IRS;

%for iR = 1 : length(N_Rec)
    for iS = 1 : length(rho_Range)
        
      %  optIn.M = N_Rec(iR);    
        optIn.rho = rho_Range(iS);    
        
        X_BER = zeros(1, length(SNR));    % average of bit error rate of X 
        S_BER = zeros(1, length(SNR));  % average of bit error rate of S
        LB_X_BER = zeros(1, length(SNR));    % average of bit error rate of X 
        LB_S_BER = zeros(1, length(SNR));  % average of bit error rate of S
        RateX = zeros(1, length(SNR));  % Rate of users
        Rate_ite = 0 ;    % rate as the iteration increase , must one SNR
        for sim = 1 : SimLen
            
            tX_BER = zeros(1, length(SNR));    % bit error rate of X in each iteration 
            tS_BER = zeros(1, length(SNR));  % bit error rate of S in each iteration  
            tLB_X_BER = zeros(1, length(SNR));    % bit error rate of X in each iteration 
            tLB_S_BER = zeros(1, length(SNR));  % bit error rate of S in each iteration 
            tRateX = zeros(1, length(SNR));  % Rate in each iteration 
   
           
%%            
            for iN = 1 : length(SNR)  
              
                SNR_iN = SNR(iN);
     
                results = MIMO_algorithm(optIn,SNR_iN );   %  subfunction       
                
                tX_BER(iN) = results.Xerr;
                tS_BER(iN) = results.Serr;
                tLB_X_BER(iN) = results.LB_Xerr;
                tLB_S_BER(iN) = results.LB_Serr;
                tRateX(iN) = results.RateX ;
                tRate_ite = results.Rete_ite ;
            end
%%            
            X_BER = X_BER*(sim-1)/sim + tX_BER/sim;
            S_BER = S_BER*(sim-1)/sim + tS_BER/sim;
            LB_X_BER = LB_X_BER*(sim-1)/sim + tLB_X_BER/sim;
            LB_S_BER = LB_S_BER*(sim-1)/sim + tLB_S_BER/sim;
            RateX = RateX*(sim-1)/sim + tRateX/sim;
            Rate_ite = Rate_ite*(sim-1)/sim + tRate_ite/sim;    
            sim
        end

         fid = fopen('MIMO_result.txt','a+');
         fprintf(fid,'\n');
         fprintf(fid,'SimLen = %3d, M = %3d, N = %3d, K = %3d, T = %3d,  QAM = %2d,  rho = %2d\n', ...
             sim, optIn.M, optIn.N, optIn.K, optIn.T, optIn.QAM, optIn.rho );
            fprintf(fid, 'SNR =');
            fprintf(fid, '%2d  ', SNR);
            fprintf(fid, '\n');

            fprintf(fid, 'X_BER =');
            fprintf(fid, '%3.6e  ', X_BER);
            fprintf(fid, '\n');

            fprintf(fid, 'LB_X_BER =');
            fprintf(fid, '%3.6e  ', LB_X_BER);
            fprintf(fid, '\n');

            fprintf(fid, 'S_BER =');
            fprintf(fid, '%3.6e  ', S_BER);
            fprintf(fid, '\n'); 
            
            fprintf(fid, 'LB_S_BER =');
            fprintf(fid, '%3.6e  ', LB_S_BER);
            fprintf(fid, '\n');
            
            fprintf(fid, 'RateX =');
            fprintf(fid, '%3.6e  ', RateX);
            fprintf(fid, '\n'); 
            
            fprintf(fid, 'Rate_ite =');
            fprintf(fid, '%3.6e  ', Rate_ite);
            fprintf(fid, '\n');

    end
%end
save 
toc
%%










