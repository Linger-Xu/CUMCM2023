clc,clear
format compact
format short
%本文件使用AR时间序列法来分析销售量和时间之间的关系,并预测未来一周的销售量
%QS:记录6个时间序列模型的qs值
%T:记录6个时间序列的统计量的值
%Pre:6*7矩阵,用来承接6种品类2023年7月1日-7月7日的预测销售量
TypeSales=readmatrix('TypeSales.xlsx');
for i=1:6
    a=TypeSales(i,:);
    Rt=tiedrank(a);                      %求原始时间序列的秩
    n=length(a);t=1:n;
    t_0=tinv(0.975,n-2);
    Qs(i)=1-6/(n*(n^2-1))*sum((t-Rt).^2);   %计算Qs的值
    T(i)=Qs(i)*sqrt(n-2)/sqrt(1-(Qs(i))^2);         %计算T统计量的值                 
    if T(i)>t_0
        b=diff(a);                          %求原始时间序列的一阶差分
        m=ar(b,2,'ls')                     %利用最小二乘法估计模型的参数
        bhat=predict(m,b');                 %求预测值，第二个参数必须为列向量
        bhat(end+1)=forecast(m,b',1);        %计算1个预测值，第二个参数必须为列向量
        ahat=[a(1),a+bhat'];                 %求原始数据的预测值，并计算t=15的预测值
        k=forecast(m,b',7);
        Pre(i,1)=ahat(end);
        for j=2:7
            Pre(i,j)=Pre(i,j-1)+k(j);
        end
    end
    if T(i)<=t_0
        m=ar(a,2,'ls')
        ahat=predict(m,a');
        Pre(i,1:7)=forecast(m,a',7);
    end
    figure,hold on
    plot(a);
    plot(ahat,'r');
    hold off
end

writematrix(Pre,'Pre.xlsx');



