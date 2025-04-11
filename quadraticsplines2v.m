function poly=quadraticsplines2v(xi,yi,x)
N=length(xi);
k=3*(N-2);
A=zeros(k);
B=zeros(k,1);
vector_int=zeros(N-1,1);
vector_int(1,1)=xi(1);
vector_int(N-1,1)=xi(end);
for i=2:N-2
    vector_int(i)=(xi(i)+xi(i+1))/2;
end
B(1:N)=yi(1:N);
xx=[1 xi(1) xi(1)^2];
A(1,1:3)=xx;
for i=2:N-1
    A(i,3*(i-2)+1)=1;
    A(i,3*(i-2)+2)=xi(i);
    A(i,3*(i-2)+3)=xi(i)^2;
end

A(N,(3*N-8):(3*N-6))=[1 xi(N) xi(N)^2];
%second part of A
for i=1:N-3
    A(N+i,3*(i-1)+1)=1;
    A(N+i,3*(i-1)+2)=vector_int(i+1);
    A(N+i,3*(i-1)+3)=vector_int(i+1)^2;
    A(N+i,3*(i-1)+4)=-1;
    A(N+i,3*(i-1)+5)=-vector_int(i+1);
    A(N+i,3*(i-1)+6)=-1*vector_int(i+1)^2;
    A(N+i+N-3,3*(i-1)+2)=1;
    A(N+i+N-3,3*(i-1)+3)=2*vector_int(i+1);
    A(N+i+N-3,3*(i-1)+5)=-1;
    A(N+i+N-3,3*(i-1)+6)=-2*vector_int(i+1);
end
coeff=A\B;
poly=0;
for i=1:N-2
    if x <= vector_int(i+1)
        j = i + 1;
        poly = coeff(3*(j-2)+1) + coeff(3*(j-2)+2)*x + coeff(3*(j-2)+3)*x^2;
        break
    end
end
    
end


