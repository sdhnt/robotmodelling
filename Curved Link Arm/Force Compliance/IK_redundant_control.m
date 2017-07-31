function [theta1,theta2,theta3]=IK_Jacobian_redundant(dx,theta1,theta2,theta3,l1,l2,l3)

%px, py,targeted postion, pxk,pyk, current position,thetas, current joint
%angles, l1,2,3, length of links

pv = dx';

J=[-(l1*sin(theta1)+l2*sin(theta2+theta1)+l3*sin(theta3+theta2+theta1)) -(l2*sin(theta2+theta1)+l3*sin(theta3+theta2+theta1)) -l3*sin(theta3+theta2+theta1);
(l1*cos(theta1)+l2*cos(theta2+theta1)+l3*cos(theta3+theta2+theta1)) (l2*cos(theta2+theta1)+l3*cos(theta3+theta2+theta1)) l3*cos(theta3+theta2+theta1)];
Jt= J'*inv(J*J');

dq = Jt*pv';

theta1 = dq(1)+theta1;
theta2 = dq(2)+theta2;
theta3 = dq(3)+theta3;


end

%%inverse kinematics using Jacobian matrix with redundancy
%%change the file name to IK_Jacobian_redundant.m after completion 

