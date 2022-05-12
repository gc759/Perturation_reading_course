function dydx = inter(x,y,epsilon)
dydx = epsilon*( (1-epsilon) * x * y.^2 - (1+epsilon) * x + y.^3 + 2 * epsilon * y.^2) / ((1+epsilon)*x.^2);
end