clc,clear
format compact
format short
%该部分计算各品类的成本加成系数
%某品类在某天的成本=改品类下各单品销量乘上成本价格
%TypeCostTable:6*1095的矩阵,记录每个品类每天的总进货成本
%TypePriceTable:6*1095的矩阵,记录每个品类每天的总销售额
%TypeCPCTable:6*1095矩阵,成本定价系数表
index=[226,227,580,855,857,883,884,885,886,935];
SISales=readmatrix('a4.xlsx');      %每一笔记录对应的销售量
Sdate=readmatrix('Sdate.xlsx');     %每一笔记录对应是第几天
SIPrice=readmatrix('a6.xlsx');      %每一笔记录对应的销售单价
[numData1,textData1,rawData1] = xlsread('a1.xlsx');
SIC=textData1;                      %SIC
corrType=readmatrix('corrType.xlsx');   %记录SIC对应的品类
TypeCostTable=zeros(6,1095);
TypePriceTable=zeros(6,1095);
CostTable=readmatrix('CostTable.xlsx'); %记录每个单品每天的进价
[numData2,textData2,rawData2] = xlsread('a3.xlsx');
a2SIC=textData2;                    %每一笔记录对应的单品编号
L2=length(a2SIC);

change=importdata('change.txt');
search='销售';

TypeCPCTable2=zeros(6,1095);

for i=1:L2
    if strcmp(change(i),search)
        temp1=find(ismember(SIC,a2SIC(i))); %找到这条记录对应的编号
        TypeCostTable(corrType(temp1),Sdate(i))=TypeCostTable(corrType(temp1),Sdate(i))+SISales(i)*CostTable(temp1,Sdate(i));
        TypePriceTable(corrType(temp1),Sdate(i))=TypePriceTable(corrType(temp1),Sdate(i))+SISales(i)*SIPrice(i);
    end 
end

TypeSales=readmatrix('TypeSales0.xlsx');
for i=1:L2
    if strcmp(change(i),search)
        temp1=find(ismember(SIC,a2SIC(i))); %找到这条记录对应的编号
        p=(SIPrice(i)-CostTable(temp1,Sdate(i)))/CostTable(temp1,Sdate(i));
        TypeCPCTable2(corrType(temp1),Sdate(i))=TypeCPCTable2(corrType(temp1),Sdate(i))+p*SISales(i)/TypeSales(corrType(temp1),Sdate(i));
    end
end

writematrix(TypeCostTable,'TypeCostTable0.xlsx');
writematrix(TypePriceTable,'TypePriceTable0.xlsx');


TypeCostTable(:,index)=[];
TypePriceTable(:,index)=[];

writematrix(TypeCostTable,'TypeCostTable.xlsx');
writematrix(TypePriceTable,'TypePriceTable.xlsx');



TypeCPCTable=(TypePriceTable-TypeCostTable)./TypeCostTable;
writematrix(TypeCPCTable,'TypeCPCTable.xlsx');

TypeCPCTable2(:,index)=[];
writematrix(TypeCPCTable2,'TypeCPCTable2.xlsx')




