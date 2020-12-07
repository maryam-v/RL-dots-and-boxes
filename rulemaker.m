function [ifs,thens]=rulemaker(ifbit,thenbit,Npop)
ifs=zeros(Npop,ifbit);
thens=zeros(Npop,thenbit);
for j=1:ifbit
    for i=1:Npop
        randnum=rand;
        if randnum>=0 && randnum<0.5
            ifs(i,j)=2;
        elseif randnum>=0.5 && randnum<0.75
            ifs(i,j)=1;
        elseif randnum>=0.75 && randnum<=1
            ifs(i,j)=0;
        end
    end
end
for j=1:thenbit
    for i=1:Npop
        randnum=rand;
        if randnum>=0 && randnum<=0.5
            thens(i,j)=1;
        elseif randnum>=0.5 && randnum<=1
            thens(i,j)=0;
        end
    end
end
end