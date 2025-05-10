clc,clear
format compact
format short
%SIC:单品编码数据
%L1:SIC的长度
%CC:分类编码
%corrType:相应位置对应的分类编码
%编号对应关系:花叶类-1011010101-1;花菜类-1011010201-2;水生根茎类-1011010402-3;
%茄类-1011010501-4;辣椒类-1011010504-5;食用菌-1011010801-6
%TypeSales:6种单品在2020年7月1日至2023年6月30日的销量,下标对应分类
%a2STC:销量表中的单品编码数据
%L2:a2STC的长度
%SISales:销量表中的单品销量
%SISalesnum:统计销量表中的单品销量里的无效数据个数
%date:导入日期数据
%Sdate:经过处理的date数据,显示了每个日期跟2020年6月30日的差距天数.
%L3:Sdate中的最大数据,显示天数
%SingleSales:L1种单品在2020年7月1日至2023年6月30日的销量,每行是一种单品所有天数的销售额
%TypeSales:6种品类在2020年7月1日至2023年6月30日的销量,每行是一种品类所有天数的销售额
[numData1,textData1,rawData1] = xlsread('a1.xlsx');
SIC=textData1;
[numData2,textData2,rawData2] = xlsread('a2.xlsx');
CC=textData2;
L1=length(SIC);
corrType=zeros(L1,1);
search1='1011010101';
match1=ismember(CC,search1);
matchIndices1=find(match1);
corrType(matchIndices1)=1;
search2='1011010201';
match2=ismember(CC,search2);
matchIndices2=find(match2);
corrType(matchIndices2)=2;
search3='1011010402';
match3=ismember(CC,search3);
matchIndices3=find(match3);
corrType(matchIndices3)=3;
search4='1011010501';
match4=ismember(CC,search4);
matchIndices4=find(match4);
corrType(matchIndices4)=4;
search5='1011010504';
match5=ismember(CC,search5);
matchIndices5=find(match5);
corrType(matchIndices5)=5;
search6='1011010801';
match6=ismember(CC,search6);
matchIndices6=find(match6);
corrType(matchIndices6)=6;
[numData3,textData3,rawData3] = xlsread('a3.xlsx');
a2SIC=textData3;
L2=length(a2SIC);
SISales=readmatrix('a4.xlsx');
SISalesnum=sum(isnan(SISales));
date = importdata('a5.txt');
baseDate = datetime('2020-06-30', 'Format', 'yyyy-MM-dd');
Sdate= zeros(L2,1);
for i = 1:L2
    currentDate=datetime(date{i}, 'Format', 'yyyy-MM-dd');
    Sdate(i)=days(currentDate-baseDate);
end
L3=max(Sdate);
SingleSales=zeros(L1,L3);
TypeSales=zeros(6,L3);
change=importdata('change.txt');
search='销售';
for i=1:L2
    if strcmp(change(i),search) 
        day=Sdate(i);        %先确定这条数据的天数
        temp1=a2SIC(i);      %确定这条数据的单品编码
        temp2=find(ismember(SIC,temp1));    
        SingleSales(temp2,day)=SingleSales(temp2,day)+SISales(i);
        TypeSales(corrType(temp2),day)=TypeSales(corrType(temp2),day)+SISales(i);
    end
end
for i=1:6
    figure
    plot([1:1095],TypeSales(i,:));
end
index=[];
for i=1:1095
    if TypeSales(:,i)==0
        index=[index;i];
    end
end
writematrix(TypeSales,'TypeSales0.xlsx');
writematrix(SingleSales,'SingleSales0.xlsx');
TypeSales(:,index)=[];
SingleSales(:,index)=[];
writematrix(TypeSales,'TypeSales.xlsx');
writematrix(SingleSales,'SingleSales.xlsx');
writematrix(Sdate,'Sdate.xlsx');
writematrix(corrType,'corrType.xlsx');

















