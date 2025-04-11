function [coeff]=newton(X,Y)
nx=length(X);
coeff=zeros(1,nx);
coeff(1)=Y(1); %c0
for k=2:nx % because the first is c0 which is already defined
    extraction=1;
    for i= 1:k-1 % the cumulative product of newton formula is until n-1
        extraction=extraction*(X(k)-X(i));
    end
    coeff(k)=(Y(k)-homertrick(coeff(1:k-1),X(k),X(1:k-1),k-2))/extraction;
end
end

