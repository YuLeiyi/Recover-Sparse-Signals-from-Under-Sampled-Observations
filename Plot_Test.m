x = 1:10;
y = sin(x);
z = cos(x);
plot(x,y,x,z);
title('Success Rate Comparison (500 Repeatations)');
xlabel('Signal Sparsity: S');
ylabel('Success Rate of Recovery');
legend({'y = sin(x)','y = cos(x)'},'Location','southwest');