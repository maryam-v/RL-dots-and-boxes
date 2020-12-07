function [ output ] = expert( inputstate )
[ state ] = stateconvertor( inputstate );
if any(sum(transpose(state))==3)
    row_3_edge=find(sum(transpose(state))==3);
    [~,a]=size(row_3_edge);
    o=row_3_edge(randi([1,a]));
    p=find(state(o,:)==0);
elseif any(sum(transpose(state))==2)
    row_2_edge=find(sum(transpose(state))==2);
    row_un2_edge=find(~ismember(1:36,row_2_edge));
    row_4_edge=find(sum(transpose(state(row_un2_edge,:)))==4);
    row_un2_edge=row_un2_edge(~ismember(1:size(row_un2_edge,2),row_4_edge));
    [~,a]=size(row_un2_edge);
    if a==0
        o=row_2_edge(randi([1,size(row_2_edge,2)]));
        c=find(state(o,:)==0);
        d=size(c,2);
        p=c(randi([1,d]));
    else
        o=row_un2_edge(randi([1,a]));
        c=find(state(o,:)==0);
        d=size(c,2);
        p=c(randi([1,d]));
    end
else
    [b,v]=find(state==0);
    [a,~]=size(b);
    t=randi([1,a]);
    o=b(t);
    p=v(t);
end
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
if inputstate(output(1),output(2))==1
    pause
end
end

