clc,clear
format compact
format short
%本文件用于指定定价策略
%变量x:42个,即接下来一周每天6种品类蔬菜的进货量
%变量y:42个,定价方案,接下来一周每天6种品类蔬菜的定价
%约束条件1:成本定价系数比如介于以往定价系数的最低和最大值之间
%约束条件2:进货量大于等于销售量(此处的销售量是预测的结果)
format long
Pre=readmatrix('Pre.xlsx');
minAndmax=[0.4674,0.8768;0.2742,0.7982;0.2895,0.6433;0.3275,0.8622;0.3620,0.9213;0.4150,0.7540];
bbeta=readmatrix('bbeta.xlsx');
prob=optimproblem('ObjectiveSense','max');
x=optimvar('x',6,7,'LowerBound',0);
y=optimvar('y',6,7,'LowerBound',0);
prob.Objective=sum(sum(y))-7*sum(bbeta(:,1))-bbeta(:,2)'*x(:,1)-bbeta(:,2)'*x(:,2)-...
    bbeta(:,2)'*x(:,3)-bbeta(:,2)'*x(:,4)-bbeta(:,2)'*x(:,5)-bbeta(:,2)'*x(:,6)-...
    bbeta(:,2)'*x(:,7);
prob.Constraints.con1=x<=Pre;
con2=[];
for i=1:6
    for j=1:7
        con2=[con2;y(i,j)<=(bbeta(i,1)+bbeta(i,2)*x(i,j))*(1+minAndmax(i,2))];
    end
end
prob.Constraints.con2=con2;
con3=[];
for i=1:6
    for j=1:7
        con3=[con3;y(i,j)>=(bbeta(i,1)+bbeta(i,2)*x(i,j))*(1+minAndmax(i,1))];
    end
end
prob.Constraints.con3=con3;
[sol,fval,flag,out]=solve(prob)
xx=sol.x,yy=sol.y
writematrix(xx,'xx.xlsx');
writematrix(yy,'yy.xlsx');



