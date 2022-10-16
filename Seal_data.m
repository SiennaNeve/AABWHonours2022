%load the data 
darnley = load('Darnley_for_Sienna.mat');
salt = darnley.darnley.sal;
temp = darnley.darnley.temp;
pres = darnley.darnley.pres;
time = darnley.darnley.time;
lat = darnley.darnley.lat;
lon = darnley.darnley.lon;





%create new variables for each year: (data is from 2004-2019, so the 8th year is
%2011)
salt_2005 = salt{2};
salt_2007 = salt{4};
salt_2011 = salt{8};
salt_2012 = salt{9};
salt_2013 = salt{10};
salt_2014 = salt{11};
salt_2015 = salt{12};
salt_2016 = salt{13};
salt_2018 = salt{15};
salt_2019 = salt{16};



temp_2005 = temp{2};
temp_2007 = temp{4};
temp_2011 = temp{8};
temp_2012 = temp{9};
temp_2013 = temp{10};
temp_2014 = temp{11};
temp_2015 = temp{12};
temp_2016 = temp{13};
temp_2018 = temp{15};
temp_2019 = temp{16};


pres_2005 = pres{2};
pres_2007 = pres{4};
pres_2011 = pres{8};
pres_2012 = pres{9};
pres_2013 = pres{10};
pres_2014 = pres{11};
pres_2015 = pres{12};
pres_2016 = pres{13};
pres_2018 = pres{15};
pres_2019 = pres{16};


lat_2011 = lat{8};
lat_2012 = lat{9};
lat_2013 = lat{10};
lat_2014 = lat{11};
lat_2015 = lat{12};
lat_2016 = lat{13};
lat_2018 = lat{15};
lat_2019 = lat{16};

lon_2011 = lon{8};
lon_2012 = lon{9};
lon_2013 = lon{10};
lon_2014 = lon{11};
lon_2015 = lon{12};
lon_2016 = lon{13};
lon_2018 = lon{15};
lon_2019 = lon{16};

lat_cd = -67.584572;
lon_cd = 70.715318;

lat_cdp = -67.5;
lon_cdp = 69;








%convert time to something readable
time_2011=time{8};
time_2012=time{9};
time_2013=time{10};
time_2014=time{11};
time_2015=time{12};
time_2016=time{13};
time_2018=time{15};
time_2019=time{16};
%time_2011 = datevec(time_2011);
%figure out how many days since 0
%year_2011 = 365*2011+(2011/4);
%or use this website to find no. days since 0 for first day 2011 https://www.epochconverter.com/seconds-days-since-y0#:~:text=Days%20Since%20Year%200%20Compatible%20with%20MySQL%27s%20TO_DAYS,between%200000-00-00%20and%20today%20%28Tuesday%2C%20Jul%2026%2C%202022%29.
year_2011 = 734503;
year_2012 = year_2011 + 365;
year_2013 = year_2012 + 366;
year_2014 = year_2013 + 365;
year_2015 = year_2014 + 365;
year_2016 = year_2015 + 365;
year_2018 = year_2016 + 366 + 365;
year_2019 = year_2018 + 365;
%remove how many days since 0 to figure out the day of the year in 2011 
time_2011 = time_2011-year_2011;
time_2012 = time_2012-year_2012;
time_2013 = time_2013-year_2013;
time_2014 = time_2014-year_2014;
time_2015 = time_2015-year_2015;
time_2016 = time_2016-year_2016;
time_2018 = time_2018-year_2018;
time_2019 = time_2019-year_2019;


%don't remember what I was trying to do here
%time_2011_r = repmat(time_2011,2000,1);
%this formula gives you the date & time in a vector format but this is
%annoying to work with 
time_2011_j = datevec(time_2011);




%turn the time 1xn time matrices into 2000xn so matches salt & temp no. of
%rows
time_2011_repmat = repmat(time_2011,2000,1);
time_2012_repmat = repmat(time_2012,2000,1);
time_2013_repmat = repmat(time_2013,2000,1);
time_2014_repmat = repmat(time_2014,2000,1);
time_2015_repmat = repmat(time_2015,2000,1);
time_2016_repmat = repmat(time_2016,2000,1);
time_2018_repmat = repmat(time_2018,2000,1);
time_2019_repmat = repmat(time_2019,2000,1);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%create a custom colour bar (mine is a new colour every 30 days to indicate
%seasons (e.g. red=summer, yellow=autumn, blue=winter & green=spring)
custom_map = [1 0 0
    1 0 0
    0.9290 0.6940 0.1250
    0.9290 0.6940 0.1250
    0.9290 0.6940 0.1250
    0 0 1
    0 0 1
    0 0 1
    0 1 0
    0 1 0
    0 1 0
    1 0 0];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%this is code to plot one profile of seal data, definitely should make this
%a for loop in the future so that it cycles through them. Rn it is just
%doing the first column 
salt_2011_1 = salt_2011(:,1)
temp_2011_1 = temp_2011(:,1)
pres_2011_1 = pres_2011(:,1)

salt_2011_1(salt_2011_1 == 0) = NaN;
temp_2011_1(temp_2011_1 == 0) = NaN;
pres_2011_1(pres_2011_1 == 0) = NaN;

salt_2011_1 = rmmissing(salt_2011_1)
temp_2011_1 = rmmissing(temp_2011_1)
pres_2011_1 = rmmissing(pres_2011_1)

plot(temp_2011_1, pres_2011_1)
title('Mean Annual Salinity Profile', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
grid on


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%find min & max values for salt & temp at surface level (top 10m) and use
%these for the ROMS model

salt_2011_surface = salt_2011(1:10, :);
salt_2012_surface = salt_2012(1:10, :);
salt_2013_surface = salt_2013(1:10, :);
salt_2014_surface = salt_2014(1:10, :);
salt_2015_surface = salt_2015(1:10, :);
salt_2016_surface = salt_2016(1:10, :);
salt_2018_surface = salt_2018(1:10, :);
salt_2019_surface = salt_2019(1:10, :);

%only 2011 & 2018 had winter data 
salt_2011_surface_winter = salt_2011(1:10, 357:472);
salt_2018_surface_winter = salt_2018(1:10, 420:431);

max_salt_2011 = max(salt_2011_surface, [], 'all');
max_salt_2012 = max(salt_2012_surface, [], 'all');
max_salt_2013 = max(salt_2013_surface, [], 'all');
max_salt_2014 = max(salt_2014_surface, [], 'all');
max_salt_2015 = max(salt_2015_surface, [], 'all');
max_salt_2016 = max(salt_2016_surface, [], 'all');
max_salt_2018 = max(salt_2018_surface, [], 'all');
max_salt_2019 = max(salt_2019_surface, [], 'all');

max_salt_2011_winter = max(salt_2011_surface_winter, [], 'all');
max_salt_2018_winter = max(salt_2018_surface_winter, [], 'all');

%have to remove zero values as it is ruining the data (salt can't be 0)
salt_2011_surface(salt_2011_surface == 0) = NaN;
salt_2012_surface(salt_2012_surface == 0) = NaN;
salt_2013_surface(salt_2013_surface == 0) = NaN;
salt_2014_surface(salt_2014_surface == 0) = NaN;
salt_2015_surface(salt_2015_surface == 0) = NaN;
salt_2016_surface(salt_2016_surface == 0) = NaN;
salt_2018_surface(salt_2018_surface == 0) = NaN;
salt_2019_surface(salt_2019_surface == 0) = NaN;

salt_2011_surface_winter(salt_2011_surface_winter == 0) = NaN;
salt_2018_surface_winter(salt_2018_surface_winter == 0) = NaN;

min_salt_2011 = min(salt_2011_surface, [], 'all');
min_salt_2012 = min(salt_2012_surface, [], 'all');
min_salt_2013 = min(salt_2013_surface, [], 'all');
min_salt_2014 = min(salt_2014_surface, [], 'all');
min_salt_2015 = min(salt_2015_surface, [], 'all');
min_salt_2016 = min(salt_2016_surface, [], 'all');
min_salt_2018 = min(salt_2018_surface, [], 'all');
min_salt_2019 = min(salt_2019_surface, [], 'all');

min_salt_2011_winter = min(salt_2011_surface_winter, [], 'all');
min_salt_2018_winter = min(salt_2018_surface_winter, [], 'all');




temp_2011_surface = temp_2011(1:10, :);
temp_2012_surface = temp_2012(1:10, :);
temp_2013_surface = temp_2013(1:10, :);
temp_2014_surface = temp_2014(1:10, :);
temp_2015_surface = temp_2015(1:10, :);
temp_2016_surface = temp_2016(1:10, :);
temp_2018_surface = temp_2018(1:10, :);
temp_2019_surface = temp_2019(1:10, :);

temp_2011_surface_winter = temp_2011(1:10, 357:472);
temp_2018_surface_winter = temp_2018(1:10, 420:431);

temp_2011_surface_winter(temp_2011_surface_winter == 0) = NaN;
temp_2018_surface_winter(temp_2018_surface_winter == 0) = NaN;

max_temp_2011 = max(temp_2011_surface, [], 'all');
max_temp_2012 = max(temp_2012_surface, [], 'all');
max_temp_2013 = max(temp_2013_surface, [], 'all');
max_temp_2014 = max(temp_2014_surface, [], 'all');
max_temp_2015 = max(temp_2015_surface, [], 'all');
max_temp_2016 = max(temp_2016_surface, [], 'all');
max_temp_2018 = max(temp_2018_surface, [], 'all');
max_temp_2019 = max(temp_2019_surface, [], 'all');

max_temp_2011_winter = max(temp_2011_surface_winter, [], 'all');
max_temp_2018_winter = max(temp_2018_surface_winter, [], 'all');

min_temp_2011 = min(temp_2011_surface, [], 'all');
min_temp_2012 = min(temp_2012_surface, [], 'all');
min_temp_2013 = min(temp_2013_surface, [], 'all');
min_temp_2014 = min(temp_2014_surface, [], 'all');
min_temp_2015 = min(temp_2015_surface, [], 'all');
min_temp_2016 = min(temp_2016_surface, [], 'all');
min_temp_2018 = min(temp_2018_surface, [], 'all');
min_temp_2019 = min(temp_2019_surface, [], 'all');


min_temp_2011_winter = min(temp_2011_surface_winter, [], 'all');
min_temp_2018_winter = min(temp_2018_surface_winter, [], 'all');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%getting data ready to plot TS plots coloured by day of year

%need to turn the variable matrices into one big matrix so that MATLAB can stop throwing a
%hissy fit 

%reshape each nxm variable matrices into a nx1 vector (note: to get the no. of
%rows, multiply the no.rows by no.columns in original matrix (or nxm)
temp_2011_reshape = reshape(temp_2011, [976000,1]);
temp_2012_reshape = reshape(temp_2012, [592000,1]);
temp_2013_reshape = reshape(temp_2013, [40000,1]);
temp_2014_reshape = reshape(temp_2014, [44000,1]);
temp_2015_reshape = reshape(temp_2015, [684000,1]);
temp_2016_reshape = reshape(temp_2016, [8000,1]);
temp_2018_reshape = reshape(temp_2018, [862000,1]);
temp_2019_reshape = reshape(temp_2019, [212000,1]);

salt_2011_reshape = reshape(salt_2011, [976000,1]);
salt_2012_reshape = reshape(salt_2012, [592000,1]);
salt_2013_reshape = reshape(salt_2013, [40000,1]);
salt_2014_reshape = reshape(salt_2014, [44000,1]);
salt_2015_reshape = reshape(salt_2015, [684000,1]);
salt_2016_reshape = reshape(salt_2016, [8000,1]);
salt_2018_reshape = reshape(salt_2018, [862000,1]);
salt_2019_reshape = reshape(salt_2019, [212000,1]);

pres_2011_reshape = reshape(pres_2011, [976000,1]);
pres_2012_reshape = reshape(pres_2012, [592000,1]);
pres_2013_reshape = reshape(pres_2013, [40000,1]);
pres_2014_reshape = reshape(pres_2014, [44000,1]);
pres_2015_reshape = reshape(pres_2015, [684000,1]);
pres_2016_reshape = reshape(pres_2016, [8000,1]);
pres_2018_reshape = reshape(pres_2018, [862000,1]);
pres_2019_reshape = reshape(pres_2019, [212000,1]);


time_2011_repmat_reshape = reshape(time_2011_repmat, [976000,1]);
time_2012_repmat_reshape = reshape(time_2012_repmat, [592000,1]);
time_2013_repmat_reshape = reshape(time_2013_repmat, [40000,1]);
time_2014_repmat_reshape = reshape(time_2014_repmat, [44000,1]);
time_2015_repmat_reshape = reshape(time_2015_repmat, [684000,1]);
time_2016_repmat_reshape = reshape(time_2016_repmat, [8000,1]);
time_2018_repmat_reshape = reshape(time_2018_repmat, [862000,1]);
time_2019_repmat_reshape = reshape(time_2019_repmat, [212000,1]);


%turn these vectors into one big matrix for each year by combining
%individual vectors
matrix_2011 = horzcat(temp_2011_reshape, salt_2011_reshape, pres_2011_reshape, time_2011_repmat_reshape);
matrix_2012 = horzcat(temp_2012_reshape, salt_2012_reshape, pres_2012_reshape, time_2012_repmat_reshape);
matrix_2013 = horzcat(temp_2013_reshape, salt_2013_reshape, pres_2013_reshape, time_2013_repmat_reshape);
matrix_2014 = horzcat(temp_2014_reshape, salt_2014_reshape, pres_2014_reshape, time_2014_repmat_reshape);
matrix_2015 = horzcat(temp_2015_reshape, salt_2015_reshape, pres_2015_reshape, time_2015_repmat_reshape);
matrix_2016 = horzcat(temp_2016_reshape, salt_2016_reshape, pres_2016_reshape, time_2016_repmat_reshape);
matrix_2018 = horzcat(temp_2018_reshape, salt_2018_reshape, pres_2018_reshape, time_2018_repmat_reshape);
matrix_2019 = horzcat(temp_2019_reshape, salt_2019_reshape, pres_2019_reshape, time_2019_repmat_reshape);



%turn matrix into table & give headings so can plot nicer 
table_2011 = array2table(matrix_2011);
table_2011.Properties.VariableNames(1:4) = {'Temperature','Salinity','Pressure','Time'};

table_2012 = array2table(matrix_2012);
table_2012.Properties.VariableNames(1:4) = {'Temperature','Salinity','Pressure','Time'};

table_2013 = array2table(matrix_2013);
table_2013.Properties.VariableNames(1:4) = {'Temperature','Salinity','Pressure','Time'};

table_2014 = array2table(matrix_2014);
table_2014.Properties.VariableNames(1:4) = {'Temperature','Salinity','Pressure','Time'};

table_2015 = array2table(matrix_2015);
table_2015.Properties.VariableNames(1:4) = {'Temperature','Salinity','Pressure','Time'};

table_2016 = array2table(matrix_2016);
table_2016.Properties.VariableNames(1:4) = {'Temperature','Salinity','Pressure','Time'};

table_2018 = array2table(matrix_2018);
table_2018.Properties.VariableNames(1:4) = {'Temperature','Salinity','Pressure','Time'};

table_2019 = array2table(matrix_2019);
table_2019.Properties.VariableNames(1:4) = {'Temperature','Salinity','Pressure','Time'};


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%TS scatter plots



%success!!!! single plot coloured by day of the year or pressure (depends
%on last variable set in scatter) 
s=scatter(table_2011,'Salinity','Temperature','filled','ColorVariable','Pressure');
s.SizeData = 50;
%set(gca,'CLim',[0 365]);
hcb = colorbar
%hcb.Title.String = "Day of the Year"
%colormap(hsv);
colormap(flipud(parula));
hcb.Title.String = "Depth"
xlim([33 36]);
grid on
title('All seal data locations', 'Color', 'k', 'FontWeight', 'bold')









subplot(2,2,1);
%plot the water column graph
s=scatter(table_2011,'Salinity','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2011', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([33 35]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,2);
%plot the water column graph
s=scatter(table_2012,'Salinity','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2012', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([33 35]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,3);
%plot the water column graph
s=scatter(table_2013,'Salinity','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2013', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([33 35]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,4);
%plot the water column graph
s=scatter(table_2014,'Salinity','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2014', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([33 35]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,1);
%plot the water column graph
s=scatter(table_2015,'Salinity','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2015', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([33 35]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,2);
%plot the water column graph
s=scatter(table_2016,'Salinity','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2016', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([33 35]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,3);
%plot the water column graph
s=scatter(table_2018,'Salinity','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2018', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([33 35]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,4);
%plot the water column graph
s=scatter(table_2019,'Salinity','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2019', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([33 35]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on




















%again but for temperature 

subplot(2,2,1);
%plot the water column graph
s=scatter(table_2011,'Temperature','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2011', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Temperature (Degrees C)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([-2 1]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,2);
%plot the water column graph
s=scatter(table_2012,'Temperature','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2012', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Temperature (Degrees C)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([-2 1]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,3);
%plot the water column graph
s=scatter(table_2013,'Temperature','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2013', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Temperature (Degrees C)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([-2 1]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,4);
%plot the water column graph
s=scatter(table_2014,'Temperature','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2014', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Temperature (Degrees C)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([-2 1]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,1);
%plot the water column graph
s=scatter(table_2015,'Temperature','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2015', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Temperature (Degrees C)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([-2 1]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,2);
%plot the water column graph
s=scatter(table_2016,'Temperature','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2016', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Temperature (Degrees C)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([-2 1]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,3);
%plot the water column graph
s=scatter(table_2018,'Temperature','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2018', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Temperature (Degrees C)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([-2 1]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on


subplot(2,2,4);
%plot the water column graph
s=scatter(table_2019,'Temperature','Pressure','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2019', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Temperature (Degrees C)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse');
xlim([-2 1]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on










subplot(2,2,1);
%plot the water column graph
s=scatter(table_2011,'Salinity','Temperature','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2011', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Temperature (Degrees C)');
xlim([33 35]);
ylim([-2,1]);
grid on


subplot(2,2,2);
%plot the water column graph
s=scatter(table_2012,'Salinity','Temperature','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2012', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Temperature (Degrees C)');
xlim([33 35]);
ylim([-2,1]);
grid on


subplot(2,2,3);
%plot the water column graph
s=scatter(table_2013,'Salinity','Temperature','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2013', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Temperature (Degrees C)');
xlim([33 35]);
ylim([-2,1]);
grid on


subplot(2,2,4);
%plot the water column graph
s=scatter(table_2014,'Salinity','Temperature','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2014', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Temperature (Degrees C)');
xlim([33 35]);
ylim([-2,1]);
grid on


subplot(2,2,1);
%plot the water column graph
s=scatter(table_2015,'Salinity','Temperature','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2015', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Temperature (Degrees C)');
xlim([33 35]);
ylim([-2,1]);
grid on


subplot(2,2,2);
%plot the water column graph
s=scatter(table_2016,'Salinity','Temperature','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2016', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Temperature (Degrees C)');
xlim([33 35]);
ylim([-2,1]);
grid on


subplot(2,2,3);
%plot the water column graph
s=scatter(table_2018,'Salinity','Temperature','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2018', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Temperature (Degrees C)');
xlim([33 35]);
ylim([-2,1]);
grid on


subplot(2,2,4);
%plot the water column graph
s=scatter(table_2019,'Salinity','Temperature','filled','ColorVariable','Time');
s.SizeData = 10;
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2019', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Temperature (Degrees C)');
xlim([33 35]);
ylim([-2,1]);
grid on



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%lat lon plots 

%nicer way to plot Lat & lon values, coloured by year
A = 40
geoscatter(lat_2011,lon_2011, A, 'filled', 'o', 'MarkerFaceColor', '#7E2F8E', 'DisplayName', '2011')
title('All seal data locations', 'Color', 'k', 'FontWeight', 'bold')
hold on 
%geoscatter(lat_cd,lon_cd, 300, 'magenta', '*')
geoscatter(lat_2012,lon_2012, A, 'filled', 'o', 'b', 'DisplayName', '2012')
geoscatter(lat_2013,lon_2013, A, 'filled', 'o', 'MarkerFaceColor','#4DBEEE', 'DisplayName', '2013')
geoscatter(lat_2014,lon_2014, A, 'filled', 'o', 'c', 'DisplayName', '2014')
geoscatter(lat_2015,lon_2015, A, 'filled', 'o', 'MarkerFaceColor','#77AC30', 'DisplayName', '2015')
geoscatter(lat_2016,lon_2016, A, 'filled', 'o', 'g', 'DisplayName', '2016')
geoscatter(lat_2018,lon_2018, A, 'filled', 'o', 'y', 'DisplayName', '2018')
geoscatter(lat_2019,lon_2019, A, 'filled', 'o', 'MarkerFaceColor','#EDB120', 'DisplayName', '2019')
%geoscatter(lat_cdp,lon_cdp, 300, 'r', 'filled', 's', 'Displayname', 'Cape Darnley Polynya')
hold off
lgd = legend;
lgd.FontSize = 14;
lgd.Title.String = 'Year';
lgd.Location = 'northeastoutside';






%nicer way to plot Lat & lon values, coloured by year
A = 40
geoscatter(lat_2011,lon_2011, A, 'o', 'b', 'DisplayName', 'seal locations')
title('All seal data locations', 'Color', 'k', 'FontWeight', 'bold')
hold on 
geoscatter(lat_2012,lon_2012, A, 'o', 'b')
geoscatter(lat_2013,lon_2013, A, 'o', 'b')
geoscatter(lat_2014,lon_2014, A, 'o', 'b')
geoscatter(lat_2015,lon_2015, A, 'o', 'b')
geoscatter(lat_2016,lon_2016, A, 'o', 'b')
geoscatter(lat_2018,lon_2018, A, 'o', 'b')
geoscatter(lat_2019,lon_2019, A, 'o', 'b', 'DisplayName', 'seal locations')
geoscatter(lat_cdp,lon_cdp, 300, 'r', 'filled', 's', 'Displayname', 'Cape Darnley Polynya')
hold off
lgd = legend;
lgd.FontSize = 10;
%lgd.Title.String = 'Year';
lgd.Location = 'northeastoutside';




%nicer way to plot Lat & lon values, coloured by day of year
A = 20
geoscatter(lat_2011,lon_2011, A, time_2011, 'filled')
%geolimits([-70 -66],[66 72]);
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('All seal data locations', 'Color', 'k', 'FontWeight', 'bold')
hold on 
%geoscatter(lat_cd,lon_cd, 300, 'magenta', '*')
geoscatter(lat_2012,lon_2012, A, time_2012, 'filled')
geoscatter(lat_2013,lon_2013, A, time_2013, 'filled')
geoscatter(lat_2014,lon_2014, A, time_2014, 'filled')
geoscatter(lat_2015,lon_2015, A, time_2015, 'filled')
geoscatter(lat_2016,lon_2016, A, time_2016, 'filled')
geoscatter(lat_2018,lon_2018, A, time_2018, 'filled')
geoscatter(lat_2019,lon_2019, A, time_2019, 'filled')
hold off





%now make location plots separately, coloured by day of year/season 
subplot(2,2,1);

A = 30
geoscatter(lat_2011,lon_2011, A, time_2011, 'filled')
geolimits([-68.3 -66],[66 71]);
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2011', 'Color', 'k', 'FontWeight', 'bold')


subplot(2,2,2);

A = 30
geoscatter(lat_2012,lon_2012, A, time_2012, 'filled')
geolimits([-68.3 -66],[66 71]);
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2012', 'Color', 'k', 'FontWeight', 'bold')


subplot(2,2,3);

A = 30
geoscatter(lat_2013,lon_2013, A, time_2013, 'filled')
geolimits([-68.3 -66],[66 71]);
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2013', 'Color', 'k', 'FontWeight', 'bold')


subplot(2,2,4);

A = 30
geoscatter(lat_2014,lon_2014, A, time_2014, 'filled')
geolimits([-68.3 -66],[66 71]);
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2014', 'Color', 'k', 'FontWeight', 'bold')


subplot(2,2,1);

A = 30
geoscatter(lat_2015,lon_2015, A, time_2015, 'filled')
geolimits([-68.3 -66],[66 71]);
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2015', 'Color', 'k', 'FontWeight', 'bold')



subplot(2,2,2);

A = 30
geoscatter(lat_2016,lon_2016, A, time_2016, 'filled')
geolimits([-68.3 -66],[66 71]);
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2016', 'Color', 'k', 'FontWeight', 'bold')



subplot(2,2,3);

A = 30
geoscatter(lat_2018,lon_2018, A, time_2018, 'filled')
geolimits([-68.3 -66],[66 71]);
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2018', 'Color', 'k', 'FontWeight', 'bold')


subplot(2,2,4);

A = 30
geoscatter(lat_2019,lon_2019, A, time_2019, 'filled')
geolimits([-68.3 -66],[66 71]);
set(gca,'CLim',[0 365]);
hcb = colorbar
hcb.Title.String = "Day of the Year"
colormap(custom_map);
title('2019', 'Color', 'k', 'FontWeight', 'bold')











%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%annual mean graphs



%find the average for the whole year 
salt_2005_mean = salt_2005;
salt_2005_mean(salt_2005_mean == 0) = NaN;
salt_2005_mean = mean(salt_2005_mean,2,'omitnan');

salt_2007_mean = salt_2007;
salt_2007_mean(salt_2007_mean == 0) = NaN;
salt_2007_mean = mean(salt_2007_mean,2,'omitnan');

salt_2011_mean = salt_2011;
salt_2011_mean(salt_2011_mean == 0) = NaN;
salt_2011_mean = mean(salt_2011_mean,2,'omitnan');

salt_2012_mean = salt_2012;
salt_2012_mean(salt_2012_mean == 0) = NaN;
salt_2012_mean = mean(salt_2012_mean,2,'omitnan');

salt_2013_mean = salt_2013;
salt_2013_mean(salt_2013_mean == 0) = NaN;
salt_2013_mean = mean(salt_2013_mean,2,'omitnan');

salt_2014_mean = salt_2014;
salt_2014_mean(salt_2014_mean == 0) = NaN;
salt_2014_mean = mean(salt_2014_mean,2,'omitnan');

salt_2015_mean = salt_2015;
salt_2015_mean(salt_2015_mean == 0) = NaN;
salt_2015_mean = mean(salt_2015_mean,2,'omitnan');

salt_2016_mean = salt_2016;
salt_2016_mean(salt_2016_mean == 0) = NaN;
salt_2016_mean = mean(salt_2016_mean,2,'omitnan');

salt_2018_mean = salt_2018;
salt_2018_mean(salt_2018_mean == 0) = NaN;
salt_2018_mean = mean(salt_2018_mean,2,'omitnan');

salt_2019_mean = salt_2019;
salt_2019_mean(salt_2019_mean == 0) = NaN;
salt_2019_mean = mean(salt_2019_mean,2,'omitnan');




temp_2005_mean = temp_2005;
temp_2005_mean(temp_2005_mean == 0) = NaN;
temp_2005_mean = mean(temp_2005_mean,2,'omitnan');

temp_2007_mean = temp_2007;
temp_2007_mean(temp_2007_mean == 0) = NaN;
temp_2007_mean = mean(temp_2007_mean,2,'omitnan');

temp_2011_mean = temp_2011;
temp_2011_mean(temp_2011_mean == 0) = NaN;
temp_2011_mean = mean(temp_2011_mean,2,'omitnan');

temp_2012_mean = temp_2012;
temp_2012_mean(temp_2012_mean == 0) = NaN;
temp_2012_mean = mean(temp_2012_mean,2,'omitnan');

temp_2013_mean = temp_2013;
temp_2013_mean(temp_2013_mean == 0) = NaN;
temp_2013_mean = mean(temp_2013_mean,2,'omitnan');

temp_2014_mean = temp_2014;
temp_2014_mean(temp_2014_mean == 0) = NaN;
temp_2014_mean = mean(temp_2014_mean,2,'omitnan');

temp_2015_mean = temp_2015;
temp_2015_mean(temp_2015_mean == 0) = NaN;
temp_2015_mean = mean(temp_2015_mean,2,'omitnan');

temp_2016_mean = temp_2016;
temp_2016_mean(temp_2016_mean == 0) = NaN;
temp_2016_mean = mean(temp_2016_mean,2,'omitnan');

temp_2018_mean = temp_2018;
temp_2018_mean(temp_2018_mean == 0) = NaN;
temp_2018_mean = mean(temp_2018_mean,2,'omitnan');

temp_2019_mean = temp_2019;
temp_2019_mean(temp_2019_mean == 0) = NaN;
temp_2019_mean = mean(temp_2019_mean,2,'omitnan');





pres_2005_mean = pres_2005;
pres_2005_mean(pres_2005_mean == 0) = NaN;
pres_2005_mean = mean(pres_2005_mean,2,'omitnan');

pres_2007_mean = pres_2007;
pres_2007_mean(pres_2007_mean == 0) = NaN;
pres_2007_mean = mean(pres_2007_mean,2,'omitnan');

pres_2011_mean = pres_2011;
pres_2011_mean(pres_2011_mean == 0) = NaN;
pres_2011_mean = mean(pres_2011_mean,2,'omitnan');

pres_2012_mean = pres_2012;
pres_2012_mean(pres_2012_mean == 0) = NaN;
pres_2012_mean = mean(pres_2012_mean,2,'omitnan');

pres_2013_mean = pres_2013;
pres_2013_mean(pres_2013_mean == 0) = NaN;
pres_2013_mean = mean(pres_2013_mean,2,'omitnan');

pres_2014_mean = pres_2014;
pres_2014_mean(pres_2014_mean == 0) = NaN;
pres_2014_mean = mean(pres_2014_mean,2,'omitnan');

pres_2015_mean = pres_2015;
pres_2015_mean(pres_2015_mean == 0) = NaN;
pres_2015_mean = mean(pres_2015_mean,2,'omitnan');

pres_2016_mean = pres_2016;
pres_2016_mean(pres_2016_mean == 0) = NaN;
pres_2016_mean = mean(pres_2016_mean,2,'omitnan');

pres_2018_mean = pres_2018;
pres_2018_mean(pres_2018_mean == 0) = NaN;
pres_2018_mean = mean(pres_2018_mean,2,'omitnan');

pres_2019_mean = pres_2019;
pres_2019_mean(pres_2019_mean == 0) = NaN;
pres_2019_mean = mean(pres_2019_mean,2,'omitnan');




%create a vector that just says the year, and merge this with the mean
%values for each year 
% I feel like this could be a for loop
year_2011 = [2011; 2011];
year_2011 = repmat(year_2011,1000,1);
merge_2011 = horzcat(temp_2011_mean,salt_2011_mean, pres_2011_mean, year_2011);

year_2012 = [2012; 2012];
year_2012 = repmat(year_2012,1000,1);
merge_2012 = horzcat(temp_2012_mean,salt_2012_mean, pres_2012_mean, year_2012);

year_2013 = [2013; 2013];
year_2013 = repmat(year_2013,1000,1);
merge_2013 = horzcat(temp_2013_mean,salt_2013_mean, pres_2013_mean, year_2013);

year_2014 = [2014; 2014];
year_2014 = repmat(year_2014,1000,1);
merge_2014 = horzcat(temp_2014_mean,salt_2014_mean, pres_2014_mean, year_2014);

year_2015 = [2015; 2015];
year_2015 = repmat(year_2015,1000,1);
merge_2015 = horzcat(temp_2015_mean,salt_2015_mean, pres_2015_mean, year_2015);

year_2016 = [2016; 2016];
year_2016 = repmat(year_2016,1000,1);
merge_2016 = horzcat(temp_2016_mean,salt_2016_mean, pres_2016_mean, year_2016);

year_2018 = [2018; 2018];
year_2018 = repmat(year_2018,1000,1);
merge_2018 = horzcat(temp_2018_mean,salt_2018_mean, pres_2018_mean, year_2018);

year_2019 = [2019; 2019];
year_2019 = repmat(year_2019,1000,1);
merge_2019 = horzcat(temp_2019_mean,salt_2019_mean, pres_2019_mean, year_2019);



merge_all_years = vertcat(merge_2011, merge_2012, merge_2013, merge_2014, merge_2015, merge_2016, merge_2018, merge_2019);
%turn matrix into table so can plot nicer 
T = array2table(merge_all_years);
T.Properties.VariableNames(1:4) = {'Temperature','Salinity','Pressure','Year'};







%annual mean plots
subplot(1,2,1);
s = scatter(T, 'Salinity', 'Pressure', 'filled', 'ColorVariable', 'Year')
s.SizeData = 20;
title('Mean Annual Salinity Profile', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
xlim([33 35]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on
hcb = colorbar
hcb.Title.String = "Year"


subplot(1,2,2);
s = scatter(T, 'Temperature', 'Pressure', 'filled', 'ColorVariable', 'Year')
s.SizeData = 20;
title('Mean Annual Temperature Profile', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Temperature (Degrees C)');
ylabel('Pressure (dbar)');
set(gca,'Ydir','reverse')
%xlim([33 35]);
ylim([0,1500]);
yticks([0,200,400,600,800,1000,1200,1400,1600])
grid on
hcb = colorbar
hcb.Title.String = "Year"

subplot(1,3,3);
s = scatter(T, 'Salinity', 'Temperature', 'filled', 'ColorVariable', 'Year')
s.SizeData = 20;
title('Mean Annual TS', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Temperature (Degrees C)');
%ylim([-2.3 0])
%xlim([34.3 34.9]);
grid on
hcb = colorbar
hcb.Title.String = "Year"




%success!!!! single plot coloured by day of the year or pressure (depends
%on last variable set in scatter) 
s=scatter(T,'Salinity','Temperature','filled','ColorVariable','Pressure');
s.SizeData = 20;
title('Mean Annual TS', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Temperature (Degrees C)');
hcb = colorbar
ylim([-2.3 0])
xlim([34.3 34.9]);
colormap(flipud(parula));
hcb.Title.String = "Depth"
grid on




s = scatter(salt_2018_mean, temp_2018_mean, 'filled')
s.SizeData = 20;
%title('Mean Annual TS', 'Color', 'k', 'FontWeight', 'bold');
xlabel('Salinity (psu)');
ylabel('Temperature (Degrees C)');
ylim([-2.3 0])
xlim([34.3 34.9]);
grid on
hcb = colorbar
hcb.Title.String = "Year"