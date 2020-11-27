m = 128;
n = 256;

SR_omp = [];
SR_sp = [];
SR_iht = [];
for l = 1:21
Num_Sp = l * 3;

S_omp = 0;
S_sp = 0;
S_iht = 0;
for k = 1:500
Sup = randsample(n,Num_Sp);
A = randn(m,n);
A = normc(A);
x = randn(n,1);
x(setdiff([1:n],Sup),:) = 0;
y = A * x;
    
S = [];
yr = y;
for p = 1:Num_Sp
    q = transpose(A)*yr;
    S = union(S,find(abs(q)==max(abs(q))));
    xomp = zeros(n,1);
    xomp(S,:) = A(:,S)\y;
    yr = y - A * xomp;
end

if norm(xomp - x)/norm(x,1)< 10^-6
    S_omp = S_omp + 1;
end

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

if norm(xsp - x)/norm(x,1)< 10^-6
    S_sp = S_sp + 1;
end

xiht = zeros(n,1);
yr = y;
while 1
    q = xiht + transpose(A) * (y - A * xiht);
    [b,i] = sort(abs(q));
    Sup = i(n-Num_Sp+1:n);
    xiht = zeros(n,1);
    xiht(Sup,:) = q(Sup,:);
    if norm(yr) <= norm(y - A * xiht) || norm(xiht - x)/norm(x,1)<= 10^-6
        break
    end
    yr = y - A * xiht;
end

if norm(xiht - x)/norm(x,1)< 10^-6
    S_iht = S_iht + 1;
end

end

SR_omp(l) = S_omp/500;
SR_sp(l) = S_sp/500;
SR_iht(l) = S_iht/500;
end
Num_S = linspace(3,63,21);
plot(Num_S,SR_omp,Num_S,SR_sp,Num_S,SR_iht);
title('Success Rate Comparison (500 Repeatations)');
xlabel('Signal Sparsity: S');
ylabel('Success Rate of Recovery');
legend({'OMP','SP','IHT'},'Location','southwest');