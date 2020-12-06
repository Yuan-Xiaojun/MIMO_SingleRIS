function  A = Constell_Modulate(B, Sam)

[M,N] = size(B);
A = zeros(M/sqrt(length(Sam)), N);



%%
     if length(Sam) == 4
        for  n=1 : N
            for  m=1 : M/sqrt(length(Sam))
                pack=[B((2*m-1),n) B(2*m,n)];
                if  pack==[1 1] 
                    A(m,n) = Sam(1);
               elseif  pack==[0 1] 
                    A(m,n) = Sam(2);
               elseif  pack==[0 0] 
                    A(m,n) =Sam(3);       
                else
                    A(m,n) = Sam(4);
                end
            end
        end
     elseif length(Sam) == 16
             for  n=1 : N
                for  m=1 : M/sqrt(length(Sam))
                    pack=[B((4*m-3),n) B((4*m-2),n) B((4*m-1),n) B(4*m,n)];
                    if  pack == [1 0 1 0] 
                        A(m,n) = Sam(1);
                   elseif  pack == [0 1 1 0] 
                        A(m,n) = Sam(2);
                   elseif  pack == [0 1 0 1] 
                        A(m,n) = Sam(3);
                    elseif  pack == [1 0 0 1] 
                        A(m,n) = Sam(4);
                   elseif  pack == [1 1 1 0] 
                        A(m,n) = Sam(5);
                   elseif  pack == [0 1 1 1] 
                        A(m,n) = Sam(6);
                   elseif  pack == [0 0 0 1] 
                        A(m,n) = Sam(7);
                   elseif  pack == [1 0 0 0] 
                        A(m,n) = Sam(8);
                   elseif  pack == [1 1 1 1] 
                        A(m,n) = Sam(9);
                   elseif  pack == [0 0 1 1] 
                        A(m,n) = Sam(10);
                   elseif  pack == [0 0 0 0] 
                        A(m,n) = Sam(11);
                   elseif  pack == [1 1 0 0] 
                        A(m,n) = Sam(12);
                   elseif  pack == [1 0 1 1] 
                        A(m,n) = Sam(13);
                   elseif  pack == [0 0 1 0] 
                        A(m,n) = Sam(14);
                   elseif  pack == [0 1 0 0] 
                        A(m,n) = Sam(15);
                     else   
                        A(m,n) = Sam(16);
                    end
                end  
             end 
     end
end
