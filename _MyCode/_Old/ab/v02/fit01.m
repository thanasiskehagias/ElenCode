% fitness function
function fit=fit01(scor,K)
	fit=1/(1+exp(-K*scor));
end
