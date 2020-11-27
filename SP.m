m = 128;
n = 256;
Num_Sp = 12;
Sup = randsample(n,Num_Sp);
A = randn(m,n);
A = normc(A);
x = randn(n,1);
x(setdiff([1:n],Sup),:) = 0;
y = A * x;

[b,i] = sort(abs(transpose(A)*y));
S = i(n-Num_Sp+1:n);
yr = y - A(:,S) * (A(:,S) \ y);
while 1
    [b1,i1] = sort(abs(transpose(A)*yr));
    S1 = union(S,i1(n-Num_Sp+1:n));
    bs = zeros(n,1);
    bs(S1,:) = A(:,S1)\y;
    [b2,i2] = sort(abs(bs));
    S = i2(n-Num_Sp+1:n);
    xsp = zeros(n,1);
    xsp(S,:) = A(:,S)\y;
    if norm(yr) <= norm(y - A * xsp) || norm(xsp - x)/norm(x,1)<= 10^-6
        break
    end
    yr = y - A * xsp;
end

x1 = pinv(A) * y;
x2 = A \ y;
x(x~=0)
xsp(xsp~=0)
% find(x~=0)
% find(xsp~=0)
% S
% S1