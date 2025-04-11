function P_n = lagrangescript(x,XS,YS)
nx=length(XS);
P_n = 0;
num=zeros(1,nx);
den=zeros(1,nx);
for k= 1:nx
    
    extract=1;
    for i=1:nx
        if k~=i
        den = XS(k)-XS(i);
        num = x-XS(i);
        extract=extract*(num/den);

     
      
        
        end
    end
    P_n=P_n+extract*YS(k); 
end
end

  
 
