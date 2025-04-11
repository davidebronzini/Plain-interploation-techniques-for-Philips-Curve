function S= homertrick(coeff,x,X,n)
n=length(X)-1;
S=coeff(end);
for i=n:-1:1
    S=S*(x-X(i))+coeff(i);
end