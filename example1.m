%% 程序说明
%   | 0.25x   , 0<=x<=0.4               
% y=| x-0.3   , 0.4=<x=<0.7             
%   | 2x-1    , 0.7<x<1
clc
clear
w=sdpvar(1,4);
z=binvar(1,3);
x=0.7;
y=0*w(:,1)+0.1*w(:,2)+0.4*w(:,3)+1*w(:,4);
C = [];     %约束条件初始
for i=1:4
    C = [C,
        w(1,i)>=0, 
        ];
end
         
 C = [C,
        0.4*w(1,2)+0.7*w(1,3)+1*w(1,4)==x, 
        w(1,1)+w(1,2)+w(1,3)+w(1,4)==1,
        z(1,1)+z(1,2)+z(1,3)==1,
        w(1,1)<=z(1,1),
        w(1,2)<=z(1,1)+z(1,2),
        w(1,3)<=z(1,2)+z(1,3),
        w(1,4)<=z(1,3),
        ];
%% 求解器的相关配置
    ops = sdpsettings('solver','cplex','verbose',2,'usex0',0);
    ops.cplex.mip.tolerances.mipgap = 1e-6;
%% 进行求解计算        
result = optimize(C, y, ops);
 
if result.problem == 0 % problem =0 代表求解成功  
else
    error('求解出错');
end 
y=value(y);
w=value(w);
z=value(z);
display(['通过Yalmip求得的最优规划值为 : ', num2str(y)]);