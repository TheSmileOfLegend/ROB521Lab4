%% motion model
%
% Input: 
% xprev = [x, y, theta]' 
% u = [vx vy theta]';
% vx     - speed x
% vy     - speed y 
% theta  - angle
%        
% Output:
% xcur - new robot state [x, y, theta]'

function xcur = motion_model(xprev, u, dt)
% dt >= 0.2
    theta = xprev(3);
    v = [u(1);u(2)];
    if norm(v) > 20
        v = v/norm(v)*20;
    end
    dt_v = dt*v;
    dt_theta = u(3)-xprev(3);
    R = [cos(theta),-sin(theta),0;sin(theta),cos(theta),0;0,0,1];
    xcur = xprev + R*[dt_v;dt_theta];
end 