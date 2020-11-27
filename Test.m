m = 128;
n = 256;

Num_Sp = 30;

S_omp = 0;
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

end

SR_omp = S_omp/500
S_omp