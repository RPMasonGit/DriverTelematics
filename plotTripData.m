function [position,speed,mag_acceleration] = plotTripData(driver,trip,span1,span2,want_plot)

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
% M = plotTripData(1,200,5,5,1) has a huge spike in velocity that doesn't
% make sense physically

position = loadTrip(driver,trip);

%calculate speed in m/s
%assuming constant speed during each second

velocity = diff(position);
speed = sqrt(sum(velocity.*velocity,2));
speed = smooth(speed,span1);

%calculated acceleration
mag_acceleration = diff(speed);
mag_acceleration = smooth(mag_acceleration,span2);

if want_plot ==1
    figure
    plot(position(:,1),position(:,2))
    
    figure
    plot(speed)
    
    figure
    plot(mag_acceleration)
else
end


end
