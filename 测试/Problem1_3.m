clc,clear
format compact
format short
%c2:251种单品的上三角相关系数矩阵
%row1,col1:弱相关性商品对坐标
%row2,col2:中相关性商品对坐标
%row3,col3:强相关性商品对坐标
%L:弱、中、强相关性商品对的数量
c2=readmatrix('SingleCoref.xlsx');
for i=1:251
    for j=1:i
        c2(i,j)=0;
    end
end
[row1,col1]=find(abs(c2)>0.1&abs(c2)<=0.3);
[row2,col2]=find(abs(c2)>0.3&abs(c2)<=0.5);
[row3,col3]=find(abs(c2)>0.5);
L=[length(row1),length(row2),length(row3)]
writematrix([row1,col1],'weak.xlsx');
writematrix([row2,col2],'middle.xlsx');
writematrix([row3,col3],'strong.xlsx');