function [ output ] = XCS_agent( rules,ifbit,thenbit,inputstate )
ifs=rules(:,1:ifbit);
thens=rules(:,ifbit+1:ifbit+thenbit);
fitness=rules(:,ifbit+thenbit+1);
pred=rules(:,ifbit+thenbit+2);
state=[inputstate(1,1:6),inputstate(2,:),inputstate(3,1:6),inputstate(4,:),inputstate(5,1:6),inputstate(6,:),...
    inputstate(7,1:6),inputstate(8,:),inputstate(9,1:6),inputstate(10,:),inputstate(11,1:6),...
    inputstate(12,:),inputstate(13,1:6)];
matchNum= matchnumber( state,ifs );
if isempty(matchNum)==0
    [~,l]=max(pred(matchNum).*fitness(matchNum));
    l=matchNum(l);
    m=binaryVectorToDecimal(thens(l,:));
    m=round((m*84)/127);
    if m==0
        m=1;
    end
end
if isempty(matchNum)==1 || state(m)==1
    l=(find(state==0));
    n=size(find(state==0),2);
    m=l(randi([1 n]));
end
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

