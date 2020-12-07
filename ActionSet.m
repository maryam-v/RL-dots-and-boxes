function [ actionset ] = ActionSet( ifs,thens,matchNum )
matchset=[ifs(matchNum,:),thens(matchNum,:)];
ms=matchset;
s=size(ifs);
l=1;
actionset(l,1)=0;
while isempty(ms)==0
    [~,u0]=ismember(matchset(:,s(2)+1:end),ms(1,s(2)+1:end),'rows');
    [~,u1]=ismember(ms(:,s(2)+1:end),ms(1,s(2)+1:end),'rows');
    d1=find(u1);
    d=find(u0);
    [o,~]=size(d);
    l=l+o;
    actionset((l-o+1):l,1)=d(:,1); 
    ms = ms(~ismember(1:size(ms,1), d1), :); 
    l=l+1;
    actionset(l,1)=0;
end
end

