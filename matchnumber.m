function [ matchNum ] = matchnumber( example,ifs )
[m,n]=size(ifs);
matchset=zeros(size(ifs));
for i=1:m
    for j=1:n
        if ifs(i,j)==example(1,j) || ifs(i,j)==2
            matchset(i,j)=1;
        end
    end
end
p=sum(transpose(matchset));
matchNum=find(p==n);
end

