function  B = Constell_Mapping(A, Sam)

[M,N] = size(A);
B = zeros(M*sqrt(length(Sam)), N);


%%
        if length(Sam) == 4         
                for  m=1:M               
                    B((2*m-1),:) = real(A(m,:));
                    B((2*m),:) = imag(A(m,:));
                end
            B(B>0) = 1;
            B(B<0) = 0;
        elseif length(Sam) == 16
            for  n=1:N
                for  m=1:M
                    if  A(m,n) == Sam(1)
                        B((4*m-3),n) = 1;
                        B((4*m-2),n) = 0;
                        B((4*m-1),n) = 1;
                        B((4*m),n) = 0;
                   elseif  A(m,n) == Sam(2) 
                        B((4*m-3),n) = 0;
                        B((4*m-2),n) = 1;
                        B((4*m-1),n) = 1;
                        B((4*m),n) = 0;
                    elseif  A(m,n) == Sam(3)
                        B((4*m-3),n) = 0;
                        B((4*m-2),n) = 1;
                        B((4*m-1),n) = 0;
                        B((4*m),n) = 1;
                    elseif  A(m,n) == Sam(4)
                        B((4*m-3),n) = 1;
                        B((4*m-2),n) = 0;
                        B((4*m-1),n) = 0;
                        B((4*m),n) = 1;
                    elseif  A(m,n) == Sam(5)
                        B((4*m-3),n) = 1;
                        B((4*m-2),n) = 1;
                        B((4*m-1),n) = 1;
                        B((4*m),n) = 0;
                   elseif  A(m,n) == Sam(6)
                        B((4*m-3),n) = 0;
                        B((4*m-2),n) =1;
                        B((4*m-1),n) = 1;
                        B((4*m),n) = 1;
                   elseif  A(m,n) == Sam(7) 
                        B((4*m-3),n) = 0;
                        B((4*m-2),n) = 0;
                        B((4*m-1),n) = 0;
                        B((4*m),n) = 1;
                   elseif  A(m,n) == Sam(8)                        
                        B((4*m-3),n) = 1;
                        B((4*m-2),n) = 0;
                        B((4*m-1),n) = 0;
                        B((4*m),n) = 0;
                   elseif  A(m,n) == Sam(9)                        
                        B((4*m-3),n) = 1;
                        B((4*m-2),n) = 1;
                        B((4*m-1),n) = 1;
                        B((4*m),n) = 1;
                   elseif  A(m,n)== Sam(10)                     
                        B((4*m-3),n) = 0;
                        B((4*m-2),n) = 0;
                        B((4*m-1),n) = 1;
                        B((4*m),n) = 1;
                   elseif  A(m,n) == Sam(11)  
                        B((4*m-3),n) = 0;
                        B((4*m-2),n) = 0;
                        B((4*m-1),n) = 0;
                        B((4*m),n) = 0;
                   elseif  A(m,n) == Sam(12) 
                        B((4*m-3),n) = 1;
                        B((4*m-2),n) = 1;
                        B((4*m-1),n) = 0;
                        B((4*m),n) = 0;
                   elseif  A(m,n) == Sam(13) 
                        B((4*m-3),n) = 1;
                        B((4*m-2),n) = 0;
                        B((4*m-1),n) = 1;
                        B((4*m),n) = 1;
                   elseif  A(m,n) == Sam(14)
                        B((4*m-3),n) = 0;
                        B((4*m-2),n) = 0;
                        B((4*m-1),n) = 1;
                        B((4*m),n) = 0;
                   elseif  A(m,n) == Sam(15) 
                        B((4*m-3),n) = 0;
                        B((4*m-2),n) = 1;
                        B((4*m-1),n) = 0;
                        B((4*m),n) = 0;
                     else   
                        B((4*m-3),n) = 1;
                        B((4*m-2),n) = 1;
                        B((4*m-1),n) = 0;
                        B((4*m),n) = 1;
                    end
                end  
            end    
        end
end

