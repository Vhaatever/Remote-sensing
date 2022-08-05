      
      function [NetError,RmsRow]=RMSError(Or, New)
%      Or=Inputmap
%      New=Outputnet
      Error=(New-Or);    
      P=(Error(:,1).^2)+(Error(:,2).^2);
      RmsRow=sqrt(P); %Finds the individual error for each row stored in RmsRow
      
 t=size(Or);
 E= Or-New;
 SQE= E.^2;
 MSE= sum(SQE(:))/t(1,1);
 NetError = sqrt(MSE); %Calculates net RMSE error
  
      end
      
      