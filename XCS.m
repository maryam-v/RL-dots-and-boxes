function [ rules,action,output ] = XCS( rules,inputstate,Asmin,ifbit,thenbit,Npop,error0,fi0,reward_range )
ifs=rules(:,1:ifbit);
thens=rules(:,ifbit+1:ifbit+thenbit);
fitness=rules(:,ifbit+thenbit+1);
pred=rules(:,ifbit+thenbit+2);
error=rules(:,ifbit+thenbit+3);
exp=rules(:,ifbit+thenbit+4);
state=[inputstate(1,1:6),inputstate(2,:),inputstate(3,1:6),inputstate(4,:),inputstate(5,1:6),inputstate(6,:),...
    inputstate(7,1:6),inputstate(8,:),inputstate(9,1:6),inputstate(10,:),inputstate(11,1:6),...
    inputstate(12,:),inputstate(13,1:6)];

matchNum = matchnumber( state,ifs );
matchset=[ifs(matchNum,:),thens(matchNum,:)];
actionset  = ActionSet( ifs,thens,matchNum );
[d,~]=size(find(~actionset));d=d-1;
if d<Asmin
    ifs_cover=zeros((Asmin-d),ifbit);
    thens_cover=zeros((Asmin-d),thenbit);
    for i=1:Asmin-d 
        [ifs_cover(i,:),thens_cover(i,:)]=covering(state,matchset);
        randnum=rand;
        rev_fit=1./fitness;
        e1=rev_fit/sum(rev_fit);
        e2=0;
        e3=zeros(1,Npop+1);
        
        % roulette wheel based on inverse of fitness:
        for j=1:Npop
            e2=e2+e1(j);
            e3(j+1)=e2;
            if randnum>=e3(j) && randnum<e3(j+1)
                rule_omit=j;
                break
            end
        end
        % if deleted rule is a member of matched rule:
        while ismember(rule_omit,matchNum)==1
            randnum=rand;
            e2=0;
            e3=zeros(1,Npop+1);
            for j=1:Npop
                e2=e2+e1(j);
                e3(j+1)=e2;
                if randnum>=e3(j) && randnum<e3(j+1)
                    rule_omit=j;
                    break
                end
            end
        end

        ifs(rule_omit,:)=ifs_cover(i,:);
        thens(rule_omit,:)=thens_cover(i,:);
        pred(rule_omit)=reward_range(1) +...
            (reward_range(2) - reward_range(1)).*rand;
        fitness(rule_omit)=fi0;
        exp(rule_omit)=0;
        error(rule_omit)=rand*error0;
        
        % remake matchset and actionset:
        matchNum= matchnumber( state,ifs );
        matchset=[ifs(matchNum,:),thens(matchNum,:)];
        [actionset]= ActionSet( ifs,thens,matchNum );
    end
end

RWA = Roulettewheel( actionset,matchNum,pred,fitness );
d=find(~actionset);
d1=d(RWA+1)-d(RWA)-1;
d2=zeros(d1,1);
for i=1:d1
    d2(i)=matchNum(actionset(d(RWA)+i));
end
rules=[ifs,thens,fitness,pred,error,exp];
action=d2;
m=binaryVectorToDecimal(thens(action(1),:));
if m==0
    m=1;
end
m=round((m*84)/127);
if mod(m,13)==0
    output(1)=floor(m/13)*2;
    output(2)=7;
elseif mod(m,13)<=6 && mod(m,13)>0
    output(1)=floor(m/13)*2 + 1;
    output(2)=m-floor(m/13)*13;
elseif mod(m,13)>6
    output(1)=(floor(m/13)+1)*2;
    output(2)=m-(floor(m/13)*13+6);
end
end

