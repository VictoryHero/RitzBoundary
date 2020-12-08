function b=rightVector(f,x,h,n,low,high)
b=zeros(n,1);
for i=2:n+1
% fun1=@(kesai) f((x(i)+h.*kesai)).*(1-kesai)+f((x(i-1)+h.*kesai)).*kesai;
% b(i-1)=h.*quad(fun1,low,high);

fun1=@(kesai) f(x(i-1)+h.*kesai).*(1-kesai);
fun2=@(kesai) f(x(i-1)+h.*kesai).*kesai;
b(i-1)=b(i-1)+h.*quad(fun1,low,high);
b(i)=h.*quad(fun2,low,high);
end
%b=b(2:end);   %去掉了第一个分量

