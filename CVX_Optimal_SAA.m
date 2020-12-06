function [ Theta, Rate_ite] = CVX_Optimal_SAA( G1, G2, H0, rho, nuw, S1 )
%  [Theta, obj] = CVX_Optimal( G1, G2, H0, rho, nuw, S )
% G1 : the channel of LIS-BS link
% G2 : the channel of User-LIS link
% H0 : the channel of direct link
% rho : the sparsity of LIS link
% N : the number of the refecting elements of LIS
% nuw : power of noisy
%%
%Initialization and set some variables
[N, K] = size(G1);
[M, ~] = size(G2);
Px = eye(K) ;  % C_{xx}
GPG = G1 * Px * (G1') ;
V = diag(sqrt(diag(GPG))); 
H0I = H0 * Px * (H0') + nuw * eye(M) ;

Op_iter_NM = 2000 ;
Rate_ite = zeros(1, Op_iter_NM);
cvx_diff_stop = 1e-4 ;
Num_S = 1000 ;
S = ones(Num_S,N);
for i = 1 : Num_S
     p = randperm(N) ;
     S(i, p(1 : floor(N * (1 - rho)))) = 0;
end
theta = randn(N,1) + 1i*randn(N,1) ;
theta = theta./abs( theta ) ;
Theta = diag(theta);
theta = [theta; 1];

% QQ = randn(N+1, N+1) + 1i*randn(N+1, N+1) ;
for iter = 1 : Op_iter_NM   
%%  Optimal (Phi, Sigma) for fixed  (Theta)
   R = zeros(N+1, N+1) ;
   for i = 1 : Num_S
       d_S = diag(S(i,:));
%        d_S = ones(1,N);
%        p = randperm(N) ;
%        d_S(1, p(1 : floor(N * (1 - rho)))) = 0;   
%        d_S = diag(d_S);
        C_yx = ( G2 * Theta * d_S * G1 + H0 ) * Px ;
        C_xy = C_yx' ;
        C_yy = G2 * Theta * d_S * GPG * d_S' * (Theta') * (G2') ...
               +   ( G2 * Theta * d_S * G1 * Px * (H0') )  + H0I ...
               +   ( G2 * Theta * d_S * G1 * Px * (H0') )'   ;   
        Phi = C_xy /C_yy ;
        Sigma = Px - Phi * C_yx ;  
 %% Optimal (Theta) for fixed (Phi, Sigma)
        alpha =  diag( d_S * G1 * Px *( (H0') * (Phi') - eye(K) )/Sigma * Phi * G2 );
        alpha =  conj(alpha);
        A = d_S * (G2')* (Phi') / Sigma * Phi * G2 * d_S ;
        Lambda = zeros(N, N) ;
        for k = 1 : K
            Lambda = Lambda + diag(G1(:,k)') * A * diag(G1(:,k)) ;
        end    
        R = R + [ Lambda , alpha; ...
                  (alpha') , 0   ];
             
   end 
    R = R/Num_S/Num_S ;       
    R = ( R + R' )/2; 

%%  convex semidefinite program
    cvx_begin  sdp  quiet
        variable Q(N+1,N+1) complex  
        expression QQ(N+1, N+1)
        QQ = ( Q + Q' )/2;
        minimize( real(trace( R * QQ )) )
        subject to
        QQ >= 0 ;
        vec( diag(QQ) ) == vec( ones(N + 1, 1) );
    cvx_end

    [Uq, Dq, ~] = svds(QQ);
    r = size(Dq,2);
%% select optimal theta    
   A_Opt = inf;
    for i = 1 : 10 
        Rq = sqrt(0.5)*(randn(r, 1) + 1i*randn(r, 1));
        theta1 = Uq * sqrt(Dq) * Rq ;
        theta2 = theta1./(theta1(N+1));
        theta3 = theta2./abs(theta2) ; 
        A_ite = real( (theta3') * R * theta3 ) ;
        if A_ite < A_Opt
           A_Opt = A_ite;
           theta = theta3  ;
        end  
    end       
    Theta = diag(theta(1 : N)) ;
%%         
H_X = G2 * Theta * diag(S1) * G1 + H0 ;
Rate_ite(iter) = real( log2(det( eye(K) + (H_X' * H_X )/nuw)) ) ;    

end
end

