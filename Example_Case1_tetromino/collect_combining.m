function combining=collect_combining(countset,M,N)
combining=zeros(M*N,size(countset,1));
for nn=1:size(countset,1)
ind=countset(nn,6:end);
    combining((ind(1)-1)*N+ind(2),nn)=1;
    combining((ind(3)-1)*N+ind(4),nn)=1;
    combining((ind(5)-1)*N+ind(6),nn)=1;
    combining((ind(7)-1)*N+ind(8),nn)=1;  
end