function finalpoly=neville(x,X,Y)
n=length(Y);
poly=Y;
num=zeros(1,n);
den=zeros(1,n);
for i=n-1:-1:1
    for j=1:i
        num(j)=poly(j+1)*(x-X(j))-poly(j)*(x-X(j-i+n));
        den(j)=X(j-i+n)-X(j);
        poly(j)=num(j)/den(j);
    end
    
end
finalpoly=poly(1);
end



