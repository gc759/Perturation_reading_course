x = [-1:0.01:1];
int = zeros(length(x),1);
for i = 1:length(x)
    x1 = x(i);
    fun = @(t) exp(-x1*(t.^2+1));
    int(i) = integral(fun,1,10);
end
plot(x,int)

%% Ex 3.6 I(x) = \int_{-1}^{\infty} e^{x(t+it-\frac{t^2}{2})}dt
format long 
xvector = 1:0.01:60;
n = length(xvector);
chebfunint = zeros(n,1);
approxint = zeros(n,1);
for i = 1:n
    x = xvector(i);
    z = chebfun(@(t) exp(x*(t+1i*t-t^2/2)),[-1 Inf]);
    chebfunint(i) = sum(z);
%     approxint(i) = exp(1i*x)*sqrt(2*pi/x);
end
plot(real(chebfunint),imag(chebfunint),'-g','linewidth',2)
% hold on
% plot(real(approxint),imag(approxint),'-r','linewidth',2)
xlabel('Re') 
ylabel('Im') 
legend({'Numerical results','Asymptotic results'})
hold off

%% Ex 3.6 
format long
xvector = 1:0.1:60;
n = length(xvector);
chebfunint = zeros(n,1);

for i = 1:n
    x = xvector(i);
    z = chebfun(@(t) exp(x*(t+1i*t-t^2/2)),[-1 Inf]);
    chebfunint(i) = sum(z);
end

yvector = 1:0.1:100000;
m = length(yvector);
approxint = zeros(m,1);
for i = 1:m
    x = yvector(i);
    approxint(i) = exp(1i*x)*sqrt(2*pi/x);
end

plot(real(chebfunint),imag(chebfunint),'-','color','#0072BD','linewidth',2)	
hold on
plot(real(approxint),imag(approxint),'-','color','#EDB120','linewidth',1)
xlabel('Re') 
ylabel('Im') 
legend({'Numerical results','Asymptotic results'})
ax = gca;
ax.XAxisLocation = 'origin'
ax.YAxisLocation = 'origin'
hold off

%%
x = 60;
z = chebfun(@(t) exp(x*(t+1i*t-t^2/2)),[-1 Inf]);
sum(z)
exp(1i*x)*sqrt(2*pi/x)


plot(z)

plot(real(z),imag(z))

approx = exp(1i*x)*sqrt(2*pi/x);
approx
sum(z)

%% boundary layer

epsilon = 0;

yvector = 0:0.001:1;
m = length(yvector);
approxint = zeros(m,1);
for i = 1:m
    x = yvector(i);
    sol(i) = exp(1-x);
end

plot(yvector,sol,'linewidth',2)

hold on

epsilon = 0.1;

yvector = 0:0.001:1;
m = length(yvector);
approxint = zeros(m,1);
for i = 1:m
    x = yvector(i);
    sol(i) = (exp(-x)-exp(-x/epsilon))/ (exp(-1)-exp(-1/epsilon));
end

plot(yvector,sol,'linewidth',2)

hold on


epsilon = 0.01;

yvector = 0:0.001:1;
m = length(yvector);
approxint = zeros(m,1);
for i = 1:m
    x = yvector(i);
    sol(i) = (exp(-x)-exp(-x/epsilon))/ (exp(-1)-exp(-1/epsilon));
end

plot(yvector,sol,'linewidth',2)

hold off


legend({'\epsilon = 0','\epsilon = 0.01','\epsilon = 0.01'})
xlabel('x') 
ylabel('y') 

%% Van Dyke s matching rule chebfun


epsilon = 0.1;
L = chebop(0, 1);
L.op = @(x,y) epsilon*diff(y,2) + y*diff(y,1) - y ;
L.lbc = 1; L.rbc = 3;
x = chebfun('x');
y = L\0;
plot(y,'linewidth',2)

hold on

epsilon = 0.01;
L = chebop(0, 1);
L.op = @(x,y) epsilon*diff(y,2) + y*diff(y,1) - y ;
L.lbc = 1; L.rbc = 3;
x = chebfun('x');
y = L\0;
plot(y,'linewidth',2)

epsilon = 0.001;
L = chebop(0, 1);
L.op = @(x,y) epsilon*diff(y,2) + y*diff(y,1) - y ;
L.lbc = 1; L.rbc = 3;
x = chebfun('x');
y = L\0;
plot(y,'linewidth',2)


legend({'\epsilon = 0','\epsilon = 0.1','\epsilon = 0.001'})
xlabel('x') 
ylabel('y') 

%% Van Dyke s matching rule chefun part 2
epsilon = 0.02;

L = chebop(0, 1);
L.op = @(x,y) epsilon*diff(y,2) + y*diff(y,1) - y ;
L.lbc = 0; L.rbc = 3;
x = chebfun('x');
y = L\0;
plot(y,'color','#EDB120','linewidth',2)

xvector = [linspace(0,0.005,100) linspace(0.005,1,100)];
m = length(xvector);
approxinner = zeros(m,1);

for i = 1:m
    x = xvector(i);
    approxinner(i) = 2*tanh(x/epsilon);
    approxouter(i) = x+2;
end


hold on

plot(xvector,approxouter,'--','color','#FF5F5F','linewidth',2)
plot(xvector,approxinner,'--','color','#0072BD','linewidth',2)

% xlim([0 0.01])

hold off

xlabel('x') 
ylabel('y') 
legend({'chebfun solution','approximate outer solution','approximate inner solution'})

%% Matching by intermediate variable

epsilon = 0.1;
opts =odeset('RelTOL',1e-2,'AbsTol',1e-4);
[x,y] = ode45(@(x,y)inter(x,y,epsilon),[1 0],1,opts);
plot(x,y,'linewidth',2)

% L = chebop(0,1);
% L.op = @(x,y) ((1+epsilon)*x.^2)*diff(y,1)- epsilon*( (1-epsilon) * x * y.^2 - (1+epsilon) * x + y.^3 + 2 * epsilon * y.^2) ;
% L.rbc = 1;
% x = chebfun('x');
% y = L\0;
% plot(y,'color','#EDB120','linewidth',2)

xvector = [linspace(0,0.02,100) linspace(0.02,1,100)];
m = length(xvector);
approxouter = zeros(m,1);
approxinner = zeros(m,1);
for i = 1:m
    x = xvector(i);
    approxouter(i) = 1 + epsilon*(1-1/x) + epsilon^2*(1/2-2/x+3/(2*x^2));
    approxinner(i) = (1+2*epsilon/x)^(-1/2) + epsilon*(1+epsilon/x)*(1+2*epsilon/x)^(-3/2);
end


hold on
% plot(xvector,approxouter,'--','color','#FF5F5F','linewidth',2)
plot(xvector,approxinner,'--','color','#EDB120','linewidth',2)

% xlim([0 0.01])
ylim([0,1])
legend({'chebfun solution','approximate inner solution'})
% legend({'chebfun solution','approximate outer solution','approximate inner solution'})
% legend({'approximate outer solution','approximate inner solution'})
hold off

xlabel('x') 
ylabel('y') 
%% Hinch p64 Ex3

epsilon = 1;

L = chebop(-1, 1);
L.op = @(x,y) epsilon^2*diff(y,2) + 2*y*(1-y^2) ;
L.lbc = -1;
L.rbc = 1;
x = chebfun('x');
y = L\0;
plot(y,'color','#EDB120','linewidth',2)

hold on

epsilon = 0.1;

L = chebop(-1, 1);
L.op = @(x,y) epsilon^2*diff(y,2) + 2*y*(1-y^2) ;
L.lbc = -1;
L.rbc = 1;
x = chebfun('x');
y = L\0;
plot(y,'color','#FF5F5F','linewidth',2)

epsilon = 0.01;

L = chebop(-1, 1);
L.op = @(x,y) epsilon^2*diff(y,2) + 2*y*(1-y^2) ;
L.lbc = -1;
L.rbc = 1;
x = chebfun('x');
y = L\0;
plot(y,'color','#0072BD','linewidth',2)

hold off

legend({'\epsilon = 1','\epsilon = 0.1','\epsilon = 0.01'})
xlabel('x') 
ylabel('y') 


%% Hinch p64 Ex3 approx

epsilon = 0.01;
xvector = linspace(-1,1,200);
m = length(xvector);
approx = zeros(m,1);
for i = 1:m
    x = xvector(i);
    approx(i) = tanh(x/epsilon);
end


hold on
% plot(xvector,approxouter,'--','color','#FF5F5F','linewidth',2)
plot(xvector,approx,'--','color','#EDB120','linewidth',2)


%% very simple

epsilon = 0.1;

L = chebop(0, 1);
L.op = @(x,y) epsilon*diff(y,2) + diff(y,1) + y ;
L.lbc = 0;
L.rbc = 1;
x = chebfun('x');
y = L\0;

subplot(1,2,1);
plot(y,'color','#EDB120','linewidth',2)
hold on

xvector = linspace(0,1,100);
m = length(xvector);
approxbd = zeros(m,1);
approxwkb = zeros(m,1);
for i = 1:m
    x = xvector(i);
    approxbd(i) = exp(1-x) -exp(1-x/epsilon);
    approxwkb(i) = exp(1-x) -exp(1+x-x/epsilon);
end
plot(xvector,approxbd,'--','color','#0072BD','linewidth',2)

plot(xvector,approxwkb,'.','color','#FF5F5F','linewidth',2)
legend({'numerical solution','boundary layer solution','WKBJ solution'})
xlabel('x') 
ylabel('y') 
title('\epsilon = 0.1')  



epsilon = 0.01;

L = chebop(0, 1);
L.op = @(x,y) epsilon*diff(y,2) + diff(y,1) + y ;
L.lbc = 0;
L.rbc = 1;
x = chebfun('x');
y = L\0;

subplot(1,2,2);
plot(y,'color','#EDB120','linewidth',2)
hold on

xvector = linspace(0,1,100);
m = length(xvector);
approxbd = zeros(m,1);
approxwkb = zeros(m,1);
for i = 1:m
    x = xvector(i);
    approxbd(i) = exp(1-x) -exp(1-x/epsilon);
    approxwkb(i) = exp(1-x) -exp(1+x-x/epsilon);
end
plot(xvector,approxbd,'--','color','#0072BD','linewidth',2)

plot(xvector,approxwkb,'.','color','#FF5F5F','linewidth',2)
legend({'numerical solution','boundary layer solution','WKBJ solution'})
xlabel('x') 
ylabel('y') 
title('\epsilon = 0.01')  
hold off

%% turning point


epsilon = 0.01;

L = chebop(-10, 10);
L.op = @(x,y) epsilon*diff(y,2) - sinh(x)*cosh(x)^2*y ;
L.bc = @(x,y) y(0)-1;
L.rbc = 0;
x = chebfun('x');
y = L\0;

plot(y,'color','#EDB120','linewidth',2)
hold on

A = 3^(4/3)*epsilon^(1/3)*(gamma(2/3))^2/(4*pi);
xvector = linspace(-10,10,1000);
m = length(xvector);
approxright = zeros(m,1);
approxleft = zeros(m,1);
approxturning = zeros(m,1);
for i = 1:m
    x = xvector(i);
    approxright(i) = A/((sinh(x)*cosh(x^2))^(1/4))* exp(-2/(3*epsilon)*(sinh(x))^(3/2));
    approxleft(i) = A/((sinh(abs(x))*cosh(x^2))^(1/4))* exp(-2/(3*epsilon)*(sinh(abs(x)))^(3/2)+pi/4);
    approxturning(i) = 2*sqrt(pi*A)/(epsilon)^(1/6)*airy(x/epsilon^(2/3));
end
plot(xvector,approxright,'--','color','#0072BD','linewidth',2)

plot(xvector,approxleft,'--','color','#FF5F5F','linewidth',2)
plot(xvector,approxturning,'--','color','#d5a4cf','linewidth',2)
legend({'numerical solution','right side solution','left side solution','turning point solution'})
xlabel('x') 
ylabel('y') 
title('\epsilon = 0.1')  

xlim([-2,2])
hold off

%% turning point at infinity


epsilon = 0.1;

L = chebop(0, 10);
L.op = @(x,y) epsilon^2*diff(y,2) + exp(1).^{-2*x}*y ;
L.lbc = @(y) diff(y)-1;
L.lbc = 0;
x = chebfun('x');
y = L\0;

plot(y,'color','#EDB120','linewidth',2)
hold on

xvector = linspace(-2,2,100);
m = length(xvector);
approx = zeros(m,1);
for i = 1:m
    x = xvector(i);
    approx(i) = epsilon*exp(1).^(x/2)*(sin(1/epsilon*(1-exp(1).^(-x)))+1/8*epsilon*(exp(1).^x-1)*cos(1/epsilon*(1-exp(1).^(-x)))) ;
end
plot(xvector,approx,'--','color','#0072BD','linewidth',2)

legend({'numerical solution','approx solution'})
xlabel('x') 
ylabel('y') 
title('\epsilon = 0.1')  


hold off

%% speedest descent

x = [10:0.01:60];
int = zeros(length(x),1);
for i = 1:length(x)
    x1 = x(i);
    fun = @(t) exp(x1*(t+1i*t-t.^2/2));
    int(i) = integral(fun,-1,10);
    apprx(i) = exp(1i*x1)*sqrt(2*pi/x1);
end
plot(x,imag(int),'-','color','#0072BD','linewidth',2)
hold on
plot(x,imag(apprx),'--','color','#EDB120','linewidth',2)
hold off


xlabel('x') 
ylabel('Im(I(x))') 
legend({'Numerical solution','Approximate solution'})
