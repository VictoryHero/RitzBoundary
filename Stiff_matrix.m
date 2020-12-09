function [A]=Stiff_matrix(p,q,h,n,low,high)
A=zeros(n+1);

for i=2:(n+1)
fun1=@(kesai) (p./h+h.*q.*((1-kesai).^2));
fun2=@(kesai) (p./h+h.*q.*(kesai.^2));
fun3=@(kesai) (-p./h+h.*q.*kesai.*(1-kesai));
    A(i-1,i-1)=A(i-1,i-1)+quad(fun1,low,high);
    A(i-1,i)=quad(fun3,low,high);
    A(i,i-1)=quad(fun3,low,high);
    A(i,i)=quad(fun2,low,high);
end
