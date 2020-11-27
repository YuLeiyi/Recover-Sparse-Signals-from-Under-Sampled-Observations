m = 128;
n = 256;
Num_Sp = 12;
Sup = randsample(n,Num_Sp);
A = randn(m,n);
A = normc(A);
x = randn(n,1);
x(setdiff([1:n],Sup),:) = 0;
y = A * x;

xiht = zeros(n,1);
yr = y;
while 1
    q = xiht + transpose(A) * (y - A * xiht);
    [b,i] = sort(abs(q));
    Sup = i(n-Num_Sp+1:n);
    xiht = zeros(n,1);
    xiht(Sup,:) = q(Sup,:);
    if norm(yr) <= norm(y - A * xiht) || norm(y - A * xiht)/norm(y)<= 10^-6
        break
    end
    yr = y - A * xiht;
end

x1 = pinv(A) * y;
x2 = A \ y;
x(x~=0)
xiht(xiht~=0)
% find(x~=0)
% find(xiht~=0)
% S
% S1