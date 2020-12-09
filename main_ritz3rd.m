tic;
%% 求边界值
clear all;
clc;
close all;

%% 正式求解

p=1;q=0;
high=1;low=-1;

N=50;
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
b(:)=b(:);

u=[2.*K\b];
exact_u=exact_u';
grid on;
subplot(1,2,1);
plot(X,u,'ro-',X,exact_u,'b^:');
title('Numerical solutions vs Exact solutions');
legend('Numerical_solution','Exact_solution');
subplot(1,2,2);
plot(X,u-exact_u,'b x-');
legend('error_solution');
title('error');
toc;
