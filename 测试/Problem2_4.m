clc,clear
format compact
format short
%本文件用于建立售价和销售量的回归模型以及建立成本和销售量的关系
%beta:2*6的矩阵,用于存储6个回归模型的回归系数
%Fa:模型检验系数
%F:1*6的矩阵用于存储F统计量,用于检验模型
TypePriceTable=readmatrix('TypePriceTable0.xlsx');
TypeCostTable=readmatrix('TypeCostTable0.xlsx');
TypeSales=readmatrix('TypeSales0.xlsx');
m=1;n=1085;
Fa=finv(0.99,m,n-m-1);
for i=1:6
    c=regstats(TypePriceTable(i,:),TypeSales(i,:));
    beta(i,:)=c.beta;
    F(i)=c.fstat.f;
end
writematrix(beta,'beta.xlsx');
for i=1:6
    c=regstats(TypeCostTable(i,:),TypeSales(i,:));
    bbeta(i,:)=c.beta;
    FF(i)=c.fstat.f;
end
Fa
F,FF
beta,bbeta
writematrix(bbeta,'bbeta.xlsx');





