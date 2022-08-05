function [T,P,Q]=newmat(Inputmap, Refmap, Outputnet, Pos, s)
A=Inputmap;
B=Refmap;
C=Outputnet;
delete=Pos; 

    A(delete,:) = [];
    B(delete,:) = [];
    C(delete,:) = [];
    %This deletes the position where there is a max error.
    T=A;
    P=B;
    Q=C;
 end 