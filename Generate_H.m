function [H0, G1, G2] = Generate_H( optIn  )



K = optIn.K;
M = optIn.M;
N = optIn.N;
K1 = 10^(optIn.L0/10);
K2 = 10^(optIn.L1/10);





%location 
h_BS = 50;
h_RIS = 30;
y_RIS = 50;
Loca_BS = [0, 0, h_BS];
Loca_RIS = [0, y_RIS, h_RIS];
x_U = 50*rand(K,1);
y_U = 80*rand(K,1);
Loca_U = [x_U, y_U, zeros(K,1)] ;
%% Large-scale fadding factor
h_RB = norm( Loca_BS - Loca_RIS, 2 );   % RIS-BS
h_UR = zeros(1,K);    % User-RIS
for k = 1 : K   
    h_UR(k) = norm( Loca_U(k,:) - Loca_RIS, 2 );
end
h_UB = zeros(1,K);   % User-BS    
for k = 1 : K
    h_UB(k) = norm( Loca_U(k,:) - Loca_BS, 2 );
end
% Large-scale fadding factor 1
% fad_G2 = sqrt( 10^(-3)/((h_RB)^2.2) ) ;
% fad_G1 = sqrt( 10^(-3)./((h_UR ).^2.2) ) ;
% fad_H0 = sqrt( 10^(-3)./((h_UB).^3.5) ) ;
% Large-scale fadding factor 2
fad_G1 = sqrt( 10^(-3)./((h_UR + h_RB ).^2.8)) ;
fad_H0 = sqrt( 10^(-3)./((h_UB).^3.5)) ;
fad_G2 = sqrt(0.1);
% Large-scale fadding factor
% fad_H0 = -rand(1, K) * L0 ;
% fad_H0 = 10.^(fad_H0 / 10);
% fad_H0 = sqrt(fad_H0 / max(fad_H0)); %normalize non-fadding power of H to 1
% fad_G1 = -rand(1, K) * L1 ;
% fad_G1 = 10.^(fad_G1 / 10);
% fad_G1 = sqrt(fad_G1 / max(fad_G1)); %normalize non-fadding power of H to 1

%% LoS component
N_1 = 16 ;
N_2 = N/N_1 ;
G1_hat = zeros(N,K) ;
G1_AoA1 = atan( (-x_U)./(y_RIS-y_U) );
G1_AoA2 = atan( (-h_RIS)./sqrt( (y_RIS-y_U).^2 + x_U.^2 ) );
for k = 1 : K
    G1_hat(:,k) = vec( exp( 1i*pi*( 0 : (N_1 - 1) ).'* sin(G1_AoA1(k))*cos(G1_AoA2(k)) )...
                  * ( exp( -1i*pi*( 0 : (N_2 - 1) ).'*sin(G1_AoA1(k))*cos(G1_AoA2(k)) ).') );
end
G2_AoD1 = pi/2;
G2_AoD2 = atan( (h_BS - h_RIS)/sqrt( y_RIS^2 ) );
G2_RIS = vec( exp( 1i*pi*( 0 : (N_1 - 1) ).'* sin(G2_AoD1)*cos(G2_AoD2)  )...
                  * ( exp( -1i*pi*( 0 : (N_2 - 1) ).'* sin(G2_AoD1)*cos(G2_AoD2) ).') );
N_1 = 8 ;
N_2 = M/N_1 ;              
G2_AoA1 = 0;
G2_AoA2 = -G2_AoD2;
G2_BS = vec( exp( -1i*pi*( 0 : (N_1 - 1) ).'* sin(G2_AoA1) )...
                  * ( exp( -1i*pi*( 0 : (N_2 - 1) ).'*sin(G2_AoA2) ).') );              
G2_hat = G2_BS * (G2_RIS.') ;
%% Rayleigh component
G1_tilde = sqrt(0.5)*(randn(N, K) + 1i*randn(N, K)) ;
G2_tilde = sqrt(0.5)*(randn(M, N) + 1i*randn(M, N)) ;
% generate channel
G1 = sqrt(K1/(1+K1))*G1_hat + sqrt(1/(1+K1))*G1_tilde ;
G2 = sqrt(K2/(1+K2))*G2_hat + sqrt(1/(1+K2))*G2_tilde ;
H0 = sqrt(0.5)*(randn(M, K) + 1i*randn(M, K)) ;
%H0 = zeros(M, K);
H0 = H0 * diag(fad_H0) ;
G1 = G1 * diag(fad_G1) ;
G2 = G2 * fad_G2 ;

end




