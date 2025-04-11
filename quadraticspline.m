function poly=quadraticspline(xi,yi,x)
n=numel(xi);


if n<2 | numel(yi)~=n
    msg1='sizes of input do not match or too few number of xi'
    error(msg1)
end

Z=zeros(n-1);
for i=1:n-1
    Z(i,i)=1;
    if i<n-1
        Z(i,i+1)=1;
    end
end
den_x=zeros(1,n-1);
num_y=zeros(1,n-1);
 %otherwise first elemnt of a is a NaN
for i=1:n-1
    den_x(i)= xi(i+1)-xi(i);
    num_y(i)=yi(i+1)-yi(i);
end

a=2*num_y./den_x;
b=Z\a';
c=diff(b)'./(2*den_x(1:n-2));
c(n-1)=-b(n-1)./(2*den_x(n-1));


poly=NaN;
for i=1:n-1
    
    if x>=xi(i) & x<=xi(i+1)
        poly=yi(i)+b(i)*(x-xi(i))+c(i)*((x-xi(i))^2);
        break
    end
end
end

