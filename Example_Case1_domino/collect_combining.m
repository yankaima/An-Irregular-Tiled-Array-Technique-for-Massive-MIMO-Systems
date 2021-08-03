function combining=collect_combining(countset,M,N)
combining=zeros(M*N,size(countset,1));
for nn=1:size(countset,1)
    xxx=countset(nn,:);
    if (xxx(3)==2)  %%horital
        vert=[xxx(1:2),xxx(1),xxx(2)+1];
    else       %%verticle
        vert=[xxx(1:2),xxx(1)+1,xxx(2)];
    end
    combining((vert(2)-1)*N+vert(1),nn)=1;
    combining((vert(4)-1)*N+vert(3),nn)=1;    
end