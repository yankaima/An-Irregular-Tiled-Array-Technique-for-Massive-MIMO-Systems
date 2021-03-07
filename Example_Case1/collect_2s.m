function countset=collect_2s(M,N)
region=zeros(M+2,N+2);
region(2:M+1,2:N+1)=ones(M,N);
%%在中心区域外设置一圈环绕
subset=zeros(M*N*4,3);
count=1;
for i=1:M
    for j=1:N
        if leftjudge(region,[i+1,j+1])==2   %%+1其实是因为外面加了一圈环绕
            subset(count,:)=[i,j-1,2];
            count=count+1;
        end
        if upjudge(region,[i+1,j+1])==2%%+1其实是因为外面加了一圈环绕
            subset(count,:)=[i-1,j,1];
            count=count+1;
        end
         if rightjudge(region,[i+1,j+1])==2%%+1其实是因为外面加了一圈环绕
            subset(count,:)=[i,j,2];
            count=count+1;
         end
         if downjudge(region,[i+1,j+1])==2%%+1其实是因为外面加了一圈环绕
            subset(count,:)=[i,j,1];
            count=count+1;
         end
    end
end
countset=unique(subset,'rows');
countset(1,:)=[];



end
function reback=leftjudge(region,location)
i=location(1);
j=location(2);
left=[1,1];
reback=sum(left.*[region(i,j-1),region(i,j)]);
end
function reback=upjudge(region,location)
i=location(1);
j=location(2);
up=[1;1];
reback=sum(up.*[region(i-1,j);region(i,j)]);
end
function reback=rightjudge(region,location)
i=location(1);
j=location(2);
right=[1,1];
reback=sum(right.*[region(i,j),region(i,j+1)]);
end
function reback=downjudge(region,location)
i=location(1);
j=location(2);
down=[1;1];
reback=sum(down.*[region(i,j);region(i+1,j)]);
end