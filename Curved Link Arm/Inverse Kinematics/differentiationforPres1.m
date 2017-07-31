% theta 1 2 and 3 are joint angles, l1 l2 l3 link length, and ox oy are centre of the obstacle. 

syms l1 l2 l3 s1 s2 s3

l1_1=l1-s1;
l2_1=l1+s1;

l1_2=l2-s2;
l2_2=l2+s2;

l1_3=l3-s3;
l2_3=l3+s3;

theta1= (l2_1 - l1_1) / (2);

alpha1 = pi/2-theta1/2;

theta2= (l2_2 - l1_2) / (2);

alpha2 = pi/2-theta2/2;

theta3= (l2_3 - l1_3) / (2);

alpha3 = pi/2-theta3/2;

px= (2*l1/theta1)*cos(alpha1)*cos(alpha1)+(2*l2/theta2)*cos(alpha2)*cos(alpha2+alpha1)+(2*l3/theta3)*cos(alpha3)*cos(alpha3+alpha2+alpha1);

py= (2*l1/theta1)*cos(alpha1)*sin(alpha1)+(2*l2/theta2)*cos(alpha2)*sin(alpha2+alpha1)+(2*l3/theta3)*cos(alpha3)*sin(alpha3+alpha2+alpha1);


%%NEED TO CHANGE THIS PX AND PY to PA(1) and PA(2) FROM TRANSFORMATION MATRICES

diff(px,theta1) 
diff(px,theta2) 
diff(px,theta3)  
diff(py,theta1)
diff(py,theta2)
diff(py,theta3)
