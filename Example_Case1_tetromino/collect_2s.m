function countset=collect_2s(M,N)
region=zeros(M+6,N+6);
region(4:M+3,4:N+3)=ones(M,N); %%在中心区域外设置3圈环绕
subset=[];
for i=1:M
    for j=1:N
       subset=[subset;up_right(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;down_right(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;up_left(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;down_left(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;right_up(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;left_up(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;right_down(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;left_down(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
%        subset=[subset;tetro_horizon(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
%        subset=[subset;tetro_vertical(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;tetro_matts(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;tetro_up(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;tetro_right(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;tetro_down(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;tetro_left(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;tetro_antithunder(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;tetro_thunder(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;tetro_thunderlay(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
       subset=[subset;tetro_antithunderlay(region,[i+3,j+3])-repmat([3,3,0,3,3,3,3,3,3,3,3,3,3],4,1)];
    end
end
[del_row,~]=find(subset==-3);
subset(del_row,:)=[];
countset=unique(subset,'rows');
end
function reback=up_right(region,location)
i=location(1);
j=location(2);
vector=[0 0 0 0 0 ;0 0 0 0 0; 0 0 1 0 0;0 0 1 1 1;0 0 0 0 0 ];
vector=[zeros(1,7);zeros(5,1),vector,zeros(5,1);zeros(1,7)];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),1,i-index_row(pp)+0.75,j-index_col(pp)+0.75];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=down_right(region,location)
i=location(1);
j=location(2);
vector=[0 0 0 0 0 ;0 0 0 0 0; 0 0 1 1 1;0 0 1 0 0;0 0 0 0 0 ];
vector=[zeros(1,7);zeros(5,1),vector,zeros(5,1);zeros(1,7)];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),2,i-index_row(pp)+0.25,j-index_col(pp)+0.75];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=up_left(region,location)%%%%%%%i,j不在四联网格上
i=location(1);
j=location(2);
vector=[0 0 0 0 0 ;0 0 0 0 0; 0 0 0 0 1;0 0 1 1 1;0 0 0 0 0 ];
vector=[zeros(1,7);zeros(5,1),vector,zeros(5,1);zeros(1,7)];
index=[0 2; 1 0 ; 1 1; 1 2];
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index(pp,1),index(pp,2)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index(pp,1),j-index(pp,2),3,i-index(pp,1)+0.75,j-index(pp,2)+1.25];
        for ii=1:4
            temp=[temp,i-index(pp,1)+index(ii,1),j-index(pp,2)+index(ii,2)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=down_left(region,location)
i=location(1);
j=location(2);
vector=[0 0 0 0 0 ;0 0 0 0 0; 0 0 1 1 1;0 0 0 0 1;0 0 0 0 0 ];
vector=[zeros(1,7);zeros(5,1),vector,zeros(5,1);zeros(1,7)];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),4,i-index_row(pp)+0.25,j-index_col(pp)+1.25];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=right_up(region,location)
i=location(1);
j=location(2);
vector=[0 0 0 0 0 ;0 0 0 0 0; 0 0 1 0 0;0 0 1 0 0;0 0 1 1 0 ];
vector=[zeros(1,7);zeros(5,1),vector,zeros(5,1);zeros(1,7)];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),5,i-index_row(pp)+1.25,j-index_col(pp)+0.25];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=left_up(region,location)%%%%%%%i,j不在四联网格上
i=location(1);
j=location(2);
vector=[0 0 0 0 0 ;0 0 0 0 0; 0 0 0 1 0;0 0 0 1 0;0 0 1 1 0 ];
vector=[zeros(1,7);zeros(5,1),vector,zeros(5,1);zeros(1,7)];
index=[0 1; 1 1 ; 2 0; 2 1];
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index(pp,1),index(pp,2)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index(pp,1),j-index(pp,2),6,i-index(pp,1)+1.25,j-index(pp,2)+0.75];
        for ii=1:4
            temp=[temp,i-index(pp,1)+index(ii,1),j-index(pp,2)+index(ii,2)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=right_down(region,location)
i=location(1);
j=location(2);
vector=[0 0 0 0 0 ;0 0 0 0 0; 0 0 1 1 0;0 0 1 0 0;0 0 1 0 0 ];
vector=[zeros(1,7);zeros(5,1),vector,zeros(5,1);zeros(1,7)];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),7,i-index_row(pp)+0.75,j-index_col(pp)+0.25];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=left_down(region,location)
i=location(1);
j=location(2);
vector=[0 0 0 0 0 ;0 0 0 0 0; 0 0 1 1 0;0 0 0 1 0;0 0 0 1 0 ];
vector=[zeros(1,7);zeros(5,1),vector,zeros(5,1);zeros(1,7)];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),8,i-index_row(pp)+0.75,j-index_col(pp)+0.75];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end
function reback=tetro_horizon(region,location)
i=location(1);
j=location(2);
vector=[0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,1,1,1,1;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),9,i-index_row(pp),j-index_col(pp)+1.5];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end
function reback=tetro_vertical(region,location)
i=location(1);
j=location(2);
vector=[0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,1,0,0,0;0,0,0,1,0,0,0;0,0,0,1,0,0,0;0,0,0,1,0,0,0];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),10,i-index_row(pp)+1.5,j-index_col(pp)];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end
function reback=tetro_matts(region,location)
i=location(1);
j=location(2);
vector=[0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,1,1,0,0;0,0,0,1,1,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),9,i-index_row(pp)+0.5,j-index_col(pp)+0.5];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=tetro_up(region,location)%%%%%%%i,j不在四联网格上
i=location(1);
j=location(2);
vector=[0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,1,0,0;0,0,0,1,1,1,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0];
index=[0 1; 1 0; 1 1; 1 2];
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index(pp,1),index(pp,2)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index(pp,1),j-index(pp,2),10,i-index(pp,1)+0.75,j-index(pp,2)+1];
        for ii=1:4
            temp=[temp,i-index(pp,1)+index(ii,1),j-index(pp,2)+index(ii,2)];
        end
        reback(pp,:)=temp;
    end
end
end


function reback=tetro_right(region,location)
i=location(1);
j=location(2);
vector=[0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,1,0,0,0;0,0,0,1,1,0,0;0,0,0,1,0,0,0;0,0,0,0,0,0,0];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),11,i-index_row(pp)+1,j-index_col(pp)+0.25];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end


function reback=tetro_down(region,location)
i=location(1);
j=location(2);
vector=[0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,1,1,1,0;0,0,0,0,1,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),12,i-index_row(pp)+0.25,j-index_col(pp)+1];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=tetro_left(region,location)%%%%%%%i,j不在四联网格上
i=location(1);
j=location(2);
vector=[0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,1,0,0;0,0,0,1,1,0,0;0,0,0,0,1,0,0;0,0,0,0,0,0,0];
index=[0 1; 1 0; 1 1; 2 1];
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index(pp,1),index(pp,2)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index(pp,1),j-index(pp,2),13,i-index(pp,1)+1,j-index(pp,2)+0.75];
        for ii=1:4
            temp=[temp,i-index(pp,1)+index(ii,1),j-index(pp,2)+index(ii,2)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=tetro_antithunder(region,location)%%%%%%%i,j不在四联网格上
i=location(1);
j=location(2);
vector=[0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,1,0,0;0,0,0,1,1,0,0;0,0,0,1,0,0,0;0,0,0,0,0,0,0];
index=[0 1; 1 0; 1 1; 2 0];
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index(pp,1),index(pp,2)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index(pp,1),j-index(pp,2),14,i-index(pp,1)+1,j-index(pp,2)+0.5];
        for ii=1:4
            temp=[temp,i-index(pp,1)+index(ii,1),j-index(pp,2)+index(ii,2)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=tetro_thunder(region,location)%%%%%%%i,j不在四联网格上
i=location(1);
j=location(2);
vector=[0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,1,0,0,0;0,0,0,1,1,0,0;0,0,0,0,1,0,0;0,0,0,0,0,0,0];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),15,i-index_row(pp)+1,j-index_col(pp)+0.5];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=tetro_thunderlay(region,location)%%%%%%%i,j不在四联网格上
i=location(1);
j=location(2);
vector=[0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,1,1,0;0,0,0,1,1,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0];
index=[0 1; 1 0; 1 1; 0 2];
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index(pp,1),index(pp,2)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index(pp,1),j-index(pp,2),16,i-index(pp,1)+0.5,j-index(pp,2)+1];
        for ii=1:4
            temp=[temp,i-index(pp,1)+index(ii,1),j-index(pp,2)+index(ii,2)];
        end
        reback(pp,:)=temp;
    end
end
end

function reback=tetro_antithunderlay(region,location)%%%%%%%i,j不在四联网格上
i=location(1);
j=location(2);
vector=[0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,1,1,0,0;0,0,0,0,1,1,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0];
[index_row,index_col]=find(vector==1);
index_row=index_row-index_row(1);
index_col=index_col-index_col(1);
reback=zeros(4,13);
for pp=1:4
    sumup=sum(sum(circshift(vector,-[index_row(pp),index_col(pp)]).*region(i-3:i+3,j-3:j+3)));
    if(sumup==4)
        temp=[i-index_row(pp),j-index_col(pp),17,i-index_row(pp)+0.5,j-index_col(pp)+1];
        for ii=1:4
            temp=[temp,i-index_row(pp)+index_row(ii),j-index_col(pp)+index_col(ii)];
        end
        reback(pp,:)=temp;
    end
end
end
