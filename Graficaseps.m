function Graficaseps()
eps=0:0.1:0.5;
cost=[21922 35224 54931 84547 129238 197051];
average=[79 56 54 54 54 54];
max=[382 334 302 207 171 154];
dev=[99 69 52 40 35 31];
hold on
title('Influence of ε on total cost and delay')
xlabel('ε');
yyaxis left;
ylabel('Cost ($)');
plot(eps,cost,'r');

yyaxis right
ylabel('Delay (min)');

plot(eps,average,'b')
plot(eps,max,'g');
plot(eps,dev,'k-');
legend('Total Cost','Average Ground Delay','Max Ground Delay','Standard Deviation');
end

