% Initialization
I = imread('Racecourse.png');
map = im2bw(I, 0.4); % Convert to 0-1 image
map = flipud(1-map)'; % Convert to 0 free, 1 occupied and flip.
[M,N]= size(map); % Map size

% Robot start position
dxy = 0.1;
startpos = dxy*[350 250];
checkpoints = dxy*[440 620; 440 665];

% Plotting
figure(1); clf; hold on;
colormap('gray');
imagesc(1-map');
plot(startpos(1)/dxy, startpos(2)/dxy, 'ro', 'MarkerSize',10, 'LineWidth', 3);
plot(checkpoints(:,1)/dxy, checkpoints(:,2)/dxy, 'g-x', 'MarkerSize',10, 'LineWidth', 3 );
xlabel('North (decimeters)')
ylabel('East (decimeters)')
axis equal
%%
oglo = ones(M,N);
ogp = zeros(M,N);
terminate = false;
t = 0;
T = 1;
figure(2); clf; hold on;
colormap('gray');
imagesc(1-ogp');
current_X = [startpos, 0]';
measurement_flag = true;
meas_phi = linspace(-69/2/180*pi,69/2/180*pi,128);

%%
while ((~terminate) && (t < T))
    if (measurement_flag)
        measurements = getranges(map,current_X, meas_phi, 10, 0.1);
        [ogp,oglo] = og_update(M,N,current_X,oglo,ogp,meas_phi, measurements);
        t = t+1
    end
end

t = 0;
figure(3); clf; 
hold on;

colormap('gray');
imagesc(1-ogp');
hold on;
plot(current_X(1)/dxy, current_X(2)/dxy, 'ro', 'MarkerSize',10, 'LineWidth', 3);

