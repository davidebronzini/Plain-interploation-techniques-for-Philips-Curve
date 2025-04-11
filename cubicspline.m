function p=cubicspline(xi,yi,x,arb_cond)
n=numel(xi);


if n<2 | numel(yi)~=n
    msg1='sizes of input do not match or too few number of xi';
    error(msg1)
end
Z=zeros(n);
alpha=zeros(n,1);

Dx = zeros(1, n-1);
Dy = zeros(1, n-1);

for i = 1:n-1
    Dx(i) = xi(i+1) - xi(i);
    Dy(i) = yi(i+1) - yi(i);
end

for i=2:n-1
    Z(i,i)=2*(Dx(i)-Dx(i-1));
    Z(i,i+1)=Dx(i-1);
    Z(i,i-1)=Dx(i);
    alpha(i)=3*Dx(i-1)*(Dy(i)/Dx(i))+3*Dx(i)*(Dy(i-1)/Dx(i-1));
   
end
if arb_cond==1 
    Z(1,1)=2;
    Z(1,2)=1;
    alpha(1)=3*Dy(1)/Dx(1);
    Z(n,n-1)=1;
    Z(n,n)=2;
    alpha(n)=3*Dy(n-1)/Dx(n-1);
elseif arb_cond==2
    Z(1,1)=(Dx(2).^2)+Dx(1)*Dx(2);
    Z(1,2)=(Dx(1)*Dx(2)).^2;
    alpha(1)=(Dx(2).^2)*(Dy(2)/Dx(2))+(Dy(1)/Dx(1))*(3*Dx(1)*Dx(2)+2*Dx(2).^2);
    Z(n,n-1)=(Dx(n-1)+Dx(n-2))^.2;
    Z(n,n)=(Dx(n-2)^.2)+(Dx(n-2)*Dx(n-1));
    alpha(n)=(Dx(n-1).^2)*(Dy(n-2)/Dx(n-2))+(Dy(n-1)/Dx(n-1))*(3*Dx(n-1)*Dx(n-2)+2*Dx(n-2).^2);

end
b=Z\alpha;
for i=1:n-1
   c(i)=3*Dy(i)/Dx(i).^2-2*b(i)/Dx(i)-b(i+1)/Dx(i);  
    d(i)=(b(i+1)+b(i)-2*Dy(i)/Dx(i))./Dx(i).^2;
end
p=NaN;
for i=1:n-1
    if x>=xi(i) & x<=xi(i+1)
        p=yi(i)+b(i)*(x-xi(i))+c(i)*(x-xi(i))^2+d(i)*(x-xi(i))^3;
        break
    end
end
end


