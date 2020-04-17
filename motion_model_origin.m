function xcur = motion_model_origin(xprev, u, dt)
    dt_b = dt*[u];
    dt_b(3) = u(3)
    R = rot(-xprev(3),3);
    
    xcur = xprev + R*dt_b;
%     xcur(3) = u(3);
    u
end 