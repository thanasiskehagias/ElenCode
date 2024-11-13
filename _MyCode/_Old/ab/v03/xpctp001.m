% player-centric duels evolutionary tournament with theoretical payoffs  
clear all; clc

% parameters
a=1; 		% survive gain
b=5; 		% death cost
p=0.20;		% kill probability
K=0.15;		% fitness constant
J=15;		% number of generations

% load strategies
Q=strats01(a,b,p,p);
M=size(Q,1);

% initial strategy distribution
CMP=[5 2 8]; 
STR=[]; for m=1:M; STR=[STR m*ones(1,CMP(m))]; end; N=size(STR,2);

% main
for j=1:J
	for n1=1:N
		sc(j,n1)=0;
		for n2=1:N 
			sc(j,n1)=sc(j,n1)+Q(STR(j,n1),STR(j,n2));
		end
	end

	for m=1:M 
		q1=find(STR(j,:)==m);
		CMP(j,m)=length(q1);
		if length(q1)==0
			SCR(j,m)=-1e3;
		else
			SCR(j,m)=sum(sc(j,q1));
		end
	end
	for m=1:M 
		FIT(j,m)=fit01(SCR(j,m),K);
	end
	FIT(j,:)=FIT(j,:)/sum(FIT(j,:));
	STR(j+1,:)=randsample([1:M],N,true,FIT(j,:));
	disp([SCR(j,:) FIT(j,:)])
	%pause
end
figure(1); plot(CMP); 
axis([1 J -1.0 N+1]); legend('never shoot','always shoot','grim never shoot','Location','southeast')
figure(2); plot(FIT); 
axis([1 J -0.1 1.1]); legend('never shoot','always shoot','grim never shoot','Location','southeast')

[Cr1,Cr2]= crits01(p,p,a,b);
disp([Cr1 Cr2])

