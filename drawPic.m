tic;
%% 两点边值问题
clear all;
clc;
close all;

%% 正式求解

for NumM=5:8
p=1;q=0;
high=1;low=-1;

N=NumM;
X=linspace(low,high,N+1);
f=inline('sin(pi*x)-cos(pi*x)','x');
exact_u=(sin(pi*X)-cos(pi*X))/pi^2+(4*pi-1)*X/(3*pi)-(pi^2-pi+1)/pi^2;


h=(high-low)/N;
K=Stiff_matrix(p,q,h,N,low,high);
b=rightVector(f,X,h,N,low,high);

b(1,1)=b(1,1)+1;
K(1,1)=K(1,1)-1;

b(end,1)=b(end,1)+2;         
K(end,end)=K(end,end)+2;       


u=[2.*K\b];
exact_u=exact_u';
grid on;
subplot(4,2,(NumM-5)*2+1);
plot(X,u,'ro-',X,exact_u,'b^:');
title('Numerical solutions vs Exact solutions');
legend('Numerical_solution','Exact_solution','Location','NorthWest');
subplot(4,2,(NumM-5)*2+2);
plot(X,u-exact_u,'b x-');
legend('error_solution');
title('error');
end
toc;
