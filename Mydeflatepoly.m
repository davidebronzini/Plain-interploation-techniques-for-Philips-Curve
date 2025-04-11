function out = Mydeflatepoly(n,c,xi,x)
% c=coeffs
% n =order : jus for cross-check
% x= point to be used in the evaluation
% xi = points to be used in (x-xi)**i
if(n~=(length(c)-1))
    msg="something wrong in deflate"
    disp(c)
    error(msg)
end

if(n~=(length(xi)-1))
    msg="something wrong in deflate"
    disp(c)
    error(msg)
end


out=c(end);
%out
for i=n:-1:1 % as matlab arrays start at index 1
%    i
%    i+1
%    c(i)
%    (x-xi(i))
    out=out*(x-xi(i))+c(i);
end

end