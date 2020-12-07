function [correct] = tester( test,ifs,thens,pred,fitness)
ca=0;
for i=1:size(test,1)
    matchNum= matchnumber( test(i,:),ifs );
    if isempty(matchNum)==0
        [~,d]=max(pred(matchNum).*fitness(matchNum));
        d=matchNum(d);
        if thens(d,:)==test(i,size(ifs,2)+1:size(ifs,2)+size(thens,2))
            ca=ca+1;
        end
    end
end
correct=(ca/size(test,1))*100;
end

