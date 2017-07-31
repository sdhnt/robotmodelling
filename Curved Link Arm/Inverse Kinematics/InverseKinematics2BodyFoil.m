clear all
t=1;
% origin of the tip of seg2
p02=[0 0]';
p03=[0 0]';

% unit vector along x axis in the tip local frame of seg2
p2=[1 0]';
p3=[1 0]';
s1=0.0;
s2=0.0;
s3=0.0;

for i = -pi/8:0.0157:pi/8;
s1=0.0009;
s2=i;
s3=i;

l1_1=10-s1;
l2_1=10+s1;

l1_2=10-s2;
l2_2=10+s2;

l1_3=10+s3;
l2_3=10-s3;

d=1;
Lsegment = 10;

theta1(t)= (l2_1 - l1_1) / (2* d);

%compute the homogeneous matrix A1 and translational vector o1 for seg1
[A1, o1]=transcc2D(theta1(t));

%compute the bending angle of seg2
theta2(t)= (l2_2 - l1_2) / (2* d);;

%compute the homogeneous matrix A2 and translational vector o2 for seg2
[A2, o2]=transcc2D(theta2(t));

%compute the bending angle of seg2
theta3(t)= (l2_3 - l1_3) / (2* d);;

%compute the homogeneous matrix A2 and translational vector o2 for seg2
[A3, o3]=transcc2D(theta3(t));

theta_total(t)=theta1(t)+theta2(t)+theta3(t);

% compute the tip positions of seg1 and seg2
op3= A1*A2*A3*[p03;1];
op2= A1*A2 *[p02;1];
op1= A1  *[0; 0 ;1];

% compute the orientation and postion of unit vector x axis of seg2
p= A1 * A2  *A3*[p3;1];

po(t)=p(1);
pp(t)=p(2);

%creates a plot and calculates the positions of the end of each segment
PlotThreeSegments(theta1(t),theta2(t),theta3(t),op1,op2,op3,Lsegment);
%quiver3(0,0,o1(1),o1(2),'r'); hold on;
% plot(0,0,'.b'); hold on
% plot(o1(1),o1(2),'.r'); hold on
plot(p(1),p(2),'+r'); hold on
plot([op3(1) p(1)],[op3(2) p(2)],'-b'); hold on
plot(o1(1),o1(2),'+r'); hold on
t=t+1;
end


k=t-1;

s1=0.0009;
s2=-pi/8;
s3=-pi/8;

l1_1=10-s1;
l2_1=10+s1;

l1_2=10-s2;
l2_2=10+s2;

l1_3=10+s3;
l2_3=10-s3;

theta1= (l2_1 - l1_1) / (2* d);
[A1, o1]=transcc2D(theta1);
theta2= (l2_2 - l1_2) / (2* d);
[A2, o2]=transcc2D(theta2);
theta3= (l2_3 - l1_3) / (2* d);
[A3, o3]=transcc2D(theta3);
op3= A1*A2*A3*[p03;1];
op2= A1*A2 *[p02;1];
op1= A1  *[0; 0 ;1];
pa= A1*A2*A3*[p3;1];

theta_totala=theta1+theta2+theta3;


for t = 1:k

pv = [po(t)-pa(1) pp(t)-pa(2) theta_total(t)-theta_totala];
%if theta1=0 then l1=const.
%if theta2=0 then l2=const.
%if theta3=0 then l3=const
l1=10;
l2=10;
l3=10;
s1=theta1;
s2=theta2;
s3=theta3;

pxbth1= (2*l1*sin(s1/2)*cos(s1/2)/s1)-(2*l1*sin(s1/2)*sin(s1/2)/(s1*s1))+(l2*sin(s2/2)*sin(s1/2+s2/2)/s2)-(l3*sin(s3/2)*cos(s1/2+s2/2+s3/2)/s3);

pxbth2= (l2*sin(s2/2)*sin(s1/2+s2/2)/s2) - (l2*cos(s2/2)*cos(s1/2+s2/2)/s2) + (2*l2*sin(s2/2)*cos(s1/2+s2/2)/(s2*s2))-(l3*sin(s3/2)*cos(s1/2+s2/2+s3/2)/s3);

pxbth3= -(l3*sin(s3/2)*cos(s1/2+s2/2+s3/2)/s3) - (l3*sin(s1/2+s2/2+s3/2)*cos(s3/2)/s3) + (2*l3*sin(s1/2+s2/2+s3/2)*sin(s3/2)/(s3*s3))

pybth1= -(l1*sin(s1/2)*sin(s1/2)/s1)+(l1*cos(s1/2)*cos(s1/2)/s1)   -  (2*l1*sin(s1/2)*cos(s1/2)/(s1*s1))+  (l2*sin(s2/2)*cos(s1/2+s2/2)/s2)+ (l3*sin(s3/2)*sin(s1/2+s2/2+s3/2)/s3);

pybth2= (l2*sin(s2/2)*cos(s1/2+s2/2)/s2) + (l2*cos(s2/2)*sin(s1/2+s2/2)/s2) - (2*l2*sin(s2/2)*sin(s1/2+s2/2)/(s2*s2))+(l3*sin(s3/2)*sin(s1/2+s2/2+s3/2)/s3);

pybth3= (l3*sin(s3/2)*sin(s1/2+s2/2+s3/2)/s3) - (l3*cos(s1/2+s2/2+s3/2)*cos(s3/2)/s3) + (2*l3*cos(s1/2+s2/2+s3/2)*sin(s3/2)/(s3*s3))

J=[pxbth1 pxbth2 pxbth3;
pybth1 pybth2 pybth3;
1 1 1];


dq = inv(J)*pv';

theta1 = dq(1)+theta1;
theta2 = dq(2)+theta2;
theta3 = dq(3)+theta3;

s1=theta1;
s2=theta2;
s3=theta3;

l1_1(t)=10-s1;
l2_1(t)=10+s1;

l1_2(t)=10-s2;
l2_2(t)=10+s2;

l1_3(t)=10+s3;
l2_3(t)=10-s3;

[A1, o1]=transcc2D(theta1);
[A2, o2]=transcc2D(theta2);
[A3, o3]=transcc2D(theta3);

op3= A1*A2*A3*[p03;1];
op2= A1*A2*[p02;1];
op1= A1*[0; 0 ;1];
theta_totala= theta1+theta2+theta3;
pa= A1 * A2  *A3*[p3;1];

PlotThreeSegmentsinverse(theta1,theta2,theta3,op1,op2,op3,Lsegment); hold on;
%creates a plot and calculates the positions of the end of each segment
%quiver3(0,0,o1(1),o1(2),'r'); hold on;
% plot(0,0,'.b'); hold on
% plot(o1(1),o1(2),'.r'); hold on
%plot(p(1),p(2),'+r'); hold on
%plot([op3(1) p(1)],[op3(2) p(2)],'-b'); hold on
%plot(o1(1),o1(2),'+r'); hold on
end
%

%figure
%plot(px,py,'r*')
%hold on
%plot(pxe,pye,'b.')

%figure
%error=px-pxe;
%plot(error)