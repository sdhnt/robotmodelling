clear all

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
s1=i;
s2=i;
s3=i;

l1_1=10-s1;
l2_1=10+s1;

l1_2=10+s2;
l2_2=10-s2;

l1_3=10-1.5*s3;
l2_3=10+1.5*s3;

d=1;
Lsegment = 10;


%compute the bending angle of seg1
theta1= (l2_1 - l1_1) / (2* d);

%compute the homogeneous matrix A1 and translational vector o1 for seg1
[A1, o1]=transcc2D(theta1);

%compute the bending angle of seg2
theta2= (l2_2 - l1_2) / (2* d);;

%compute the homogeneous matrix A2 and translational vector o2 for seg2
[A2, o2]=transcc2D(theta2);

%compute the bending angle of seg2
theta3= (l2_3 - l1_3) / (2* d);;

%compute the homogeneous matrix A2 and translational vector o2 for seg2
[A3, o3]=transcc2D(theta3);

% compute the tip positions of seg1 and seg2
op3= A1*A2*A3*[p03;1];
op2= A1*A2 *[p02;1];
op1= A1  *[0; 0 ;1];

% compute the orientation and postion of unit vector x axis of seg2
p= A1 * A2  *A3*[p3;1];

%creates a plot and calculates the positions of the end of each segment
PlotThreeSegments(theta1,theta2,theta3,op1,op2,op3,Lsegment);
%quiver3(0,0,o1(1),o1(2),'r'); hold on;
% plot(0,0,'.b'); hold on
% plot(o1(1),o1(2),'.r'); hold on
plot(p(1),p(2),'+r'); hold on
plot([op3(1) p(1)],[op3(2) p(2)],'-b'); hold on
plot(o1(1),o1(2),'+r'); hold on

end


