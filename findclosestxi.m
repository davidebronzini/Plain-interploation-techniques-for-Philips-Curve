function[hint,lint,hx,lx]=findclosestxi(x_i,x,m)
if m>length(x_i)
    msg1='too few x_i ';
    error(msg1)
end
if length(x)~=1
    msg2='x should be a scalar';
    error(msg2)
end

nx_i=numel(x_i);
if x<=x_i(1)
    lint=1;
    hint=m;
elseif x>=x_i(end)
    hint=nx_i;
    lint=nx_i-m+1;
else 
    ileft=0;
    iright=0;
    for i=1:nx_i-1
        if x_i(i)<=x & x_i(i+1)>x
            ileft=i;
            iright=i+1;
            break
        end
    end
  
    reminder=mod(m-2,2);
    %disp(reminder)
    if reminder==0
        numbint_left= (m-2)/2;
        numbint_right=numbint_left;
    else 
        numbint_right=(m-2-1)/2;
        numbint_left=numbint_right+1;
    end
    %disp(numbint_left)
    %disp(numbint_right)

    if (ileft-numbint_left)>=1 & (iright+numbint_right)<=nx_i
       lint=ileft-numbint_left;
       hint=iright+numbint_right;
   elseif (ileft-numbint_left)<1
       shift_to_r=numbint_left-(ileft-1);
       lint=1;
       hint=iright+numbint_right+shift_to_r;
    elseif(iright+numbint_right)>nx_i
        shift_to_left=iright+numbint_right-nx_i;
        lint=ileft-numbint_left-shift_to_left;
        hint=nx_i;
  
       
    end
end

    
lx=x_i(lint);
hx=x_i(hint);
%disp(lx)
%disp(hx)
%disp(lint)
%disp(hint)
end
