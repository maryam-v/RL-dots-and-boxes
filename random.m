function [ output ] = random( inputstate )
[ state ] = stateconvertor( inputstate );
[b,v]=find(state==0);
[a,~]=size(b);
t=randi([1,a]);
o=b(t);
p=v(t);

if mod(o,6)~=0
    if p==1
        O=(floor(o/6))*2+1;
    elseif p==2 || p==4
        O=(floor(o/6))*2+2;
    elseif p==3
        O=(floor(o/6))*2+3;
    end
    if p==1 || p==2 || p==3
        P=mod(o,6);
    else
        P=mod(o,6)+1;
    end
else
    if p==1
        O=(floor(o/6)-1)*2+1;
    elseif p==2 || p==4
        O=(floor(o/6)-1)*2+2;
    elseif p==3
        O=(floor(o/6)-1)*2+3;
    end
    if p==1 || p==2 || p==3
        P=6;
    else
        P=7;
    end
end
output=[O,P];
end

