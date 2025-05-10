clc,clear
format compact
%formattedDate1:销量很高的点的日期
%formattedDate2:销量为0的点的日期
%c1:6种品类的相关系数矩阵
%c2:251种单品的相关系数矩阵
format short
L=1085;
SingleSales=readmatrix('SingleSales.xlsx');
TypeSales=readmatrix('TypeSales.xlsx');
for i=1:6
    figure
    plot([1:L],TypeSales(i,:));
end
c1=corrcoef(TypeSales')
c2=corrcoef(SingleSales');
figure
plot([1:L],TypeSales(1,:),'r-');
hold on
plot([1:L],TypeSales(2,:),'b--');
plot([1:L],TypeSales(3,:),'g:');
plot([1:L],TypeSales(4,:),'m-');
plot([1:L],TypeSales(5,:),'c--');
plot([1:L],TypeSales(6,:),'k:')
hold off
writematrix(c2,'SingleCoref.xlsx');
% 使用heatmap创建热图
figure
h = heatmap(c1);
colorbar;
h.FontSize = 10;
h.XDisplayLabels = cellstr(h.XDisplayLabels); % 将X轴刻度标签转换为字符串数组
h.YDisplayLabels = cellstr(h.YDisplayLabels); % 将Y轴刻度标签转换为字符串数组



