function [ m ] = squares( i,j )
if rem(i,2)==0
    if j==1
        m=(i/2-1)*6+j;        
    elseif j==7
        m=i*3;        
    else
        m=[(i/2-1)*6+j-1,(i/2-1)*6+j];       
    end
else
    if i==1
        m=j;
    elseif i==13
        m=30+j;
    else
        m=[(floor(i/2)-1)*6+j,(floor(i/2))*6+j];
    end
end

end

