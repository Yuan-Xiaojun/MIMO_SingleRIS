function [ Theta ] = CVX_Optimal_Simplify( G1, G2, H0, rho, nuw, S )
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
theta = randn(N, 1) + 1i*randn(N, 1) ;
theta = theta./abs( theta ) ;
Theta = diag(theta);
theta = [theta ; 1];
Op_iter_NM = 50 ;
cvx_diff_stop = 1e-2 ;
Cost = 0 ;
%obj = [];
%QQ = randn(N+1, N+1) + 1i*randn(N+1, N+1) ;
Phi = ones(4,32);
Sigma = eye(4);

for iter = 1 : Op_iter_NM   
%%  Optimal (Phi, Sigma) for fixed  (Theta) 

    C_yx = ( rho * G2 * Theta * G1 + H0 ) * Px ;
    C_xy = C_yx' ;
    C_yy = G2 * Theta * ( rho^2 * GPG + rho*(1-rho)*diag(diag(GPG)) )* (Theta') * (G2') ...
           +   rho * ( G2 * Theta * G1 * Px * (H0') )  + H0I ...
           +   rho * ( G2 * Theta * G1 * Px * (H0') )' ;   
       
%Rate_ite(iter) = real( log2(det(Sigma)) + trace( Sigma\(Px - Phi*C_yx - (Phi*C_yx)' + Phi*C_yy*Phi') ) );            
       
    Phi = C_xy / C_yy ;
    Sigma = Px - Phi * C_yx ;  

%Rate_ite(iter) = Rate_ite(iter) - real( log2(det(Sigma)) + trace( Sigma\(Px - Phi*C_yx - (Phi*C_yx)' + Phi*C_yy*Phi') ) );         
    
    
    
%% Optimal (Theta) for fixed (Phi, Sigma)
    alpha =  rho*diag( G1 * Px *( (H0') * (Phi') - eye(K) )/Sigma * Phi * G2 );
    alpha =  conj(alpha);
    A = (G2')* (Phi') /Sigma * Phi * G2 ;
    Lambda = zeros(N, N) ;
    for k = 1 : K
        Lambda = Lambda + diag(G1(:,k)') * A * diag(G1(:,k)) ;
    end
    Lambda  =  rho^2 * Lambda + rho*(1-rho)* diag(diag((V') * A * V)) ;
        R = [ Lambda , alpha; ...
          (alpha') , 0   ];
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
 
end
end







