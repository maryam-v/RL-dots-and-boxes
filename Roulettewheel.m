function [ RWA ] = Roulettewheel( actionset,matchNum,pred,fitness )

 %fitness weighted prediction
[s2,~]=size(find(~actionset));
avg_pred=zeros(s2-1,1);
w=2;
for i=1:s2-1
    s1=0;
    s3=0;
    while actionset(w)~=0
        s1=s1+pred(matchNum(actionset(w)))*fitness(matchNum(actionset(w)));
        s3=s3+fitness(matchNum(actionset(w)));
        w=w+1;            
    end
    avg_pred(i)=s1/s3;
    w=w+1;
end
%% choosing rule
rw=avg_pred/sum(avg_pred);
[s4,~]=size(avg_pred);
s5=0;
RW=zeros(s4+1,1);
for i=1:s4
   s5=rw(i)+s5;
   RW(i+1,1)=s5;
end
randNum=rand;
for i=1:s4
    if randNum>=RW(i) && randNum<RW(i+1)
        RWA=find(RW==RW(i));
    end
end

end

