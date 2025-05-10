clc,clear
format compact
format short
%discount:2020年7月1日至2023年6月30日打折的情况
%Lcount:打折订单数量
%dSIC:附件4中的商品编码
%LossRate:对应的损耗率
%itemLossRate:第一列对应打折的商品序列(SIC中),第二列对应其磨损率
discount=importdata('discount.txt');
search='是';
Ldiscount=sum(ismember(discount,search));
[numData1,textData1,rawData1] = xlsread('d1.xlsx');
dSIC=textData1;
LossRate=readmatrix('d2.xlsx');
[numData2,textData2,rawData2] = xlsread('a1.xlsx');
SIC=textData2;
[numData3,textData3,rawData3] = xlsread('a3.xlsx');
a2SIC=textData3;
flag=1;
for i=1:length(discount)
    if strcmp(discount(i),'是')
        temp1=find(ismember(SIC,a2SIC(i)));
        itemLossRate(flag,1)=temp1;
        temp2=find(ismember(dSIC,a2SIC(i)));
        itemLossRate(flag,2)=LossRate(temp2);
        flag=flag+1;
    end
end
[C,ia,ic]=unique(itemLossRate(:,1),'rows');
itemLossRate=itemLossRate(ia,:);
writematrix(itemLossRate,'itemlossrate.xlsx');
