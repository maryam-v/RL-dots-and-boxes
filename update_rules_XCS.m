function [ rules ] = update_rules_XCS( rules,reward,action,ifbit,thenbit,Beta,Gama,error0 )
fitness=rules(:,ifbit+thenbit+1);
pred=rules(:,ifbit+thenbit+2);
error=rules(:,ifbit+thenbit+3);
exp=rules(:,ifbit+thenbit+4);
k=zeros(size(action,1),1);
for i=1:size(action,1)
    exp(action(i))=exp(action(i))+1;
    if exp(action(i))<1/Beta
        error(action(i))=error(action(i))+(abs(reward-pred(action(i)))-...
            error(action(i)))/(exp(action(i))+1);
        pred(action(i))=pred(action(i))+(reward-pred(action(i)))...
            /(exp(action(i))+1);
    else
        error(action(i))=error(action(i))+(abs(reward-pred(action(i)))-...
            error(action(i)))*Beta;
        pred(action(i))=pred(action(i))+(reward-pred(action(i)))*Beta;
    end
    if error(action(i))<error0
        k(i)=1;
    else
        k(i)=((error(action(i))/error0)^-Gama)*Beta;
    end
    
end

for i=1:size(action,1)
    fitness(action(i))=fitness(action(i)) + Beta * ( ( k(i) / sum(k) ) -...
        fitness (action(i)) );
end
rules=[rules(:,1:ifbit+thenbit),fitness,pred,error,exp];
end