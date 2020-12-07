function [ ifs_cover,thens_cover ] = covering( example,matchset )
ifs_cover=zeros(1,size(example,2));
thens_cover=zeros(1,(size(matchset,2)-size(example,2)));
s=ones(1,size(matchset,1));
for i=1:size(example,2)
   randnum=rand;
   if randnum>=0 && randnum<0.5
       ifs_cover(1,i)=2;
   elseif randnum>=0.5 && randnum<=1
       ifs_cover(1,i)=example(1,i);
   end
end
while any(s)==1
    for i=1:(size(matchset,2)-size(example,2))
        randnum=rand;
        if randnum>=0 && randnum<=0.5
            thens_cover(1,i)=1;
        elseif randnum>=0.5 && randnum<=1
            thens_cover(1,i)=0;
        end
    end
    for i=1:size(matchset,1)
        s(i)=all(isequal(thens_cover,matchset(i,(size(example,2)+1):size(matchset,2))));
    end
end
end

