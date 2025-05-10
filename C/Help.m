for i=1:L2
    temp1=find(ismember(SIC,a2SIC(i))); %找到这条记录对应的编号
    TypeCostTable(corrType(temp1),Sdate(i))=TypeCostTable(corrType(temp1),Sdate(i))+SISales(i)*CostTable(temp1,Sdate(i));
    TypePriceTable(corrType(temp1),Sdate(i))=TypePriceTable(corrType(temp1),Sdate(i))+SISales(i)*SIPrice(i);
end