clc,clear
format compact
format short
%本文件用于分析利率

index=[226,227,580,855,857,883,884,885,886,935];
TypeSales=readmatrix('TypeSales.xlsx');
SingleSales=readmatrix('SingleSales.xlsx');
TypeCostTable=readmatrix('TypeCostTable.xlsx');
TypePriceTable=readmatrix('TypePriceTable.xlsx');

m1=min(sum(TypePriceTable-TypeCostTable));
m2=max(sum(TypePriceTable-TypeCostTable));

plot(sum(TypePriceTable-TypeCostTable))


