clc,clear
format compact
format short g
SISalesTable=readmatrix('SISalesTable.xlsx');
SIPriceTable=readmatrix('SIPriceTable.xlsx');
SICostTable=readmatrix('SICostTable.xlsx');
%本文件的作用在于选出利润贡献率最高的前33种,并预测它们在7月1号的销量
%排名
SIProfitTable=zeros(61,2);
SIProfitTable(:,1)=SISalesTable(:,1);
SIProfitTable(:,2)=sum(SIPriceTable(:,2:end)-SICostTable(:,2:end),2);
[temp,I]=sort(SIProfitTable(:,2),'descend');
SIProfitTable33=SIProfitTable(I,:);


%delta:承接相对误差
%uu:33*3的矩阵,用于承接系数
%yuece:33*7的矩阵,用于承接预测值
%pre:承接预测值
%Eps:33*7的矩阵,用于承接残差
%Del:33*7的矩阵,用于承接误差比

for i=1:61
    temp1=SIProfitTable33(i,1);
    SISalesTable33(i,1)=SIProfitTable33(i,1);
    temp2=find(ismember(SISalesTable(:,1),temp1));
    x0=SISalesTable(temp2,2:end);
    SISalesTable33(i,2:8)=x0;
%GM(2,1)
    n=length(x0);
    x1=cumsum(x0);
    a_x0=diff(x0)';         %计算一次累减序列
    z=0.5*(x1(1:end-1)+x1(2:end))';
    B=[-x0(2:end)',-z,ones(n-1,1)];
    u=B\a_x0;
    uu(i,:)=u';
    syms x(t)
    x=dsolve(diff(x,2)+u(1)*diff(x)+u(2)*x==u(3),x(0)==x1(1),x(6)==x1(7));
    %利用边界条件求符号解(dsolve求符号解的时候既可以是初值条件也可以是边界条件)
    xt=vpa(x,6);
    yuce=subs(x,t,0:n-1);
    yuce=double(yuce);
    x0_hat=[yuce(1),diff(yuce)];
    pre(i,:)=x0_hat;
    y=subs(x,t,0:n);
    y=double(y);
    xx=[y(1),diff(y)];
    p(i,:)=xx;
    epsilon=x0-x0_hat;
    Eps(i,:)=epsilon;
    delta=abs(epsilon./x0);  %求相对误差
    Del(i,:)=delta;
end

p(:,end+1)=SISalesTable33(:,1);
writematrix(SISalesTable33,'SISalesTable33.xlsx');
writematrix(p,'ppt.xlsx');



      
      
        


