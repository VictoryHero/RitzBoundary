tic;
%% 求边界值
clear all;
clc;
close all;

%%% 目标
syms X;
exact_u=(sin(pi*X)-cos(pi*X))/pi^2+(4*pi-1)*X/(3*pi)-(pi^2-i+1)/pi^2;
df1=diff(exact_u,X,1);
leftb=-double(subs(df1,-1))-1;
rightb=(2-double(subs(df1,1)))/2;
%% 正式求解

p=1;q=0;
high=1;low=-1;

N=5;
X=linspace(low,high,N+1);
f=inline('sin(pi*x)-cos(pi*x)','x');
exact_u=(sin(pi*X)-cos(pi*X))/pi^2+(4*pi-1)*X/(3*pi)-(pi^2-pi+1)/pi^2;


%% 二函
% p=1;q=pi^2/4;
% high=1;low=0;
% N=50;
% X=linspace(low,high,N+1);
% f=inline('pi^2/2*sin(pi/2*x)');
% exact_u=sin((pi*X)/2)/2 - cos((pi*X)/2)/2 +...
% exp((pi*X)/2).*((exp(-(pi.*X)/2).*cos((pi*X)/2))/2 ...
% + (exp(-(pi*X)/2).*sin((pi*X)/2))/2);
% leftb=0;
% rightb=0;

%% 一函
% p=-1;q=1;
% high=1;low=0;
% N=50;
% X=linspace(low,high,N+1);
% f=inline('-1*x');
% exact_u=sin(X)/sin(1)-X;
% leftb=0;
% rightb=0;

h=(high-low)/N;
K=Stiff_matrix(p,q,h,N,low,high,rightb);
b=rightVector(f,X,h,N,low,high);
K=K(2:end,:);
b=b(2:end,:);
b=b-leftb*K(:,1);
K=K(:,2:end);

K=K(1:end-1,:);
b=b(1:end-1,:);
b=b-rightb*K(:,end);
K=K(:,1:end-1);

u=[leftb;K\b;rightb];
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
