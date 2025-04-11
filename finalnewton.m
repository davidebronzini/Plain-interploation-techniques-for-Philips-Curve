function S = finalnewton(X,Y,x)
n=length(X)-1;
coeff=newton(X,Y);
S=homertrick(coeff,x,X,n);
end