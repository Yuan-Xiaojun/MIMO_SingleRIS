function [xhat,xvar ] = Xestim(rhat, rvar )
state = [0, 1];
[M,N]=size(rhat);
xhat=zeros(M,N);
xvar=zeros(M,N);
Pa=zeros(M,N,length(state));
P=zeros(M,N);

 for i=1:length(state)      
      L = abs(state(i)*ones(M,N)-rhat).^2./rvar;
      Pa(:,:,i)=exp(-L);
   %   Pa(:,:,i)= -L ;
      Pa = max(Pa,1e-200);
      P = P + Pa(:,:,i);
  end                  
  for i=1:length(state)
      Pa(:,:,i)=Pa(:,:,i)./(P(:,:));      
  end    
   for i=1:length(state)
       xhat11 = Pa(:,:,i).*(state(i)*ones(M,N));
       xhat = xhat+xhat11;              
   end
   for i=1:length(state)
       xvar11 = Pa(:,:,i).*(abs(state(i)*ones(M,N)-xhat).^2);
       xvar = xvar+xvar11; 
   end  

end