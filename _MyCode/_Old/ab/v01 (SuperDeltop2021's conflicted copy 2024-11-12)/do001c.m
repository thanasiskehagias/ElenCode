clear all; clc

a=1; 		% survive gain
b=10; 		% death cost
p=0.20;		% kill probability
K=0.15;		% fitness constant
J=30;		% number of generations

%strategies
% 1: never shoot
% 2: always shoot
% 3: grim never shoot

% PO(m,n) is payoff of m-th strat when played against n-th strat
PO(1,:)=[0 -b 									0];
PO(2,:)=[a payoffs01(p,p,a,b,1,1) 				p*a+(1-p)*payoffs01(p,p,a,b,1,1)];
PO(3,:)=[0 p*(-b)+(1-p)*payoffs01(p,p,a,b,1,1) 	0];
M=size(PO,1);

% initial strategy distribution
Props=[5 2 8]; 
STR=[]; for m=1:M; STR=[STR m*ones(1,Props(m))]; end
N=size(STR,2);

for j=1:J
	for n1=1:N
		scor(j,n1)=0;
		for n2=1:N 
			scor(j,n1)=scor(j,n1)+PO(STR(j,n1),STR(j,n2));
		end
	end

	for m=1:M 
		q1=find(STR(j,:)==m);
		CMP(j,m)=length(q1);
		if length(q1)==0
			SCOR(j,m)=-1e10;
		else
			SCOR(j,m)=sum(scor(j,q1));
		end
	end
	for m=1:M 
		FIT(j,m)=fit01(SCOR(j,m),K);
	end
	FIT;
	FIT(j,:)=FIT(j,:)/sum(FIT(j,:));
	STR(j+1,:)=randsample([1:M],N,true,FIT(j,:));
	disp([j FIT(j,:)])
end
figure(1); plot(CMP); axis([1 J -1.0 N+1]); legend('never shoot','always shoot','grim never shoot','Location','southeast')
figure(2); plot(FIT); axis([1 J -0.1 1.1]); legend('never shoot','always shoot','grim never shoot','Location','southeast')

[Cr1,Cr2]= crits01(p,p,a,b);
disp([Cr1 Cr2])
