function poly=local_interp(X,Y,x,m)
[hint,lint,hx,lx]=findclosestxi(X,x,m);
poly=finalnewton(X(lint:hint),Y(lint:hint),x);
end