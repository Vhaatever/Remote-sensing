function [TX,TY]=FindCoeff(Refmap,Inputmap);

x1 = Refmap(:,1);
x2 = Refmap(:,2);    % Contains NaN data
y = Inputmap;


X  = [ones(size(x1)) x1  x2];
TX = regress(y(:,1),X);
TY = regress(y(:,2),X);

end