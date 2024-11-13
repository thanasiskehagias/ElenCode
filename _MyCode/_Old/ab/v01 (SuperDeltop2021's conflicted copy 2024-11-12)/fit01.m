function fit=fit01(scor,K)
	%fit=exp(K*scor);
	fit=1/(1+exp(-K*scor));
end
