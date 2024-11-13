% payoff function with stationary strats (x1,x2)
function [PO1,PO2]= payoffs01(p1,p2,a,b,x1,x2)
	if x1==0 && x2==0
		PO1=0;
		PO2=0;
	else
		PO1 = (x1 * p1 * x2 * p2 * (a - b) + x1 * p1 * ((1-x2) + x2 * (1 - p2)) * a + ((1-x1) + x1 * (1 - p1)) * x2 * p2 * (-b)) / (1 - (x1 * (1 - p1) * x2 * (1 - p2) + (1 - x1) * x2 * (1 - p2) + x1 * (1 - p1) * (1 - x2) + (1 - x1) * (1 - x2)));
		PO2 = (x1 * p1 * x2 * p2 * (a - b) + x1 * p1 * ((1-x2) + x2 * (1 - p2)) * (-b) + ((1-x1) + x1 * (1 - p1)) * x2 * p2 * (a)) / (1 - (x1 * (1 - p1) * x2 * (1 - p2) + (1 - x1) * x2 * (1 - p2) + x1 * (1 - p1) * (1 - x2) + (1 - x1) * (1 - x2)));
	end
end
