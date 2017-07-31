function PlotThreeSegments(theta1,theta2,theta3,op1,op2,op3,Lsegment)
    %creates a plot of a two segment continuum manipulator.
    %L1, and L2 are the straight line distances from the base to the 

    %reorganize things to fit function...
    theta = [theta1/2;theta2/2;theta3/2];
    P = [op1,op2,op3];
    
    for ii = 1:3

        %check that angles are not to small
        if abs(theta(ii)) <0.02
            if theta(ii) == 0
                theta(ii) = sign(theta(ii))*0.02;
            end
        end
    end

    %calculate the chord length
    for ii = 1:3
        k(ii) =abs( Lsegment/(2*theta(ii))*sqrt(2*(1-cos(2*theta(ii)))));
    end

    %start plotting process

    %transformation matricies

    Tu2 = [cos(2*theta(1)), sin(2*theta(1)),k(1)*sin(theta(1));
           -sin(2*theta(1)), cos(2*theta(1)), k(1)*cos(theta(1));
           0,               0,               1];

    Tu3= [cos(2*theta(2)), sin(2*theta(2)),k(2)*sin(theta(2));
          -sin(2*theta(2)), cos(2*theta(2)), k(2)*cos(theta(2));
           0,               0,               1];
    Tu31=Tu2*Tu3;       

    %radii of curvature (potential NaN bomb...)
    for ii = 1:3
        r(ii) = abs(k(ii)*cos(theta(ii))/sin(2*theta(ii)));
        %ensure radius is not too big for plot to draw
        if r(ii) > 250
            r(ii) = 250;
        end
    end

    R1_b = [sign(theta(1))*r(1), 0]';
    R2_2 = [sign(theta(2))*r(2), 0]';
    R3_2 = [sign(theta(3))*r(3), 0]';

    % R1_u = Tub*R1_b;
    % R2_u = Tu2*R2_2;

    %angle ranges
    ang1=[0:sign(theta(1))*0.01:2*theta(1)];
    ang2=[0:sign(theta(2))*0.01:2*theta(2)];
    ang3=[0:sign(theta(3))*0.01:2*theta(3)];

    curv1_b = zeros(2,size(ang1,2));
    curv2_2 = zeros(2,size(ang2,2));
    curv3_2 = zeros(2,size(ang3,2));
    
    curv1_u = zeros(3,size(ang1,2));
    curv2_u = zeros(3,size(ang2,2));
    curv3_u = zeros(3,size(ang3,2));
  

    %points of body (to form curve)
    % for ii = 1:size(ang1,2)
    %     curv1_b(:,ii) = sign(theta(1))*[r(1)*(1-cos(ang1(ii))); r(1)*sin(ang1(ii))];
    %     curv1_u(:,ii) = [R1_b + curv1_b(:,ii);1];   
    % end
    % 
    % for ii = 1:size(ang2,2)
    %     curv2_2(:,ii) = sign(theta(2))*[r(2)*(1-cos(ang2(ii))); r(2)*sin(ang2(ii))];
    %     curv2_u(:,ii) = Tu2*[R2_2 + curv2_2(:,ii);1];
    % end

    for ii = 1:size(ang1,2)
        curv1_b(:,ii) = [sign(theta(1))*(r(1)-r(1)*cos(ang1(ii))); r(1)*sin(abs(ang1(ii)))];
        curv1_u(:,ii) = [curv1_b(:,ii);1];   
    end

    for ii = 1:size(ang2,2)

        curv2_2(:,ii) = [sign(theta(2))*(r(2)-r(2)*cos(ang2(ii))); r(2)*sin(abs(ang2(ii)))];
        curv2_u(:,ii) = Tu2*[curv2_2(:,ii);1];
        m = 1+1;
    end
    for ii = 1:size(ang3,2)

        curv3_2(:,ii) = [sign(theta(3))*(r(3)-r(3)*cos(ang3(ii))); r(3)*sin(abs(ang3(ii)))];
        curv3_u(:,ii) = Tu31*[curv3_2(:,ii);1];
    end

    %
    figure(1),
    
    plot(curv1_u(1,:),curv1_u(2,:),curv2_u(1,:),curv2_u(2,:),curv3_u(1,:),curv3_u(2,:),...
    P(1,:),P(2,:),'k.','MarkerSize',16);
    hold on;
    axis('equal')
    %axis([0, 10, 0, 10]);

    xlabel('X / [mm]')
    ylabel('Y / [mm]')

end