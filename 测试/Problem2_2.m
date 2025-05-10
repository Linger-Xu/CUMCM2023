clc,clear
format compact
format short
%本文件是对附件3的数据进行处理
%CostTable:251*1095的矩阵,用于记录每天各个单品的成本价格
%cSdate:附件3每条记录对应的天数
%cSIC:附件3每条记录对应的单品编号
[numData1,textData1,rawData1] = xlsread('a1.xlsx');
SIC=textData1;   
cdate = importdata('c1.txt');
Lcdate=length(cdate);
baseDate = datetime('2020-06-30', 'Format', 'yyyy-MM-dd');
date= zeros(Lcdate,1);
for i = 1:Lcdate
    currentDate=datetime(cdate{i}, 'Format', 'yyyy-MM-dd');
    cSdate(i)=days(currentDate-baseDate);
end
[numData2,textData2,rawData2] = xlsread('c3.xlsx');
cSIC=textData2;
cost=readmatrix('c4.xlsx');
for i=1:Lcdate
    temp1=find(ismember(SIC,cSIC(i)));
    CostTable(temp1,cSdate(i))=cost(i);
end
writematrix(CostTable,'CostTable.xlsx');


