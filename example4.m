clear
p1=sdpvar(1);
p2=sdpvar(1);
p3=sdpvar(1);
p4=sdpvar(1);
r1=sdpvar(1);
r2=sdpvar(1);
r3=sdpvar(1);
r4=sdpvar(1);
obj=2*p1+17*p2+20*p3+28*p4;

D=700
%设置约束
con=[];
con=[con,p1+p2+p3+p4==D];
con=[con,r1+r2+r3+r4>=250];
con=[con,p1+r1>=0,p1+r1<=250];
con=[con,p2+r2>=0,p2+r2<=230];
con=[con,p3+r3>=0,p3+r3<=240];
con=[con,p4+r4>=0,p4+r4<=250];
con=[con,p1>=0,p1<=250];
con=[con,p2>=0,p2<=230];
con=[con,p3>=0,p3<=240];
con=[con,p4>=0,p4<=250];
con=[con,r1==0];
con=[con,r2>=0,r2<=160];
con=[con,r3>=0,r3<=190];
con=[con,r4==0];

%求解
ops= sdpsettings('verbose',1,'solver','cplex'); %求解器设置
diagnostics=optimize(con,obj,ops)
% 过程
disp('开始求解')

if diagnostics.problem==0
    disp('Solver thinks it is feasible')
    p1=value(p1)
    r1=value(r1)
    p2=value(p2)
    r2=value(r2)
    p3=value(p3)
    r3=value(r3)
    p4=value(p4)
    r4=value(r4)
elseif diagnostics.problem == 1
    disp('Solver thinks it is infeasible')
% 结果
   
else
    disp('Timeout, Display the current optimal solution')



end 
 

