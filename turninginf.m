function dydx = turninginf(x,y,epsilon)
dydx = [y(2);-exp(-2*x)*y(1)/(epsilon^2)];
end