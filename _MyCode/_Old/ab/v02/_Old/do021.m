clear all; clc

a=2; 		% survive gain
b=20; 		% death cost
p=0.15;		% kill probability
K=10;		% fitness constant
J=30;		% number of generations

%strategies
% 1: never shoot
% 2: always shoot
% 3: grim never shoot

% Q(m,n) is payoff of m-th strat when played against n-th strat
Q(1,:)=[0 -b 									0];
Q(2,:)=[a payoffs01(p,p,a,b,1,1) 				p*a+(1-p)*payoffs01(p,p,a,b,1,1)];
Q(3,:)=[0 p*(-b)+(1-p)*payoffs01(p,p,a,b,1,1) 	0];
M=size(Q,1);

% initial strategy distribution
Z(1,:)=[3 2 4];
Z(1,:)=Z(1,:)/sum(Z(1,:));

for j=1:J
	for m=1:M
		S(j,m)=0;
		for k=1:M 
			%S(j,m)=S(j,m)+Z(m)*Z(k)*Q(m,k);
			S(j,m)=S(j,m)+Z(k)*Q(m,k);
		end
		SS(j,m)=exp(K*S(j,m));
	end
	%S(j,:)
	%SS(j,:)
	%Z(j+1,:)=Z(j,:).*SS(j,:);Z(j+1,:)=Z(j+1,:)/sum(Z(j+1,:));
	Z(j+1,:)=SS(j,:)/sum(SS(j,:));
	disp([j Z(j,:)])
	%disp('------------------')
	%pause
end
figure(1); plot(S); axis([1 J -2 2]); legend('never shoot','always shoot','grim never shoot','Location','southeast')
figure(2); plot(Z); axis([1 J -0.1 1.1]); legend('never shoot','always shoot','grim never shoot','Location','southeast')
