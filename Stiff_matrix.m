function [A]=Stiff_matrix(p,q,h,n,low,high,right)
A=zeros(n+1);
fun1=@(kesai) (p./h+h.*q.*((1-kesai).^2));
fun2=@(kesai) (p./h+h.*q.*(kesai.^2));
fun3=@(kesai) (-p./h+h.*q.*kesai.*(1-kesai));
for i=2:(n+1)
    A(i-1,i-1)=A(i-1,i-1)+quad(fun1,low,high);
    A(i-1,i)=quad(fun3,low,high);
    A(i,i-1)=quad(fun3,low,high);
    A(i,i)=quad(fun2,low,high);
end
%A=A(2:(n+1),2:(n+1)); %矩阵复位成n*n的 去掉了第一行第一列
% 右边值
% A(end-1,end)=right;A(end,end-1)=right;

% A(1,1)=1;
% A(1,2)=0;
% A(2,1)=0;