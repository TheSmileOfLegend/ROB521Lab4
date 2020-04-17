function [new_ogp,new_oglo] = og_update(ognx,ogny,current_X,oglo,ogp,angles, measurements)
ogxmin = 0;
ogymin = 0;
r_max_laser = 10;
r_min_laser = 0.3;
phi_min_laser = -69/2/180*pi;
phi_max_laser = 69/2/180*pi;
ogres = 0.1;
angle_seg_width = (phi_max_laser-phi_min_laser)/127;
for x_index = 1:ognx
    for y_index = 1:ogny
        % compute x, y position of the cell (use the center position % values to represent the grid)
        x_cell = ogxmin + (x_index - 0.5) * ogres;
        y_cell = ogymin + (y_index - 0.5) * ogres;
        dx_cell = x_cell - current_X(1);
        dy_cell = y_cell - current_X(2);
        distance_cell = sqrt((dx_cell)^2 + (dy_cell)^2);
        % compute omega of cell relative to robot's current position
        theta_cell = atan2d(dy_cell, dx_cell)/180*pi;
        dtheta_cell = wrapToPi(theta_cell - current_X(3));
        % cell not at front of view due to angle limitation
        if dtheta_cell < phi_min_laser || dtheta_cell > phi_max_laser
            continue
        end
        segment = find(abs(angles - dtheta_cell) <= angle_seg_width);
        if measurements(segment(1)) < r_max_laser && measurements(segment(1)) > r_min_laser
            distance_laser = measurements(segment(1));
        else
            continue
        end
        % farther than measured range
        if distance_cell > distance_laser + ogres
            continue
        % closer than measured range
        elseif distance_cell < distance_laser - ogres
            oglo(x_index,y_index) = oglo(x_index, y_index) - 5;
        else
            oglo(x_index,y_index) = oglo(x_index, y_index) + 5;
        end
        ogp(x_index,y_index) = exp(oglo(x_index, y_index))/(1+exp(oglo(x_index, y_index)));
        
        
    end
end
new_ogp = ogp;
new_oglo = oglo;
end