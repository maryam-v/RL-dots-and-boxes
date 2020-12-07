clc
clear
% ruler=load('matlab_XCS.mat');
% ruler=ruler.rules;
ifbit=84;
thenbit=7;
Npop=5000;
error0=0.1;
fi0=0.05;
reward_range=[0 60];
Asmin=20;
Beta=0.2;
Gama=5;
Pmut=0.05;
Rcross=0.75;
rules= first_rules( ifbit,thenbit,Npop,error0,fi0,reward_range );
for i=1:100
    Score_XCS=0;
    state=zeros(13,7);
    tic
    while sum(sum(state))<84
        [rules,action,output] = XCS( rules,state,Asmin,ifbit,thenbit,Npop,error0,fi0,reward_range );
        if state(output(1),output(2))==0
            state(output(1),output(2))=1;
            conv=stateconvertor(state);
            squ=squares(output(1),output(2));
            if size(squ,2)==2
                square1=sum(conv(squ(1),:));
                square2=sum(conv(squ(2),:));
                if square1==4 && square2==4
                    Reward=60;
                    Score_XCS=Score_XCS+2;
                elseif square1==4 || square2==4
                    Reward=30;
                    Score_XCS=Score_XCS+1;
                else
                    Reward=2;
                end
            else
                if (sum(conv(squ,:)))==4
                    Reward=30;
                    Score_XCS=Score_XCS+1;
                else
                    Reward=2;
                end
            end
        else
            Reward=0;
        end
        rules=update_rules_XCS(rules,Reward,action,ifbit,thenbit,Beta,Gama,error0);
        if sum(sum(state))==84
            break
        end
%         output=XCS_agent(ruler,ifbit,thenbit,state);
        if mod(i,5)==0
            output=expert(state);
        else
            output=random(state);
        end
        if state(output(1),output(2))==0
            state(output(1),output(2))=1;
        end
        
    end
    toc
    Reward=Score_XCS;
    action=1:Npop;
    rules=update_rules_XCS(rules,Reward,action,ifbit,thenbit,Beta,Gama,error0);
    disp(['XCS score:    ',num2str(Score_XCS)])
    disp(['expert score: ',num2str(36-Score_XCS)])
%     disp(['XCS score:',num2str(xcs_score)])
%     disp(['XCS agent score:',num2str(36-xcs_score)])
    rules= Genetic( rules,ifbit,thenbit,Npop,state,Rcross,Pmut );
    
end