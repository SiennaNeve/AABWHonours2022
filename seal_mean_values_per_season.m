%load the data 
darnley = load('Darnley_for_Sienna.mat');
salt = darnley.darnley.sal;
temp = darnley.darnley.temp;
pres = darnley.darnley.pres;
time = darnley.darnley.time;
lat = darnley.darnley.lat;
lon = darnley.darnley.lon;



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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SALINITY


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


%summer 
salt_2011_summer = salt_2018(:, 1:29);
salt_2011_summer(salt_2011_summer == 0) = NaN;
salt_2012_summer = salt_2012(:, 1:27);
salt_2012_summer(salt_2012_summer == 0) = NaN;
salt_2014_summer = salt_2014(:, 1:22);
salt_2014_summer(salt_2014_summer == 0) = NaN;
salt_2015_summer = salt_2015(:, 1:176);
salt_2015_summer(salt_2015_summer == 0) = NaN;
salt_2018_summer = salt_2018(:, 1:82);
salt_2018_summer(salt_2018_summer == 0) = NaN;
salt_2019_summer = salt_2019(:, 1:7);
salt_2019_summer(salt_2019_summer == 0) = NaN;

%autumn 
salt_2011_autumn = salt_2011(:, 30:356);
salt_2011_autumn(salt_2011_autumn == 0) = NaN;
salt_2012_autumn = salt_2012(:, 28:287);
salt_2012_autumn(salt_2012_autumn == 0) = NaN;
salt_2013_autumn = salt_2013(:, 1:12);
salt_2013_autumn(salt_2013_autumn == 0) = NaN;
salt_2015_autumn = salt_2015(:, 177:342);
salt_2015_autumn(salt_2015_autumn == 0) = NaN;
salt_2016_autumn = salt_2016(:, 1:4);
salt_2016_autumn(salt_2016_autumn == 0) = NaN;
salt_2018_autumn = salt_2018(:, 83:419);
salt_2018_autumn(salt_2018_autumn == 0) = NaN;
salt_2019_autumn = salt_2019(:, 8:106);
salt_2019_autumn(salt_2019_autumn == 0) = NaN;

%winter 
salt_2011_winter = salt_2011(:, 357:472);
salt_2011_winter(salt_2011_winter == 0) = NaN;
salt_2018_winter = salt_2018(:, 420:431);
salt_2018_winter(salt_2018_winter == 0) = NaN;

%spring
salt_2011_spring = salt_2011(:, 473:488);
salt_2011_spring(salt_2011_spring == 0) = NaN;
salt_2012_spring = salt_2012(:, 288:296);
salt_2012_spring(salt_2012_spring == 0) = NaN;
salt_2013_spring = salt_2013(:, 13:20);
salt_2013_spring(salt_2013_spring == 0) = NaN;



%finding mean values 

%summer
mean_salt_2011_summer = mean(salt_2011_summer, 'all', 'omitnan');
mean_salt_2012_summer = mean(salt_2012_summer, 'all', 'omitnan');
mean_salt_2014_summer = mean(salt_2014_summer, 'all', 'omitnan');
mean_salt_2015_summer = mean(salt_2015_summer, 'all', 'omitnan');
mean_salt_2018_summer = mean(salt_2018_summer, 'all', 'omitnan');
mean_salt_2019_summer = mean(salt_2019_summer, 'all', 'omitnan');

%autumn
mean_salt_2011_autumn = mean(salt_2011_autumn, 'all', 'omitnan');
mean_salt_2012_autumn = mean(salt_2012_autumn, 'all', 'omitnan');
mean_salt_2013_autumn = mean(salt_2013_autumn, 'all', 'omitnan');
mean_salt_2015_autumn = mean(salt_2015_autumn, 'all', 'omitnan');
mean_salt_2016_autumn = mean(salt_2016_autumn, 'all', 'omitnan');
mean_salt_2018_autumn = mean(salt_2018_autumn, 'all', 'omitnan');
mean_salt_2019_autumn = mean(salt_2019_autumn, 'all', 'omitnan');


%winter
mean_salt_2011_winter = mean(salt_2011_winter, 'all', 'omitnan');
mean_salt_2018_winter = mean(salt_2018_winter, 'all', 'omitnan');


%spring
mean_salt_2011_spring = mean(salt_2011_spring, 'all', 'omitnan');
mean_salt_2012_spring = mean(salt_2012_spring, 'all', 'omitnan');
mean_salt_2013_spring = mean(salt_2013_spring, 'all', 'omitnan');





%calcualte quantiles for box plot 

%summer
Q_salt_2011_summer = quantile(salt_2011_summer, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2012_summer = quantile(salt_2012_summer, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2014_summer = quantile(salt_2014_summer, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2015_summer = quantile(salt_2015_summer, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2018_summer = quantile(salt_2018_summer, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2019_summer = quantile(salt_2019_summer, [0 0.25 0.5 0.75 1], 'all');

%autumn
Q_salt_2011_autumn = quantile(salt_2011_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2012_autumn = quantile(salt_2012_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2013_autumn = quantile(salt_2013_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2015_autumn = quantile(salt_2015_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2016_autumn = quantile(salt_2016_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2018_autumn = quantile(salt_2018_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2019_autumn = quantile(salt_2019_autumn, [0 0.25 0.5 0.75 1], 'all');

%Winter
Q_salt_2011_winter = quantile(salt_2011_winter, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2018_winter = quantile(salt_2018_winter, [0 0.25 0.5 0.75 1], 'all');

%spring
Q_salt_2011_spring = quantile(salt_2011_spring, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2012_spring = quantile(salt_2012_spring, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2013_spring = quantile(salt_2013_spring, [0 0.25 0.5 0.75 1], 'all');



%can make boxplot in matlab, but can't put different years next to each
%other
boxplot(salt_2011_spring(:))
boxplot(temp_2011_spring(:))
boxplot(salt_2013_spring(:))
ylabel('Salinity (psu)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% TEMPERATURE 

%create new variables for each year: (data is from 2004-2019, so the 8th year is
%2011)
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


%summer 
temp_2011_summer = temp_2018(:, 1:29);
temp_2011_summer(temp_2011_summer == 0) = NaN;
temp_2012_summer = temp_2012(:, 1:27);
temp_2012_summer(temp_2012_summer == 0) = NaN;
temp_2014_summer = temp_2014(:, 1:22);
temp_2014_summer(temp_2014_summer == 0) = NaN;
temp_2015_summer = temp_2015(:, 1:176);
temp_2015_summer(temp_2015_summer == 0) = NaN;
temp_2018_summer = temp_2018(:, 1:82);
temp_2018_summer(temp_2018_summer == 0) = NaN;
temp_2019_summer = temp_2019(:, 1:7);
temp_2019_summer(temp_2019_summer == 0) = NaN;

%autumn 
temp_2011_autumn = temp_2011(:, 30:356);
temp_2011_autumn(temp_2011_autumn == 0) = NaN;
temp_2012_autumn = temp_2012(:, 28:287);
temp_2012_autumn(temp_2012_autumn == 0) = NaN;
temp_2013_autumn = temp_2013(:, 1:12);
temp_2013_autumn(temp_2013_autumn == 0) = NaN;
temp_2015_autumn = temp_2015(:, 177:342);
temp_2015_autumn(temp_2015_autumn == 0) = NaN;
temp_2016_autumn = temp_2016(:, 1:4);
temp_2016_autumn(temp_2016_autumn == 0) = NaN;
temp_2018_autumn = temp_2018(:, 83:419);
temp_2018_autumn(temp_2018_autumn == 0) = NaN;
temp_2019_autumn = temp_2019(:, 8:106);
temp_2019_autumn(temp_2019_autumn == 0) = NaN;

%winter 
temp_2011_winter = temp_2011(:, 357:472);
temp_2011_winter(temp_2011_winter == 0) = NaN;
temp_2018_winter = temp_2018(:, 420:431);
temp_2018_winter(temp_2018_winter == 0) = NaN;

%spring
temp_2011_spring = temp_2011(:, 473:488);
temp_2011_spring(temp_2011_spring == 0) = NaN;
temp_2012_spring = temp_2012(:, 288:296);
temp_2012_spring(temp_2012_spring == 0) = NaN;
temp_2013_spring = temp_2013(:, 13:20);
temp_2013_spring(temp_2013_spring == 0) = NaN;


%finding mean values 

%summer
mean_temp_2011_summer = mean(temp_2011_summer, 'all', 'omitnan');
mean_temp_2012_summer = mean(temp_2012_summer, 'all', 'omitnan');
mean_temp_2014_summer = mean(temp_2014_summer, 'all', 'omitnan');
mean_temp_2015_summer = mean(temp_2015_summer, 'all', 'omitnan');
mean_temp_2018_summer = mean(temp_2018_summer, 'all', 'omitnan');
mean_temp_2019_summer = mean(temp_2019_summer, 'all', 'omitnan');

%autumn
mean_temp_2011_autumn = mean(temp_2011_autumn, 'all', 'omitnan');
mean_temp_2012_autumn = mean(temp_2012_autumn, 'all', 'omitnan');
mean_temp_2013_autumn = mean(temp_2013_autumn, 'all', 'omitnan');
mean_temp_2015_autumn = mean(temp_2015_autumn, 'all', 'omitnan');
mean_temp_2016_autumn = mean(temp_2016_autumn, 'all', 'omitnan');
mean_temp_2018_autumn = mean(temp_2018_autumn, 'all', 'omitnan');
mean_temp_2019_autumn = mean(temp_2019_autumn, 'all', 'omitnan');


%winter
mean_temp_2011_winter = mean(temp_2011_winter, 'all', 'omitnan');
mean_temp_2018_winter = mean(temp_2018_winter, 'all', 'omitnan');


%spring
mean_temp_2011_spring = mean(temp_2011_spring, 'all', 'omitnan');
mean_temp_2012_spring = mean(temp_2012_spring, 'all', 'omitnan');
mean_temp_2013_spring = mean(temp_2013_spring, 'all', 'omitnan');




%%calcualte quantiles for box plot 

%summer
Q_temp_2011_summer = quantile(temp_2011_summer, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2012_summer = quantile(temp_2012_summer, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2014_summer = quantile(temp_2014_summer, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2015_summer = quantile(temp_2015_summer, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2018_summer = quantile(temp_2018_summer, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2019_summer = quantile(temp_2019_summer, [0 0.25 0.5 0.75 1], 'all');

%autumn
Q_temp_2011_autumn = quantile(temp_2011_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2012_autumn = quantile(temp_2012_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2013_autumn = quantile(temp_2013_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2015_autumn = quantile(temp_2015_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2016_autumn = quantile(temp_2016_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2018_autumn = quantile(temp_2018_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2019_autumn = quantile(temp_2019_autumn, [0 0.25 0.5 0.75 1], 'all');

%Winter
Q_temp_2011_winter = quantile(temp_2011_winter, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2018_winter = quantile(temp_2018_winter, [0 0.25 0.5 0.75 1], 'all');

%spring
Q_temp_2011_spring = quantile(temp_2011_spring, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2012_spring = quantile(temp_2012_spring, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2013_spring = quantile(temp_2013_spring, [0 0.25 0.5 0.75 1], 'all');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SALINITY SURFACE (top 10m)


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


%summer 
salt_2011_summer = salt_2018(1:10, 1:29);
salt_2011_summer(salt_2011_summer == 0) = NaN;
salt_2012_summer = salt_2012(1:10, 1:27);
salt_2012_summer(salt_2012_summer == 0) = NaN;
salt_2014_summer = salt_2014(1:10, 1:22);
salt_2014_summer(salt_2014_summer == 0) = NaN;
salt_2015_summer = salt_2015(1:10, 1:176);
salt_2015_summer(salt_2015_summer == 0) = NaN;
salt_2018_summer = salt_2018(1:10, 1:82);
salt_2018_summer(salt_2018_summer == 0) = NaN;
salt_2019_summer = salt_2019(1:10, 1:7);
salt_2019_summer(salt_2019_summer == 0) = NaN;

%autumn 
salt_2011_autumn = salt_2011(1:10, 30:356);
salt_2011_autumn(salt_2011_autumn == 0) = NaN;
salt_2012_autumn = salt_2012(1:10, 28:287);
salt_2012_autumn(salt_2012_autumn == 0) = NaN;
salt_2013_autumn = salt_2013(1:10, 1:12);
salt_2013_autumn(salt_2013_autumn == 0) = NaN;
salt_2015_autumn = salt_2015(1:10, 177:342);
salt_2015_autumn(salt_2015_autumn == 0) = NaN;
salt_2016_autumn = salt_2016(1:10, 1:4);
salt_2016_autumn(salt_2016_autumn == 0) = NaN;
salt_2018_autumn = salt_2018(1:10, 83:419);
salt_2018_autumn(salt_2018_autumn == 0) = NaN;
salt_2019_autumn = salt_2019(1:10, 8:106);
salt_2019_autumn(salt_2019_autumn == 0) = NaN;

%winter 
salt_2011_winter = salt_2011(1:10, 357:472);
salt_2011_winter(salt_2011_winter == 0) = NaN;
salt_2018_winter = salt_2018(1:10, 420:431);
salt_2018_winter(salt_2018_winter == 0) = NaN;

%spring
salt_2011_spring = salt_2011(1:10, 473:488);
salt_2011_spring(salt_2011_spring == 0) = NaN;
salt_2012_spring = salt_2012(1:10, 288:296);
salt_2012_spring(salt_2012_spring == 0) = NaN;
salt_2013_spring = salt_2013(1:10, 13:20);
salt_2013_spring(salt_2013_spring == 0) = NaN;


%finding mean values 

%summer
mean_salt_2011_summer = mean(salt_2011_summer, 'all', 'omitnan');
mean_salt_2012_summer = mean(salt_2012_summer, 'all', 'omitnan');
mean_salt_2014_summer = mean(salt_2014_summer, 'all', 'omitnan');
mean_salt_2015_summer = mean(salt_2015_summer, 'all', 'omitnan');
mean_salt_2018_summer = mean(salt_2018_summer, 'all', 'omitnan');
mean_salt_2019_summer = mean(salt_2019_summer, 'all', 'omitnan');

%autumn
mean_salt_2011_autumn = mean(salt_2011_autumn, 'all', 'omitnan');
mean_salt_2012_autumn = mean(salt_2012_autumn, 'all', 'omitnan');
mean_salt_2013_autumn = mean(salt_2013_autumn, 'all', 'omitnan');
mean_salt_2015_autumn = mean(salt_2015_autumn, 'all', 'omitnan');
mean_salt_2016_autumn = mean(salt_2016_autumn, 'all', 'omitnan');
mean_salt_2018_autumn = mean(salt_2018_autumn, 'all', 'omitnan');
mean_salt_2019_autumn = mean(salt_2019_autumn, 'all', 'omitnan');


%winter
mean_salt_2011_winter = mean(salt_2011_winter, 'all', 'omitnan');
mean_salt_2018_winter = mean(salt_2018_winter, 'all', 'omitnan');


%spring
mean_salt_2011_spring = mean(salt_2011_spring, 'all', 'omitnan');
mean_salt_2012_spring = mean(salt_2012_spring, 'all', 'omitnan');
mean_salt_2013_spring = mean(salt_2013_spring, 'all', 'omitnan');





%calcualte quantiles for box plot 

%summer
Q_salt_2011_summer = quantile(salt_2011_summer, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2012_summer = quantile(salt_2012_summer, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2014_summer = quantile(salt_2014_summer, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2015_summer = quantile(salt_2015_summer, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2018_summer = quantile(salt_2018_summer, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2019_summer = quantile(salt_2019_summer, [0 0.25 0.5 0.75 1], 'all');

%autumn
Q_salt_2011_autumn = quantile(salt_2011_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2012_autumn = quantile(salt_2012_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2013_autumn = quantile(salt_2013_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2015_autumn = quantile(salt_2015_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2016_autumn = quantile(salt_2016_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2018_autumn = quantile(salt_2018_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2019_autumn = quantile(salt_2019_autumn, [0 0.25 0.5 0.75 1], 'all');

%Winter
Q_salt_2011_winter = quantile(salt_2011_winter, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2018_winter = quantile(salt_2018_winter, [0 0.25 0.5 0.75 1], 'all');

%spring
Q_salt_2011_spring = quantile(salt_2011_spring, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2012_spring = quantile(salt_2012_spring, [0 0.25 0.5 0.75 1], 'all');
Q_salt_2013_spring = quantile(salt_2013_spring, [0 0.25 0.5 0.75 1], 'all');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% TEMPERATURE SURFACE (top 10m) 

%create new variables for each year: (data is from 2004-2019, so the 8th year is
%2011)
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


%summer 
temp_2011_summer = temp_2018(1:10, 1:29);
temp_2011_summer(temp_2011_summer == 0) = NaN;
temp_2012_summer = temp_2012(1:10, 1:27);
temp_2012_summer(temp_2012_summer == 0) = NaN;
temp_2014_summer = temp_2014(1:10, 1:22);
temp_2014_summer(temp_2014_summer == 0) = NaN;
temp_2015_summer = temp_2015(1:10, 1:176);
temp_2015_summer(temp_2015_summer == 0) = NaN;
temp_2018_summer = temp_2018(1:10, 1:82);
temp_2018_summer(temp_2018_summer == 0) = NaN;
temp_2019_summer = temp_2019(1:10, 1:7);
temp_2019_summer(temp_2019_summer == 0) = NaN;

%autumn 
temp_2011_autumn = temp_2011(1:10, 30:356);
temp_2011_autumn(temp_2011_autumn == 0) = NaN;
temp_2012_autumn = temp_2012(1:10, 28:287);
temp_2012_autumn(temp_2012_autumn == 0) = NaN;
temp_2013_autumn = temp_2013(1:10, 1:12);
temp_2013_autumn(temp_2013_autumn == 0) = NaN;
temp_2015_autumn = temp_2015(1:10, 177:342);
temp_2015_autumn(temp_2015_autumn == 0) = NaN;
temp_2016_autumn = temp_2016(1:10, 1:4);
temp_2016_autumn(temp_2016_autumn == 0) = NaN;
temp_2018_autumn = temp_2018(1:10, 83:419);
temp_2018_autumn(temp_2018_autumn == 0) = NaN;
temp_2019_autumn = temp_2019(1:10, 8:106);
temp_2019_autumn(temp_2019_autumn == 0) = NaN;

%winter 
temp_2011_winter = temp_2011(1:10, 357:472);
temp_2011_winter(temp_2011_winter == 0) = NaN;
temp_2018_winter = temp_2018(1:10, 420:431);
temp_2018_winter(temp_2018_winter == 0) = NaN;

%spring
temp_2011_spring = temp_2011(1:10, 473:488);
temp_2011_spring(temp_2011_spring == 0) = NaN;
temp_2012_spring = temp_2012(1:10, 288:296);
temp_2012_spring(temp_2012_spring == 0) = NaN;
temp_2013_spring = temp_2013(1:10, 13:20);
temp_2013_spring(temp_2013_spring == 0) = NaN;


%finding mean values 

%summer
mean_temp_2011_summer = mean(temp_2011_summer, 'all', 'omitnan');
mean_temp_2012_summer = mean(temp_2012_summer, 'all', 'omitnan');
mean_temp_2014_summer = mean(temp_2014_summer, 'all', 'omitnan');
mean_temp_2015_summer = mean(temp_2015_summer, 'all', 'omitnan');
mean_temp_2018_summer = mean(temp_2018_summer, 'all', 'omitnan');
mean_temp_2019_summer = mean(temp_2019_summer, 'all', 'omitnan');

%autumn
mean_temp_2011_autumn = mean(temp_2011_autumn, 'all', 'omitnan');
mean_temp_2012_autumn = mean(temp_2012_autumn, 'all', 'omitnan');
mean_temp_2013_autumn = mean(temp_2013_autumn, 'all', 'omitnan');
mean_temp_2015_autumn = mean(temp_2015_autumn, 'all', 'omitnan');
mean_temp_2016_autumn = mean(temp_2016_autumn, 'all', 'omitnan');
mean_temp_2018_autumn = mean(temp_2018_autumn, 'all', 'omitnan');
mean_temp_2019_autumn = mean(temp_2019_autumn, 'all', 'omitnan');


%winter
mean_temp_2011_winter = mean(temp_2011_winter, 'all', 'omitnan');
mean_temp_2018_winter = mean(temp_2018_winter, 'all', 'omitnan');


%spring
mean_temp_2011_spring = mean(temp_2011_spring, 'all', 'omitnan');
mean_temp_2012_spring = mean(temp_2012_spring, 'all', 'omitnan');
mean_temp_2013_spring = mean(temp_2013_spring, 'all', 'omitnan');




%%calcualte quantiles for box plot 

%summer
Q_temp_2011_summer = quantile(temp_2011_summer, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2012_summer = quantile(temp_2012_summer, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2014_summer = quantile(temp_2014_summer, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2015_summer = quantile(temp_2015_summer, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2018_summer = quantile(temp_2018_summer, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2019_summer = quantile(temp_2019_summer, [0 0.25 0.5 0.75 1], 'all');

%autumn
Q_temp_2011_autumn = quantile(temp_2011_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2012_autumn = quantile(temp_2012_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2013_autumn = quantile(temp_2013_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2015_autumn = quantile(temp_2015_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2016_autumn = quantile(temp_2016_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2018_autumn = quantile(temp_2018_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2019_autumn = quantile(temp_2019_autumn, [0 0.25 0.5 0.75 1], 'all');

%Winter
Q_temp_2011_winter = quantile(temp_2011_winter, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2018_winter = quantile(temp_2018_winter, [0 0.25 0.5 0.75 1], 'all');

%spring
Q_temp_2011_spring = quantile(temp_2011_spring, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2012_spring = quantile(temp_2012_spring, [0 0.25 0.5 0.75 1], 'all');
Q_temp_2013_spring = quantile(temp_2013_spring, [0 0.25 0.5 0.75 1], 'all');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%annual values


%combine seasonal data 
salt_summer = [salt_2011_summer, salt_2012_summer, salt_2014_summer, salt_2015_summer, salt_2018_summer, salt_2019_summer];
salt_autumn = [salt_2011_autumn, salt_2012_autumn, salt_2013_autumn, salt_2015_autumn, salt_2016_autumn, salt_2018_autumn, salt_2019_autumn];
salt_winter = [salt_2011_winter, salt_2018_winter];
salt_spring = [salt_2011_spring, salt_2012_spring, salt_2013_spring];

temp_summer = [temp_2011_summer, temp_2012_summer, temp_2014_summer, temp_2015_summer, temp_2018_summer, temp_2019_summer];
temp_autumn = [temp_2011_autumn, temp_2012_autumn, temp_2013_autumn, temp_2015_autumn, temp_2016_autumn, temp_2018_autumn, temp_2019_autumn];
temp_winter = [temp_2011_winter, temp_2018_winter];
temp_spring = [temp_2011_spring, temp_2012_spring, temp_2013_spring];

% calculate mean 
mean_salt_summer = mean(salt_summer, 'all', 'omitnan');
mean_salt_autumn = mean(salt_autumn, 'all', 'omitnan');
mean_salt_winter = mean(salt_winter, 'all', 'omitnan');
mean_salt_spring = mean(salt_spring, 'all', 'omitnan');


mean_temp_summer = mean(temp_summer, 'all', 'omitnan');
mean_temp_autumn = mean(temp_autumn, 'all', 'omitnan');
mean_temp_winter = mean(temp_winter, 'all', 'omitnan');
mean_temp_spring = mean(temp_spring, 'all', 'omitnan');

boxplot(temp_spring(:))

%calcualte quantiles for box plot 

Q_salt_summer = quantile(salt_summer, [0 0.25 0.5 0.75 1], 'all');
Q_salt_autumn = quantile(salt_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_salt_winter = quantile(salt_winter, [0 0.25 0.5 0.75 1], 'all');
Q_salt_spring = quantile(salt_spring, [0 0.25 0.5 0.75 1], 'all');


Q_temp_summer = quantile(temp_summer, [0 0.25 0.5 0.75 1], 'all');
Q_temp_autumn = quantile(temp_autumn, [0 0.25 0.5 0.75 1], 'all');
Q_temp_winter = quantile(temp_winter, [0 0.25 0.5 0.75 1], 'all');
Q_temp_spring = quantile(temp_spring, [0 0.25 0.5 0.75 1], 'all');
