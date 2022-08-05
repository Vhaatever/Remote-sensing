%The 20 GCP input.

Refmap=[597120 3627050; 597680 3267800; 598285 3627280; ...
        595650 3627730; 596750 3625600; 597830 3624820; ...
        596250 3624380; 602200 3628530; 600350 3629730; ...
        600350 3629340; 600680 3629340; 600440 3682860; ...
        599150 3626990; 600300 3626030; 598840 3626460; ...
        600540 3626450; 596985 3629350; 596035 3627880; ...
        600995 3630000; 601700 3632580];
Inputmap= [150 185; 166 165; 191 180; 98 179; 123 252; ...
           192 294; 137 293; 318 115; 248 93; 259 83; ...
           255 113; 221 186; 266 211; 211 205; 214 295; ...
           272 196; 134 123; 109 174; 269 71; 283 12];
       
% The 7 final GCP selected. For testing the transformation matrix
% 
% Refmap= [598285 3627280; ...
%         595650 3627730;  ...
%         596250 3624380; 602200 3628530; 600350 3629730; ...
%         600440 3628860;  ...
%         600540 3626450];
% Inputmap= [ 191 180; 98 179; 137 293; 318 115; 248 83; 255 113; 272 196];

%Matrix used for redundancy
CRefmap=Refmap;
CInputmap=Inputmap;
RefmapN= Refmap;
InputmapN= Inputmap;


NetError=20; %For ensuring the If condition satisfied for first iteration
s=size(Refmap); %No. of GCP's

for n=1:20 %Iterations 

      Refmap= RefmapN;
      Inputmap= InputmapN;
      %These matrices ensure that the previous iteration results are
      %available for the next iteration

      if NetError>10 %Entry condition for the threshhold/ Tolerance value
          
[TX,TY]=FindCoeff(Refmap,Inputmap); % Finds the coefficient matrix for Refrence map and input image

Outputnet=NMat(Refmap,TX,TY); % Multilies the transformation matrix and the Reference matrix to get the output


[NetError,Row]=RMSError(Inputmap,Outputnet); %The Row matrix contains the row wise error.
[val,Pos]=MaxError(Row); %This function finds the position and the value of the max error from row matrix


%we find the new matrix by deleting the value of max error

t=size(Refmap); 

[InputmapN,RefmapN,OutputnetN]=newmat(Inputmap, Refmap, Outputnet, Pos, t(1,1));

%OutputnetN is the matrix which use to send the values to the next
%iteration


%This stores the net error and the position of the value deleted per
%iteration
AD(n,:)=[NetError Pos];
    
        end
end

%graph(x1,x2,y,b);