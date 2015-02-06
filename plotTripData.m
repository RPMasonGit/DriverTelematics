function [position,speed,mag_acceleration] = plotTripData(driver,trip,span1,span2,want_plot,threshold)

%a function to plot the position, velocity and acceleration
%of a particular driver during a particular trip

%have to be careful that we don't filter out all
%of the features in the data using the moving average
% span1 sets the width of moving average for speed
% span2 sets the width of moving average for mag_acceleration
% both span1 and pan2 must be odd integers

%the features in the plots seem to be consistent across values of
%spans from 5-9 which is reassuring.

%want_plot =1 selects that you want the function to output
%figures of position, speed and acceleration.

%still need to clean the data to get rid of outliers, for example see
%  [p,s,x] =plotTripData(1,200,5,5,1) has a huge spike in velocity that doesn't
% make sense physically - just a sensor blip

position = loadTrip(driver,trip);

%calculate speed in m/s
%assuming constant speed during each second

velocity = [position(2:end,:);0,0]-[position(1:end-1,:);0,0];

%velocity = diff(position);
speed = sqrt(sum(velocity.*velocity,2));

%if the speed is over the threshold of 50 m/s which is 111 mph I will
%linearly interpolate the velocity between the start and end points of the
%blip

u = find(speed >threshold);

%will assume that any outliers come in the form of isolated errors 

for i=1:length(u)
     speed(u(i))= speed(u(i)+1)+speed(u(i)-1)/2;  %interpolate speeds for any ouliers
end

speed = smooth(speed,span1);

%calculate acceleration
mag_acceleration = diff(speed);
mag_acceleration = smooth(mag_acceleration,span2);

if want_plot ==1
    figure
    title('(x,y) position of car (m)')
    plot(position(:,1),position(:,2))
    
    figure
    title('speed of car (m/s)')
    plot(speed)
    
    figure
    title('acceleration of car (m/s^2)')
    plot(mag_acceleration)
else
end


end
