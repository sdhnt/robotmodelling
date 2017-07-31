p02=[0 0]';p03=[0 0]';p2=[1 0]';p3=[1 0]';d=1;k0=1.0;k1=22.0;
Lsegment = 10;
t=1;
s1=-pi/8;
s2=-pi/8;
s3=-pi/8;
l1_1=10-s1;
l2_1=10+s1;
l1_2=10-s2;
l2_2=10+s2;
l1_3=10-s3;
l2_3=10+s3;
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
l1=l2=l3=10;
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

Jps=J*J';
Jps1=inv(J*J')
[V R]=eig(Jps);
[V1 R1]=eig(Jps1);

ax1e  = k0* sqrt(R(1,1)) * V(:,1);
ax2e  = k0* sqrt(R(2,2)) * V(:,2);
ax1e1  = k1* sqrt(R1(1,1)) * V1(:,1);
ax2e1  = k1* sqrt(R1(2,2)) * V1(:,2);
%plotting-leave it unchanged
ang = atan2(ax1e(2),ax1e(1));
h=ellipse(norm(ax1e),norm(ax2e),ang,p(1),p(2),[0 1 0],200);
ang1 = atan2(ax1e1(2),ax1e1(1));
h1=ellipse(norm(ax1e1),norm(ax2e1),ang1,p(1),p(2),[0 1 0],200);

PlotThreeSegments(theta1(t),theta2(t),theta3(t),op1,op2,op3,Lsegment);



line([p(1) p(1)+ax1e(1)],[p(2) p(2)+ax1e(2)],'Color','k')
line([p(1) p(1)+ax2e(1)],[p(2) p(2)+ax2e(2)],'Color','r')

line([p(1) p(1)+ax1e1(1)],[p(2) p(2)+ax1e1(2)],'Color','k')
line([p(1) p(1)+ax2e1(1)],[p(2) p(2)+ax2e1(2)],'Color','r')
drawnow;

