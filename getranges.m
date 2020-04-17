function [meas_r] = getranges(map,X, meas_phi, rmax, alpha)
% Generate range measurements for a laser scanner based on a map, vehicle
% position and sensor parameters.
% Rough implementation of ray tracing algorithm.

% Initialization
[M,N] = size(map);
x = X(1);
y = X(2);
th = X(3);
meas_r = rmax*zeros(size(meas_phi));

% For each measurement bearing
for i=1:length(meas_phi)
    % For each unit step along that bearing up to max range
   for j=1:round(rmax/(alpha/2))
       % Determine the x,z range to the cell
       xi = x+alpha/2*j*cos(th+meas_phi(i));
       yi = y+alpha/2*j*sin(th+meas_phi(i));
       % Determine cell coordinates
       ix = round(xi/alpha);
       iy = round(yi/alpha);
       
       % If not in the map, set measurement there and stop going further 
       % If not in the map, set measurement invalid and stop going further 
       if (ix<1||ix>M||iy<1||iy>N)
           meas_r(i) = alpha/2*j;
           break;
       % If in the map but hitting an obstacle, set measurement range and
       % stop going further
       elseif (map(ix,iy))
           meas_r(i) = alpha/2*j;
           break;
       elseif (j==round(rmax/(alpha/2)))
           meas_r(i) = rmax;
       end
       
   end
end
