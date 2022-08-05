function Outputnet=NMat(Refmap,TX,TY)

s=size(Refmap);
temp=ones(s(1),1);
MatInp=[temp Refmap(:,1) Refmap(:,2)]; 
% TX=[0.03418777 -0.0054810 -382.2366479]

OutputX=MatInp*TX;    
OutputY=MatInp*TY;
Outputnet=[OutputX OutputY]; 
%Finds the output matrix by multiplying with individual transformation matrix

end