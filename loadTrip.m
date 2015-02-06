function M = loadTrip(driver,trip)

%takes in two numbers, driver and trip that identifies which
%trip by which driver to load up into an array.

filename= strcat('./',num2str(driver),'/',num2str(trip),'.csv');

M = csvread(filename,1,0);
