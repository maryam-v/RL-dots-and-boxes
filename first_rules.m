function [ rules ] = first_rules( ifbit,thenbit,Npop,error0,fi0,reward_range )
[ifs,thens]=rulemaker(ifbit,thenbit,Npop); % ifs and thens of rules
pred=reward_range(1) + (reward_range(2) -...
    reward_range(1)).*rand(Npop,1); % prediction of rules
error=(2+3*rand(Npop,1))*error0;
fitness=ones(Npop,1).*fi0; % fitness of rules
exp=zeros(Npop,1); % experience of rules
rules=[ifs,thens,fitness,pred,error,exp];
end

