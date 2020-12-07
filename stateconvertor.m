function [ state ] = stateconvertor( stateinput )

state=zeros(36,4);
for i=1:4
    k=0;
    for j=1:36
        if mod(j,6)==0
            l=6;
        else
            l=mod(j,6);
        end
        if i==4
            state(j,i)=stateinput(2*k+2,l+1);
        else
            state(j,i)=stateinput(2*k+i,l);
        end
        if mod(j,6)==0
            k=k+1;
        end
    end
end

end

