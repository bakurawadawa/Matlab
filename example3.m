 clear
%定义变量
x=sdpvar(1);
y=sdpvar(1);
z=sdpvar(1);
u=sdpvar(1);
w=sdpvar(1);
%设置约束
con=[];
con=[con,(x-1)^2+(y-1)^2-1<=0];%二次非线性约束
con=[con,z+y-2<=0];
con=[con,z==abs(x)];%非线性约束
con=[con,u==y+4];
con=[con,w==max(z,u)];%非线性约束
con=[con,w>=0,z>=0];
%求解
ops= sdpsettings('verbose',1,'solver','cplex'); %求解器设置
r=optimize(con,w,ops)
% 结果
x=value(x)
y=value(y)
z=value(z)
u=value(u)
w=value(w)