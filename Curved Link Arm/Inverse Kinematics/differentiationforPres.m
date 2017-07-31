% theta 1 2 and 3 are joint angles, l1 l2 l3 link length, and ox oy are centre of the obstacle. 

syms theta1 theta3 theta2 l1 l2 l3 ox oy  

alpha1 = pi/2-theta1/2;
alpha2 = pi/2-theta2/2;
alpha3 = pi/2-theta3/2;


l1=((20/theta1)*cos(alpha1));
l2=((20/theta2)*cos(alpha2));
l3=((20/theta3)*cos(alpha3));

px = l1*cos(theta1)+l2*cos(theta2+theta1)+l3*cos(theta3+theta2+theta1);
py = l1*sin(theta1)+l2*sin(theta2+theta1)+l3*sin(theta3+theta2+theta1);

diff(px,theta1) 
diff(px,theta2) 
diff(px,theta3)  
diff(py,theta1)
diff(py,theta2)
diff(py,theta3)
