p02=[0 0]';
p03=[0 0]';
p2=[1 0]';
p3=[1 0]';
s1=0.009;
s2=0.009;
s3=0.009;
d=1;
Lsegment = 10;
t=1;
figure
for i = -pi/8:0.0157:pi/8;
s1=0.001;
s2=0.001;
s3=i;
l1_1=10-s1;
l2_1=10+s1;
l1_2=10-s2;
l2_2=10+s2;
l1_3=10+2*s3;
l2_3=10-2*s3;
d=1;
Lsegment = 10;
theta1(t)= (l2_1 - l1_1) / (2* d);
[A1, o1]=transcc2D(theta1(t));
theta2(t)= (l2_2 - l1_2) / (2* d);
[A2, o2]=transcc2D(theta2(t));
theta3(t)= (l2_3 - l1_3) / (2* d);
[A3, o3]=transcc2D(theta3(t));
theta_total(t)=theta1(t)+theta2(t)+theta3(t);

op3= A1*A2*A3*[p03;1];
op2= A1*A2 *[p02;1];
op1= A1  *[0; 0 ;1];
p= A1 * A2  *A3*[p3;1];
po(t)=p(1);
pp(t)=p(2);

PlotThreeSegments(theta1(t),theta2(t),theta3(t),op1,op2,op3,Lsegment);

plot(p(1),p(2),'+r'); hold on
plot([op3(1) p(1)],[op3(2) p(2)],'-b'); hold on
plot(o1(1),o1(2),'+r'); hold on
t=t+1;

end




k=t-1;

s1=0.00;
s2=0.00;
s3=-pi/8;

l1_1=10-s1;
l2_1=10+s1;

l1_2=10-s2;
l2_2=10+s2;

l1_3=10+2*s3;
l2_3=10-2*s3;


theta1= (l2_1 - l1_1) / (2* d);
[A1, o1]=transcc2D(theta1);
theta2= (l2_2 - l1_2) / (2* d);
[A2, o2]=transcc2D(theta2);
theta3= (l2_3 - l1_3) / (2* d);
[A3, o3]=transcc2D(theta3);
op3= A1*A2*A3*[p03;1];
op2= A1*A2 *[p02;1];
op1= A1  *[0; 0 ;1];
pa= A1 * A2  *A3*[p3;1];

theta_totala=theta1+theta2+theta3;


for t = 1:k;

pv = [po(t)-pa(1) pp(t)-pa(2) theta_total(t)-theta_totala];
%if theta1=0 then l1=const.
%if theta2=0 then l2=const.
%if theta3=0 then l3=const

pxbth1= -(20*sin(theta3/2)*sin(theta3+theta2+theta1)/theta3)-(20*sin(theta2/2)*sin(theta2+theta1)/theta2)-(20*sin(theta1/2)*sin(theta1)/theta1)+(10*cos(theta1/2)*cos(theta1)/theta1)-(20*sin(theta1/2)*cos(theta1)/(theta1*theta1));

pxbth2= -(20*sin(theta3/2)*sin(theta3+theta2+theta1)/theta3)    -   (20*sin(theta2/2)*sin(theta2+theta1)/theta2)   +   (10*cos(theta2/2)*cos(theta1+theta2)/theta2)   -   (20*sin(theta2/2)*cos(theta1+theta2)/(theta2*theta2));

pxbth3= -(20*sin(theta3/2)*sin(theta3+theta2+theta1)/theta3)    +   (10*cos(theta3/2)*cos(theta1+theta2+theta3)/theta3)   -   (20*sin(theta3/2)*cos(theta1+theta2+theta3)/(theta3*theta3));

pybth1= +(20*sin(theta3/2)*cos(theta3+theta2+theta1)/theta3)+(20*sin(theta2/2)*cos(theta2+theta1)/theta2)+(20*sin(theta1/2)*cos(theta1)/theta1)+  (10*sin(theta1/2)*cos(theta1)/theta1)-(20*sin(theta1/2)*sin(theta1)/(theta1*theta1));

pybth2= +(20*sin(theta3/2)*cos(theta3+theta2+theta1)/theta3)    +   (20*sin(theta2/2)*cos(theta2+theta1)/theta2)   +   (10*sin(theta2/2)*cos(theta1+theta2)/theta2)   -   (20*sin(theta2/2)*sin(theta1+theta2)/(theta2*theta2));

pybth3= +(20*sin(theta3/2)*cos(theta3+theta2+theta1)/theta3)    +   (10*sin(theta3/2)*cos(theta1+theta2+theta3)/theta3)   -   (20*sin(theta3/2)*sin(theta1+theta2+theta3)/(theta3*theta3));

J=[pxbth1 pxbth2 pxbth3;
pybth1 pybth2 pybth3;
1 1 1];

%Define 7 Jacobians

dq = inv(J)*pv';

theta1 = dq(1)+theta1;
theta2 = dq(2)+theta2;
theta3 = dq(3)+theta3;

s1= theta1*d;
s2= theta2*d;
s3= theta3*d;

l1_1(t)=10-s1;
l2_1(t)=10+s1;

l1_2(t)=10-s2;
l2_2(t)=10+s2;

l1_3(t)=10+2*s3;
l2_3(t)=10-2*s3;

[A1, o1]=transcc2D(theta1);
[A2, o2]=transcc2D(theta2);
[A3, o3]=transcc2D(theta3);

op3= A1*A2*A3*[p03;1];
op2= A1*A2*[p02;1];
op1= A1*[0; 0 ;1];
theta_totala= theta1+theta2+theta3;
pa= A1 * A2  *A3*[p3;1];

%creates a plot and calculates the positions of the end of each segment
%quiver3(0,0,o1(1),o1(2),'r'); hold on;
% plot(0,0,'.b'); hold on
% plot(o1(1),o1(2),'.r'); hold on
%plot(p(1),p(2),'+r'); hold on
%plot([op3(1) p(1)],[op3(2) p(2)],'-b'); hold on
%plot(o1(1),o1(2),'+r'); hold on

end
PlotThreeSegments(theta1,theta2,theta3,op1,op2,op3,Lsegment);
%
%figure
%plot(px,py,'r*')
%hold on
%plot(pxe,pye,'b.')

%figure
%error=px-pxe;
%plot(error)
