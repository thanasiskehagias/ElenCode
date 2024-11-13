% strategy-centric duels evolutionary tournament with theoretical payoffs  
clear all; clc

% parameters
a=1; 		% survive gain
b=10; 		% death cost
p=0.15;		% kill probability
K=5.00;		% fitness constant
J=30;		% number of generations

% load strategies
PO=strats01(a,b,p,p);
M=size(PO,1);

% initial strategy distribution
FIT(1,:)=[3 2 4];
FIT(1,:)=FIT(1,:)/sum(FIT(1,:));

% main
for j=1:J
	for m=1:M
		SCR(j,m)=0;
		SCR1(j,m)=0;
		for k=1:M 
			if FIT(m)<1e-4
				SCR(j,m)=-1e10;
				SCR1(j,m)=-1e10;
			else
				SCR(j,m)=SCR(j,m)+FIT(m)*FIT(k)*PO(m,k);
				SCR1(j,m)=SCR1(j,m)+FIT(k)*PO(m,k);
			end
		end
	end
	disp(SCR(j,:))
	%disp(SCR1(j,:))
	for m=1:M 
		FIT(j,m)=fit01(SCR(j,m),K);
	end
	FIT(j,:)=FIT(j,:)/sum(FIT(j,:));
	disp(FIT(j,:))
	pause
end
figure(1); plot(SCR); 
axis([1 J -2 2]); legend('never shoot','always shoot','grim never shoot','Location','southeast')
figure(2); plot(FIT); 
axis([1 J -0.1 1.1]); legend('never shoot','always shoot','grim never shoot','Location','southeast')
