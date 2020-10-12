function [H] = homographie(A1,B1,C1,D1,A2,B2,C2,D2)
B=[A2';B2';C2';D2'];
s=1;
A1=[A1*s s];
A2=[A2*s s];
B1=[B1*s s];
B2=[B2*s s];
C1=[C1*s s];
C2=[C2*s s];
D1=[D1*s s];
D2=[D2*s s];
Z=[0 0 0];

A= [A1 Z -A1*A2(1,1); Z A1 -A1*A2(1,2);
    B1 Z -B1*B2(1,1); Z B1 -B1*B2(1,2);
    C1 Z -C1*C2(1,1); Z C1 -C1*C2(1,2);
    D1 Z -D1*D2(1,1); Z D1 -D1*D2(1,2)];

A=A(:,1:8);

H=(A'*A)\A'*B;

end

