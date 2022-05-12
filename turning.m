%% turning point


epsilon = 0.1;

L = chebop(-10, 10);
L.op = @(x,y) epsilon^2*diff(y,2) - sinh(x)*cosh(x)^2*y ;
L.bc = @(x,y) y(0)-1;
L.rbc = 0;
x = chebfun('x');
y = L\0;

%%
plot(y,'color','#ea7070','linewidth',2)
hold on

A = 3^(2/3)*epsilon^(1/6)*(gamma(2/3))^1/(2*sqrt(pi));
xvector = linspace(-10,10,1000);
m = length(xvector);
approxright = zeros(m,1);
approxleft = zeros(m,1);
approxturning = zeros(m,1);
for i = 1:m
    x = xvector(i);
    approxright(i) = A/((sinh(x)*cosh(x^2))^(1/4))* exp(-2/(3*epsilon)*(sinh(x))^(3/2));
    approxleft(i) = A/((sinh(abs(x))*cosh(x^2))^(1/4))* exp(-2/(3*epsilon)*(sinh(abs(x)))^(3/2)+pi/4);
    approxturning(i) = 2*sqrt(pi)*A/(epsilon)^(1/6)*airy(x/epsilon^(2/3));
end
plot(xvector,approxright,'--','color','#0072BD','linewidth',2)

plot(xvector,approxleft,'--','color','#9dd3a8','linewidth',2)
plot(xvector,approxturning,'--','color','#EDB120','linewidth',2)
legend({'Numerical solution','Right side solution','Left side solution','Turning point solution'})
xlabel('x')
ylabel('y')
title('\epsilon = 0.1')  

xlim([-5,5])
hold off

hold on
xline(0);
hold off

%%

xvector = linspace(-10,10,1000);
m = length(xvector);
approxright = zeros(m,1);

for i = 1:m
    x = xvector(i);
    approxright(i) = log(abs(log(A/((sinh(x)*cosh(x^2))^(1/4))* exp(-2/(3*epsilon)*(sinh(x))^(3/2)))));
end
plot(xvector,approxright,'--','color','#0072BD','linewidth',2)