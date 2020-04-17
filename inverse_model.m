function [new_og] = inverse_model(map,current_X,current_og)
meas_phi = linspace(-69/2/180*pi,69/2/180*pi,128);
% 10 meter rmax, 0.1 m grid resolution
measurements = getranges(map,current_X, meas_phi, 10, 0.1);

end