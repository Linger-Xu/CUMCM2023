clc,clear
format compact
SingleSales=readmatrix('SingleSales.xlsx');
%本文件用于对单品进行聚类分析

a=SingleSales;
b=zscore(a);                        %数据标准化
r=corrcoef(b);                      %计算相关系数矩阵
%d=tril(1-r);d=nonzeros(d)';        %另一种计算距离方法
z=linkage(b','average','correlation');       %按类平均法聚类
%correlation表示类之间的距离用1-相关系数
h=dendrogram(z);
set(h,'Color','k','LineWidth',1.3)  
T=cluster(z,'maxclust',12);           %把变量分成12类
for i=1:12
    tm=find(T==i);
    fprintf('第%d类的有%s\n',i,int2str(tm'));
end


T=[1081,619,878,756,529,461,1,75,223,873,580,706];
T=sort(T);

figure
a=a(:,T);
b=zscore(a);
z=linkage(b,'average');
h=dendrogram(z);
set(h,'Color','k','LineWidth',1.3)
for k=5
    fprintf('划分为%d类的结果如下:\n',k)
    T=cluster(z,'maxclust',k);
    for i=1:k
        tm=find(T==i);
        fprintf('第%d类的有:%s\n',i,int2str(tm'));  %显示分类结果
    end
    fprintf('*******************************************\n')
end

A=[1 81 89 149 241];
for i=1:5
    figure
    plot(SingleSales(A(i),:));
end


