%
clear all
close all
%
p1=4;
p2=1+1i*4;
p3=conj(p2);
ki = 5;
dens=conv([1 p1],conv([1 p2],[1 p3]));
nums=zeros(size(dens));
nums(end-1)=1;
nums(end)=p1*abs(p2)^2;
[A,B,C,D]=tf2ss(nums,dens);
Hol=tf(nums,dens);
%
n=length(dens)-1;
%
po=[-5+1i*5,-5-1i*5,-6];
pc=[-7+1i*7,-7-1i*7,-8];
J=place(A',C',po).';
K=place(A,B,pc);
G=[K 1]*inv([A B; C 0])*[zeros(n,1); 1];
%
syms s
e1=det(s*eye(n)-A+J*C);
e2=det(s*eye(n)-A+B*K);
%
Aa=[0               -C               zeros(size(C))
    B*ki            A-B*K            -B*K;
    zeros(size(C')) zeros(size(B*K)) A-J*C];
Ba=[1;zeros(size(B));zeros(size(B))];
Ca=[0 C zeros(size(C))];
Da=0;
Hcla=ss(Aa,Ba,Ca,Da);
%
E1=sym2poly(e1);
E2=sym2poly(e2);
E=conv(E1,E2)';
%
% deg(L)=n, deg(P)=n-1, deg(E)=n+n
M=[[dens 0 0 0]' [0 dens 0 0]' [0 0 dens 0]' [0 0 0 dens]' [0 nums 0 0]' [0 0 nums 0]'  [0 0 0 nums]'];
%
x=pinv(M)*E;
L=[x(1) x(2) x(3) x(4)];
P=[x(5) x(6) x(7)];
%
Gfb=tf(P,L);
Gff=tf(G*E1,L);
%
Hfb=feedback(Hol,Gfb,-1);
Hcl=minreal(Gff*Hfb);
[numcl,dencl]=tfdata(Hcla,'v');
%
sim('../Simulink/goodwin.slx')
%
