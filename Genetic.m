function [ rules ] = Genetic( rules,ifbit,thenbit,Npop,inputstate,Rcross,Pmut )
ifs=rules(:,1:ifbit);
thens=rules(:,ifbit+1:ifbit+thenbit);
fitness=rules(:,ifbit+thenbit+1);
pred=rules(:,ifbit+thenbit+2);
error0=rules(:,ifbit+thenbit+3);
exp=rules(:,ifbit+thenbit+4);
example=[inputstate(1,1:6),inputstate(2,:),inputstate(3,1:6),inputstate(4,:),inputstate(5,1:6),inputstate(6,:),...
    inputstate(7,1:6),inputstate(8,:),inputstate(9,1:6),inputstate(10,:),inputstate(11,1:6),...
    inputstate(12,:),inputstate(13,1:6)];
d1=Npop;
d2=1:Npop;
fp=fitness(d2)/sum(fitness(d2));
fpr=zeros(d1+1,1);
chromosom=zeros(2,ifbit+thenbit);
choromno=zeros(2,1);

for j=1:2
    randnum=rand;
    g=0;
    for i=1:d1
        g=g+fp(i);
        fpr(i+1)=g;
        if randnum>=fpr(i) && randnum<fpr(i+1)
            chromosom(j,:)=[ifs(d2(i),:),thens(d2(i),:)];
            choromno(j)=d2(i);
            break
        end
    end
end

% cross over:
randnum=rand;
if randnum<=Rcross
    crossf=(0:ifbit)/ifbit;
    randnum=rand;
    for i=1:ifbit
        if randnum>=crossf(i) && randnum<crossf(i+1)
            break
        end
    end
    if i<=ifbit
        ifs(choromno(1),i+1:end)=chromosom(2,i+1:ifbit);
        ifs(choromno(2),i+1:end)=chromosom(1,i+1:ifbit);
        chromosom(1,1:ifbit)=ifs(choromno(1),:);
        chromosom(2,1:ifbit)=ifs(choromno(2),:);
    end
end

% mutation:
for j=1:2
    for i=1:ifbit+thenbit
        randnum=rand;
        if randnum<=Pmut
            if chromosom(j,i)==2
                chromosom(j,i)=example(i);
            elseif i<=ifbit && (chromosom(j,i)==0 || chromosom(j,i)==1)
                randnum=rand;
                if randnum<=.5
                    chromosom(j,i)=2;
                else
                    chromosom(j,i)=example(i);
                end
            elseif i>ifbit && chromosom(j,i)==0
                chromosom(j,i)=1;
            elseif i>ifbit && chromosom(j,i)==1
                chromosom(j,i)=0;
            end
        end
    end
end
% updating specifications of children
ch_fit=0.05*[fitness(choromno(1))+fitness(choromno(2));...
    fitness(choromno(1))+fitness(choromno(2))];
ch_pred=0.5*[pred(choromno(1))+...
    pred(choromno(2));pred(choromno(1))+...
    pred(choromno(2))];
ch_error=0.1250*[error0(choromno(1))+error0(choromno(2));...
    error0(choromno(1))+error0(choromno(2))];
% create temprory fitness matrices to choose two wheel
temp_fit=1./[fitness;ch_fit];
temp_rw=temp_fit/sum(temp_fit);
rule_omit=zeros(2,1);
for j=1:2
    randnum=rand;
    e=0;
    e1=zeros(1,size(temp_rw,1)+1);
    for i=1:size(temp_rw,1)
        e=e+temp_rw(i);
        e1(i+1)=e;
        if randnum>=e1(i) && randnum<e1(i+1)
            rule_omit(j)=i;
            break
        end
    end
end
for j=1:2
    if rule_omit(j)==Npop+1 || rule_omit(j)==Npop+2
        % child will be removed
    else
        ifs(rule_omit(j),:)=chromosom(j,1:ifbit);
        thens(rule_omit(j),:)=chromosom(j,ifbit+1:ifbit+thenbit);
        pred(rule_omit(j))=ch_pred(j);
        fitness(rule_omit(j))=ch_fit(j);
        error0(rule_omit(j))=ch_error(j);
        exp(rule_omit(j))=0;
    end
end
rules=[ifs,thens,fitness,pred,error0,exp];
end

