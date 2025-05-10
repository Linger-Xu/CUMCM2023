clc,clear 
format compact
format short
%本文件用于制定单品策略
pre=readmatrix('ppt.xlsx');
index33=pre(:,end);
p4SingleCost=readmatrix('p4SingleCost.xlsx');
p4SinglePrice=readmatrix('p4SinglePrice.xlsx');
p4SICPC=(p4SinglePrice-p4SingleCost)./p4SingleCost;
p4SICPC=p4SICPC(index33,:);
mm=zeros(61,2);
mm(:,1)=min(p4SICPC,[],2);
mm(:,2)=max(p4SICPC,[],2);
weightlimit=readmatrix('p4SingleSales.xlsx');
weightlimit=weightlimit(index33,:);
weightlimit=max(weightlimit,[],2);
cc=zeros(61,1);
for i=1:61
    flag=0;
    temp=index33(i);
    for j=1:7
        if p4SingleCost(temp,j)~=0
            flag=flag+1;
            cc(i)=cc(i)+p4SingleCost(temp,j);
        end
    end
    cc(i)=cc(i)/flag;
end
pre=pre(:,end-1);
%x是单品进货量 
%y是单品定价(1-33种商品的定价)  
[numData1,textData1,rawData1] = xlsread('a1.xlsx');
SIC=textData1;
[numData2,textData2,rawData2] = xlsread('d1.xlsx');
dSIC=textData2;
LossRate=readmatrix('d2.xlsx');
LRate=zeros(61,1);
for i=1:61
    temp=index33(i);
    temp2=find(ismember(dSIC,SIC(temp)));
    LRate(i)=LossRate(temp2);
end
LRate=LRate/100;
for j=27:33
prob=optimproblem('ObjectiveSense','max');
x=optimvar('x',j,'LowerBound',0);
y=optimvar('y',j,'LowerBound',0);
prob.Objective=(1-LRate(1:j)')*y-cc(1:j)'*x;
con1=[];
for i=1:j
    con1=[con1;x(i)*(1-LRate(i))>=2.5];
end
prob.Constraints.con1=con1;
con2=[];
for i=1:j
    if pre(i)>2.5
        con2=[con2;x(i)*(1-LRate(i))<=pre(i)];
    else
        con2=[con2;x(i)*(1-LRate(i))<=3];
    end
end
con3=[];
for i=1:j
    con3=[con3;y(i)<=(1+mm(i,2))*cc(i)*x(i)];
end
con4=[];
for i=1:j
    con4=[con4;y(i)>=(1+mm(i,1))*cc(i)*x(i)];
end
prob.Constraints.con2=con2;
prob.Constraints.con3=con3;
prob.Constraints.con4=con4;
[sol,fval,flag,out]=solve(prob)
xx=sol.x;yy=sol.y;
end
xx,yy
writematrix(xx,'xxx.xlsx');
writematrix(yy,'yyy.xlsx');
Name=importdata('SIngleName.txt');
Name=Name(index33);
Name=Name(1:33);
writecell(Name,'Name.txt');













