% player-centric duels evolutionary tournament with theoretical payoffs  
% FIT changes by differential equation
clear all; clc

% parameters
a=1; 		% survive gain
b=7; 		% death cost
p=0.50;		% kill probability
h=0.025;		% integration step
J=100;		% number of generations

% load strategies
Q=strats01(a,b,p,p);
M=size(Q,1);
FIT(1,:)=0.5*ones(1,M);

% initial strategy distribution
CMP=[20 20 20]; 
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
		SCR(j,m)=sum(sc(j,q1)); %/CMP(j,m);
	end
	for m=1:M
		if CMP(j,m)==0
			FIT(j+1,m)=0;
		else
			FIT(j+1,m)=FIT(j,m)+h*(SCR(j,m)-mean(SCR(j,:)))*FIT(j,m)*(1-FIT(j,m));
			%FIT(j+1,m)=FIT(j,m)+h*SCR(j,m)*FIT(j,m)*(1-FIT(j,m));
			FIT(j+1,m)=FIT(j,m)+(h/N)*FIT(j,m)*SCR(j,m);
			FIT(j+1,m)=max([FIT(j+1,m),0]);
			FIT(j+1,m)=min([FIT(j+1,m),1]);
		end
	end
	%FIT(j+1,:)
	FIT(j+1,:)=FIT(j+1,:)/sum(FIT(j+1,:));
	STR(j+1,:)=randsample([1:M],N,true,FIT(j+1,:));
	disp([SCR(j,:) SCR(j,:)-mean(SCR(j,:)) FIT(j,:)])
	%pause
end
figure(1); plot(CMP); 
axis([1 J -1.0 N+1]); legend('never shoot','always shoot','grim never shoot','Location','southeast')
figure(2); plot(FIT); 
axis([1 J -0.1 1.1]); legend('never shoot','always shoot','grim never shoot','Location','southeast')

[Cr1,Cr2]= crits01(p,p,a,b);
disp([Cr1 Cr2])

