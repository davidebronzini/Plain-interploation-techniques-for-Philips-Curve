clear all
clc
%interpolation of Philips curve for Italy from an empirical point of view, 2013-2022
Xraw=readmatrix("tasso dis.xlsx"); %annual unemployment rate
Yraw=readmatrix("infl.csv.xlsx");%annual inflation rate
date=Xraw(4,3:end);
X=Xraw(6,3:end);
Y=Yraw(7,2:end);
T=length(date);
N=length(X);
finaldata=horzcat(date',X',Y');
XMax=max(X)
XMin=min(X)
[X_sorted,sort_index]=sort(X)
Y_sorted=Y(sort_index)
%% 

%interpolation
hold on
ylim([-10 10])
plot(X,Y,"x","MarkerFaceColor","k")
fplot(@(x) lagrangescript(x,X(1,1:2),Y(1,1:2)),[1,15],"r");
fplot(@(x) lagrangescript(x,X(1,1:4),Y(1,1:4)),[1,15],"g");
fplot(@(x) lagrangescript(x,X(1,1:6),Y(1,1:6)),[1,15],"b");
fplot(@(x) lagrangescript(x,X,Y),[1,15],"y");
hold off

%% newton
hold on
ylim([-1 10])
plot(X,Y,"x","MarkerFaceColor","k")
fplot(@(x) finalnewton(X(1,1:2),Y(1,1:2),x),[1,15],"r");
fplot(@(x) finalnewton(X(1,1:4),Y(1,1:4),x),[1,15],"g");
fplot(@(x) finalnewton(X(1,1:6),Y(1,1:6),x),[1,15],"b");
fplot(@(x) finalnewton(X,Y,x),[1,15],"y");
hold off
%% neville
hold on
ylim([1,10])
plot(X,Y,"x","MarkerFaceColor","k")
fplot(@(x) neville(x,X(1,1:2),Y(1,1:2)),[1,15],"r");
fplot(@(x) neville(x,X(1,1:4),Y(1,1:4)),[1,15],"g");
fplot(@(x) neville(x,X(1,1:6),Y(1,1:6)),[1,15],"b");
fplot(@(x) neville(x,X,Y),[1,15],"c")
hold off
%% local interpolation

hold on
ylim([-10,10])
plot(X,Y,"x","MarkerFaceColor","k")
fplot(@(x) local_interp(X_sorted,Y_sorted,x,2),[1,15],"r")
fplot(@(x) local_interp(X_sorted,Y_sorted,x,4),[1,15],"g")
fplot(@(x) local_interp(X_sorted,Y_sorted,x,6),[1,15],"b")
fplot(@(x) local_interp(X_sorted,Y_sorted,x,8),[1,15],"m")
fplot(@(x) local_interp(X_sorted,Y_sorted,x,10),[1,15],"c")
hold off
%% quadratic splines

hold on
ylim([-10,10])
plot(X,Y,"x","MarkerFaceColor","k")
fplot(@(x) quadraticspline(X_sorted(1:4),Y_sorted(1:4),x),[1,15],"y")
fplot(@(x) quadraticsplines2v(X_sorted(1:4),Y_sorted(1:4),x),[1,15],"m")
fplot(@(x) quadraticspline(X_sorted,Y_sorted,x),[1,15],"r")
fplot(@(x) quadraticsplines2v(X_sorted,Y_sorted,x),[1,15],"b")
hold off


%% cubic splines

hold on
ylim([-10,10])
plot(X,Y,"x","MarkerFaceColor","k")
fplot(@(x) cubicspline(X_sorted(1:4),Y_sorted(1:4),x,1),[1,15],"y")
fplot(@(x) cubicspline(X_sorted(1:4),Y_sorted(1:4),x,2),[1,15],"m")
fplot(@(x) cubicspline(X_sorted,Y_sorted,x,1),[1,15],"r")
fplot(@(x) cubicspline(X_sorted,Y_sorted,x,2),[1,15],"b")
hold off
%% evaluation of efficiency of each method throught timespeed
tic;
fplot(@(x) lagrangescript(x,X,Y),[1,15],"y");
runtime_lagrange=toc;
tic;
fplot(@(x) finalnewton(X,Y,x),[1,15],"y");
runtime_newton=toc;
tic;
fplot(@(x) neville(x,X,Y),[1,15],"c")
runtime_neville=toc;
tic;
fplot(@(x) local_interp(X_sorted,Y_sorted,x,10),[1,15],"c")
runtime_localinterp=toc;
tic;
fplot(@(x) quadraticspline(X_sorted,Y_sorted,x),[1,15],"r")
runtime_quadraticspline=toc;
tic;
fplot(@(x) quadraticsplines2v(X_sorted,Y_sorted,x),[1,15],"b")
runtime_quadraticspline2v=toc;
tic;
fplot(@(x) cubicspline(X_sorted,Y_sorted,x,1),[1,15],"r")
runtime_cubicspline1=toc;
tic;
fplot(@(x) cubicspline(X_sorted,Y_sorted,x,2),[1,15],"b")
runtime_quadraticspline2=toc;
%% evaluation of stability  throught relative error

dx=(XMax-XMin)/100;
 relative_err1=zeros(1,100);
 relative_err2=zeros(1,100);
 relative_err3=zeros(1,100);
 relative_err4 =zeros(1,100);
 relative_err5 =zeros(1,100);
 relative_err6 =zeros(1,100);
 relative_err7 =zeros(1,100);
 relative_err8=zeros(1,100);

for i=1:100
    x(i)=XMin+i*dx;
    v1=lagrangescript(x(i),X,Y);
    v2=finalnewton(X,Y,x(i));
    v3=neville(x(i),X,Y);
    v4=local_interp(X_sorted,Y_sorted,x(i),10);
    v5=quadraticspline(X_sorted,Y_sorted,x(i));
    v6=quadraticsplines2v(X_sorted,Y_sorted,x(i));
    v7=cubicspline(X_sorted,Y_sorted,x(i),1);
    v8=cubicspline(X_sorted,Y_sorted,x(i),2);
    relative_err1(i)=5*(v2-v3)/(v2+v3);
    relative_err2(i)=5*(v1-v3)/(v1+v3);
    relative_err3(i)=5*(v1-v2)/(v1+v2);
    relative_err4(i) =5*(v4 - v5) / (v4 + v5);
    relative_err5(i) =5*(v4 - v6) / (v4 + v6);
    relative_err6(i) =5*(v4 - v7) / (v4 + v7);
    relative_err7(i) =5*(v4 - v8) / (v1 + v7);
    relative_err8(i) =5*(v7 - v8) / (v7 + v8);
end
  
comp=1
switch comp
    case 1
hold on
plot(x,log10(abs(relative_err1)),"o")
plot(x,log10(abs(relative_err2)),"x")
plot(x,log10(abs(relative_err3)),"*")
hold off
    case 2
        
hold on
plot(x,log10(abs(relative_err4)),"o")    
plot(x,log10(abs(relative_err5)),"x")
plot(x,log10(abs(relative_err6)),"+")
plot(x,log10(abs(relative_err7)),"^")
plot(x,log10(abs(relative_err8)),".")
hold off
end






