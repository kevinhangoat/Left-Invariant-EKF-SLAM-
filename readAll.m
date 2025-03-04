% clear all; clc;
% % IMU data
% ms25 = readtable('ms25.csv');
% t = table2array(ms25(1:end, 1));
% t = t/1e6;
% mag_x = table2array(ms25(1:end, 2));
% mag_y = table2array(ms25(1:end, 3));
% mag_z = table2array(ms25(1:end, 4));
% 
% accel_x = table2array(ms25(1:end, 5));
% accel_y = table2array(ms25(1:end, 6));
% accel_z = table2array(ms25(1:end, 7));
% 
% rotational_x = table2array(ms25(1:end, 8));
% rotational_y = table2array(ms25(1:end, 9));
% rotational_z = table2array(ms25(1:end, 10));
% 
% delta_t = zeros(size(t));
% delta_t(1) = t(1);
% IMU_data = struct([]);
% 
% 
% for t_temp = 2:length(t)
%     delta_t(t_temp) = (t(t_temp) - t(t_temp-1));
% end
% 
% for t_temp = 1:length(t)
%     IMU_data(t_temp,:) = struct;
% end
% for t_temp = 1:length(t)
%     IMU_data(t_temp).Time = t(t_temp);
%     IMU_data(t_temp).dt = delta_t(t_temp);
%     IMU_data(t_temp).accelX = accel_x(t_temp);
%     IMU_data(t_temp).accelY = accel_y(t_temp);
%     IMU_data(t_temp).accelZ = accel_z(t_temp);
%     IMU_data(t_temp).omegaX = rotational_x(t_temp);
%     IMU_data(t_temp).omegaY = rotational_y(t_temp);
%     IMU_data(t_temp).omegaZ = rotational_z(t_temp);
% end
% 
% 
%% GPS data
% GPS = readtable('gps.csv');
% t2 = table2array(GPS(1:end, 1))/1e6;
% 
% latitude = table2array(GPS(1:end, 4));
% longitude = table2array(GPS(1:end, 5));
% altitude = table2array(GPS(1:end, 6));
% GPS_data = struct([]);
% 
% delta_t_gps = zeros(size(t2));
% delta_t_gps(1) = t2(1);
% 
% for t_temp = 2:length(t2)
%     delta_t_gps(t_temp) = (t2(t_temp) - t2(t_temp-1));
% end
% for t_temp = 1:length(t2)
%     GPS_data(t_temp,:) = struct;
% end
% for t_temp = 1:length(t2)
%     GPS_data(t_temp).Time = t2(t_temp);
%     GPS_data(t_temp).dt = delta_t_gps(t_temp);
%     GPS_data(t_temp).X = (latitude(t_temp) - latitude(1)) * 180 / pi * 111139 ;
%     GPS_data(t_temp).Y = (longitude(t_temp) - longitude(1)) * 180 /pi * 111139;
%     GPS_data(t_temp).Z = altitude(t_temp) - altitude(1);
% end
% save('IMU_data.mat', 'IMU_data')
% save('GPS_data.mat', 'GPS_data')



%%
% clc; clear all; close all;
% IMU data
ms25 = readtable('ms25.csv');
t = table2array(ms25(1:floor(end), 1));
t = t/1e6;
mag_x = table2array(ms25(1:floor(end), 2));
mag_y = table2array(ms25(1:floor(end), 3));
mag_z = table2array(ms25(1:floor(end), 4));

accel_x = table2array(ms25(1:floor(end), 5));
accel_y = table2array(ms25(1:floor(end), 6));
accel_z = table2array(ms25(1:floor(end), 7));

rotational_x = table2array(ms25(1:floor(end), 8));
rotational_y = table2array(ms25(1:floor(end), 9));
rotational_z = table2array(ms25(1:floor(end), 10));

delta_t = zeros(size(t));
delta_t(1) = t(1);
IMU_data = struct([]);


for t_temp = 2:length(t)
    delta_t(t_temp) = (t(t_temp) - t(t_temp-1));
end

for t_temp = 1:length(t)/7
    IMU_data(t_temp,:) = struct;
end
for t_temp = 1:length(t)/6
    IMU_data(t_temp).Time = t(6*t_temp);
    IMU_data(t_temp).dt = delta_t(6*t_temp);
    IMU_data(t_temp).accelX = accel_x(6*t_temp);
    IMU_data(t_temp).accelY = accel_y(6*t_temp);
    IMU_data(t_temp).accelZ = accel_z(6*t_temp);
    IMU_data(t_temp).omegaX = rotational_x(6*t_temp);
    IMU_data(t_temp).omegaY = rotational_y(6*t_temp);
    IMU_data(t_temp).omegaZ = rotational_z(6*t_temp);
end

%%

% GPS data
GPS = readtable('gps.csv');
t2 = table2array(GPS(1:floor(end), 1))/1e6;

latitude = table2array(GPS(1:floor(end), 4));
longitude = table2array(GPS(1:floor(end), 5));
altitude = table2array(GPS(1:floor(end), 6));
GPS_data = struct([]);

delta_t_gps = zeros(size(t2));
delta_t_gps(1) = t2(1);

for t_temp = 2:length(t2)
    delta_t_gps(t_temp) = (t2(t_temp) - t2(t_temp-1));
end
for t_temp = 1:length(t2)
    GPS_data(t_temp,:) = struct;
end
for t_temp = 1:length(t2)
    GPS_data(t_temp).Time = t2(t_temp);
    GPS_data(t_temp).dt = delta_t_gps(t_temp);
    GPS_data(t_temp).X = (latitude(t_temp) - latitude(1)) * 180 / pi * 111139 ;
    GPS_data(t_temp).Y = (longitude(t_temp) - longitude(1)) * 180 /pi * 111139;
    GPS_data(t_temp).Z = 0;
end
save('IMU_data.mat', 'IMU_data')
save('GPS_data.mat', 'GPS_data')

%%
% figure
plot([GPS_data.X], [GPS_data.Y], 'b')


