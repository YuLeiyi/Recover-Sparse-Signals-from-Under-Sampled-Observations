m = 15;
n = 10;
A = randn(m,n);
A = normc(A);
x = randn(n,1);
y = A * x;
x1 = pinv(A) * y;
x2 = A \ y;
x
x1
x2