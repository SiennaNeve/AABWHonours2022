%loading in the values and variables 


%Annual_CTRL = 'ocean_his_annual_CTRL.nc'
%Annual_SALT_HIGH_TEMP_HIGH = 'ocean_his_annual_high_temp_high_salt.nc'
%Annual_SALT_HIGH_TEMP_LOW = 'ocean_his_annual_low_temp_high_salt.nc'
%Annual_SALT_LOW_TEMP_HIGH = 'ocean_his_annual_high_temp_low_salt.nc'
%Annual_SALT_LOW_TEMP_LOW ='ocean_his_annual_low_temp_low_salt.nc'

%Winter_CTRL = 'ocean_his_winter_CTRL.nc'
%Winter_SALT_HIGH_TEMP_HIGH = 'ocean_his_winter_high_temp_high_salt.nc'
%Winter_SALT_HIGH_TEMP_LOW = 'ocean_his_winter_low_temp_high_salt.nc'
%Winter_SALT_LOW_TEMP_HIGH = 'ocean_his_winter_high_temp_low_salt.nc'
%Winter_SALT_LOW_TEMP_LOW = 'ocean_his_winter_low_temp_low_salt.nc'

Annual_CTRL = 'ocean_his_NEW_CTRL.nc'
Annual_SALT_HIGH_TEMP_HIGH = 'ocean_his_TEMP_-1.5.nc'
Annual_SALT_HIGH_TEMP_LOW = 'ocean_his_TEMP_-1.6.nc'
Annual_SALT_LOW_TEMP_HIGH = 'ocean_his_TEMP_-1.7.nc'
Annual_SALT_LOW_TEMP_LOW ='ocean_his_TEMP_-1.8.nc'

Winter_CTRL = 'ocean_his_TEMP_-1.9.nc'
Winter_SALT_HIGH_TEMP_HIGH = 'ocean_his_SALT_34.5.nc'
Winter_SALT_HIGH_TEMP_LOW = 'ocean_his_SALT_34.6.nc'
Winter_SALT_LOW_TEMP_HIGH = 'ocean_his_SALT_34.7.nc'
Winter_SALT_LOW_TEMP_LOW = 'ocean_his_SALT_34.9.nc'

%variables for each run

temp_Annual_CTRL = ncread(Annual_CTRL, 'temp');
temp_Annual_SALT_HIGH_TEMP_HIGH = ncread(Annual_SALT_HIGH_TEMP_HIGH, 'temp');
temp_Annual_SALT_HIGH_TEMP_LOW = ncread(Annual_SALT_HIGH_TEMP_LOW, 'temp');
temp_Annual_SALT_LOW_TEMP_HIGH = ncread(Annual_SALT_LOW_TEMP_HIGH, 'temp');
temp_Annual_SALT_LOW_TEMP_LOW = ncread(Annual_SALT_LOW_TEMP_LOW, 'temp');
temp_Winter_CTRL = ncread(Winter_CTRL, 'temp');
temp_Winter_SALT_HIGH_TEMP_HIGH = ncread(Winter_SALT_HIGH_TEMP_HIGH, 'temp');
temp_Winter_SALT_HIGH_TEMP_LOW = ncread(Winter_SALT_HIGH_TEMP_LOW, 'temp');
temp_Winter_SALT_LOW_TEMP_HIGH = ncread(Winter_SALT_LOW_TEMP_HIGH, 'temp');
temp_Winter_SALT_LOW_TEMP_LOW = ncread(Winter_SALT_LOW_TEMP_LOW, 'temp');


salt_Annual_CTRL = ncread(Annual_CTRL, 'salt');
salt_Annual_SALT_HIGH_TEMP_HIGH = ncread(Annual_SALT_HIGH_TEMP_HIGH, 'salt');
salt_Annual_SALT_HIGH_TEMP_LOW = ncread(Annual_SALT_HIGH_TEMP_LOW, 'salt');
salt_Annual_SALT_LOW_TEMP_HIGH = ncread(Annual_SALT_LOW_TEMP_HIGH, 'salt');
salt_Annual_SALT_LOW_TEMP_LOW = ncread(Annual_SALT_LOW_TEMP_LOW, 'salt');
salt_Winter_CTRL = ncread(Winter_CTRL, 'salt');
salt_Winter_SALT_HIGH_TEMP_HIGH = ncread(Winter_SALT_HIGH_TEMP_HIGH, 'salt');
salt_Winter_SALT_HIGH_TEMP_LOW = ncread(Winter_SALT_HIGH_TEMP_LOW, 'salt');
salt_Winter_SALT_LOW_TEMP_HIGH = ncread(Winter_SALT_LOW_TEMP_HIGH, 'salt');
salt_Winter_SALT_LOW_TEMP_LOW = ncread(Winter_SALT_LOW_TEMP_LOW, 'salt');


u=ncread(Annual_SALT_HIGH_TEMP_LOW,'u');
v=ncread(Annual_SALT_HIGH_TEMP_LOW,'v');
% x_rho = x-locations of RHO-points
x_rho=ncread(Annual_SALT_HIGH_TEMP_LOW, 'x_rho');
% y_rho = y-locations of RHO-points
y_rho=ncread(Annual_SALT_HIGH_TEMP_LOW, 'y_rho');
temp=ncread(Annual_SALT_HIGH_TEMP_LOW, 'temp');
%temp(temp==0)=NaN; %Remove some bad points
salt=ncread(Annual_SALT_HIGH_TEMP_LOW, 'salt');
%salt(salty==0)=NaN; %Remove some bad points
% h = bathymetry at RHO-points
h=ncread(Annual_SALT_HIGH_TEMP_LOW, 'h');
% zice = ice draft at RHO-points
zice=ncread(Annual_SALT_HIGH_TEMP_LOW, 'zice');
% Cs_r = S-coordinate stretching curves at RHO-points
Cs_r=ncread(Annual_SALT_HIGH_TEMP_LOW, 'Cs_r');
Cs_r_adjusted=repmat(Cs_r, [1,12,202]);
size(Cs_r_adjusted);
Cs_r_correct=permute(Cs_r_adjusted, [2 3 1]);
y_rho_adjusted=repmat(y_rho, [1,1,13]);
% ocean_time = time since initialisation
ocean_time=ncread(Annual_SALT_HIGH_TEMP_LOW,'ocean_time');
ocean_time_days = ocean_time./86400;



depth=Cs_r_correct.*(h+zice)+zice;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calculating density 

%make depth values a positive as that is what the functions need

depth_positive=depth*-1

size(salt_Annual_CTRL)
size(depth)

%need to make depth matrix same dimensions at the salt & temp matrices to
%work in the funciton 
depth_repmat = repmat(depth_positive,1,1,1,366)
size(depth_repmat)

%load in the CDP lat & lon 
lat_cdp = -67.5;
lon_cdp = 69;


%calculate abs salinity using paractical salinity values from ROMS model 
abs_salt_Annual_CTRL=gsw_SA_from_SP(salt_Annual_CTRL,depth_repmat,lon_cdp,lat_cdp)
abs_salt_Annual_SALT_HIGH_TEMP_HIGH=gsw_SA_from_SP(salt_Annual_SALT_HIGH_TEMP_HIGH,depth_repmat,lon_cdp,lat_cdp)
abs_salt_Annual_SALT_HIGH_TEMP_LOW=gsw_SA_from_SP(salt_Annual_SALT_HIGH_TEMP_LOW,depth_repmat,lon_cdp,lat_cdp)
abs_salt_Annual_SALT_LOW_TEMP_HIGH=gsw_SA_from_SP(salt_Annual_SALT_LOW_TEMP_HIGH,depth_repmat,lon_cdp,lat_cdp)
abs_salt_Annual_SALT_LOW_TEMP_LOW=gsw_SA_from_SP(salt_Annual_SALT_LOW_TEMP_LOW,depth_repmat,lon_cdp,lat_cdp)
abs_salt_Winter_CTRL=gsw_SA_from_SP(salt_Winter_CTRL,depth_repmat,lon_cdp,lat_cdp)
abs_salt_Winter_SALT_HIGH_TEMP_HIGH=gsw_SA_from_SP(salt_Winter_SALT_HIGH_TEMP_HIGH,depth_repmat,lon_cdp,lat_cdp)
abs_salt_Winter_SALT_HIGH_TEMP_LOW=gsw_SA_from_SP(salt_Winter_SALT_HIGH_TEMP_LOW,depth_repmat,lon_cdp,lat_cdp)
abs_salt_Winter_SALT_LOW_TEMP_HIGH=gsw_SA_from_SP(salt_Winter_SALT_LOW_TEMP_HIGH,depth_repmat,lon_cdp,lat_cdp)
abs_salt_Winter_SALT_LOW_TEMP_LOW=gsw_SA_from_SP(salt_Winter_SALT_LOW_TEMP_LOW,depth_repmat,lon_cdp,lat_cdp)


%calculate in situ temperature from potential temp output from ROMS model 
IS_temp_Annual_CTRL=gsw_t_from_pt0(abs_salt_Annual_CTRL, temp_Annual_CTRL, depth_repmat)
IS_temp_Annual_SALT_HIGH_TEMP_HIGH=gsw_t_from_pt0(abs_salt_Annual_SALT_HIGH_TEMP_HIGH, temp_Annual_SALT_HIGH_TEMP_HIGH, depth_repmat)
IS_temp_Annual_SALT_HIGH_TEMP_LOW=gsw_t_from_pt0(abs_salt_Annual_SALT_HIGH_TEMP_LOW, temp_Annual_SALT_HIGH_TEMP_LOW, depth_repmat)
IS_temp_Annual_SALT_LOW_TEMP_HIGH=gsw_t_from_pt0(abs_salt_Annual_SALT_LOW_TEMP_HIGH,temp_Annual_SALT_LOW_TEMP_HIGH, depth_repmat)
IS_temp_Annual_SALT_LOW_TEMP_LOW=gsw_t_from_pt0(abs_salt_Annual_SALT_LOW_TEMP_LOW,temp_Annual_SALT_LOW_TEMP_LOW, depth_repmat)
IS_temp_Winter_CTRL=gsw_t_from_pt0(abs_salt_Winter_CTRL,temp_Winter_CTRL, depth_repmat)
IS_temp_Winter_SALT_HIGH_TEMP_HIGH=gsw_t_from_pt0(abs_salt_Winter_SALT_HIGH_TEMP_HIGH,temp_Winter_SALT_HIGH_TEMP_HIGH, depth_repmat)
IS_temp_Winter_SALT_HIGH_TEMP_LOW=gsw_t_from_pt0(abs_salt_Winter_SALT_HIGH_TEMP_LOW,temp_Winter_SALT_HIGH_TEMP_LOW, depth_repmat)
IS_temp_Winter_SALT_LOW_TEMP_HIGH=gsw_t_from_pt0(abs_salt_Winter_SALT_LOW_TEMP_HIGH,temp_Winter_SALT_LOW_TEMP_HIGH, depth_repmat)
IS_temp_Winter_SALT_LOW_TEMP_LOW=gsw_t_from_pt0(abs_salt_Winter_SALT_LOW_TEMP_LOW,temp_Winter_SALT_LOW_TEMP_LOW, depth_repmat)

%set reference pressure to 0 dbar
p_ref=0

%calculate potential density using TEOS-10
density_Annual_CTRL=gsw_pot_rho_t_exact(abs_salt_Annual_CTRL, IS_temp_Annual_CTRL, depth_repmat, p_ref)
density_Annual_SALT_HIGH_TEMP_HIGH=gsw_pot_rho_t_exact(abs_salt_Annual_SALT_HIGH_TEMP_HIGH, IS_temp_Annual_SALT_HIGH_TEMP_HIGH, depth_repmat, p_ref)
density_Annual_SALT_HIGH_TEMP_LOW=gsw_pot_rho_t_exact(abs_salt_Annual_SALT_HIGH_TEMP_LOW, IS_temp_Annual_SALT_HIGH_TEMP_LOW, depth_repmat, p_ref)
density_Annual_SALT_LOW_TEMP_HIGH=gsw_pot_rho_t_exact(abs_salt_Annual_SALT_LOW_TEMP_HIGH,IS_temp_Annual_SALT_LOW_TEMP_HIGH, depth_repmat, p_ref)
density_Annual_SALT_LOW_TEMP_LOW=gsw_pot_rho_t_exact(abs_salt_Annual_SALT_LOW_TEMP_LOW,IS_temp_Annual_SALT_LOW_TEMP_LOW, depth_repmat, p_ref)
density_Winter_CTRL=gsw_pot_rho_t_exact(abs_salt_Winter_CTRL,IS_temp_Winter_CTRL, depth_repmat, p_ref)
density_Winter_SALT_HIGH_TEMP_HIGH=gsw_pot_rho_t_exact(abs_salt_Winter_SALT_HIGH_TEMP_HIGH,IS_temp_Winter_SALT_HIGH_TEMP_HIGH, depth_repmat, p_ref)
density_Winter_SALT_HIGH_TEMP_LOW=gsw_pot_rho_t_exact(abs_salt_Winter_SALT_HIGH_TEMP_LOW,IS_temp_Winter_SALT_HIGH_TEMP_LOW, depth_repmat, p_ref)
density_Winter_SALT_LOW_TEMP_HIGH=gsw_pot_rho_t_exact(abs_salt_Winter_SALT_LOW_TEMP_HIGH,IS_temp_Winter_SALT_LOW_TEMP_HIGH, depth_repmat, p_ref)
density_Winter_SALT_LOW_TEMP_LOW=gsw_pot_rho_t_exact(abs_salt_Winter_SALT_LOW_TEMP_LOW,IS_temp_Winter_SALT_LOW_TEMP_LOW, depth_repmat, p_ref)









%set reference pressure to 0 dbar
p_ref=0
pressure = repmat(p_ref, 12, 202, 13, 366);





%calculate potential density using EOS-80
density_Annual_CTRL=sw_dens(salt_Annual_CTRL, temp_Annual_CTRL, pressure);
density_Annual_SALT_HIGH_TEMP_HIGH=sw_dens(salt_Annual_SALT_HIGH_TEMP_HIGH, temp_Annual_SALT_HIGH_TEMP_HIGH, pressure);
density_Annual_SALT_HIGH_TEMP_LOW=sw_dens(salt_Annual_SALT_HIGH_TEMP_LOW, temp_Annual_SALT_HIGH_TEMP_LOW, pressure);
density_Annual_SALT_LOW_TEMP_HIGH=sw_dens(salt_Annual_SALT_LOW_TEMP_HIGH,temp_Annual_SALT_LOW_TEMP_HIGH, pressure);
density_Annual_SALT_LOW_TEMP_LOW=sw_dens(salt_Annual_SALT_LOW_TEMP_LOW,temp_Annual_SALT_LOW_TEMP_LOW, pressure);
density_Winter_CTRL=sw_dens(salt_Winter_CTRL,temp_Winter_CTRL, pressure);
density_Winter_SALT_HIGH_TEMP_HIGH=sw_dens(salt_Winter_SALT_HIGH_TEMP_HIGH,temp_Winter_SALT_HIGH_TEMP_HIGH, pressure);
density_Winter_SALT_HIGH_TEMP_LOW=sw_dens(salt_Winter_SALT_HIGH_TEMP_LOW,temp_Winter_SALT_HIGH_TEMP_LOW, pressure);
density_Winter_SALT_LOW_TEMP_HIGH=sw_dens(salt_Winter_SALT_LOW_TEMP_HIGH,temp_Winter_SALT_LOW_TEMP_HIGH, pressure);
density_Winter_SALT_LOW_TEMP_LOW=sw_dens(salt_Winter_SALT_LOW_TEMP_LOW,temp_Winter_SALT_LOW_TEMP_LOW, pressure);



size(salt_Annual_CTRL)
size(temp_Annual_CTRL)
zeros(size(salt_Annual_CTRL))
zeros(size(temp_Annual_CTRL))


%this was old density calculation that used output straight from ROMS, but
%it kept giving me density of 1030 which was too high, not sure what was
%wrong 
density_Annual_CTRL = rho_eos(temp_Annual_CTRL, salt_Annual_CTRL, depth);
density_Annual_SALT_HIGH_TEMP_HIGH  = rho_eos(temp_Annual_SALT_HIGH_TEMP_HIGH, salt_Annual_SALT_HIGH_TEMP_HIGH, depth);
density_Annual_SALT_HIGH_TEMP_LOW = rho_eos(temp_Annual_SALT_HIGH_TEMP_LOW, salt_Annual_SALT_HIGH_TEMP_LOW, depth);
density_Annual_SALT_LOW_TEMP_HIGH = rho_eos(temp_Annual_SALT_LOW_TEMP_HIGH, salt_Annual_SALT_LOW_TEMP_HIGH, depth);
density_Annual_SALT_LOW_TEMP_LOW = rho_eos(temp_Annual_SALT_LOW_TEMP_LOW, salt_Annual_SALT_LOW_TEMP_LOW, depth);
density_Winter_CTRL = rho_eos(temp_Winter_CTRL, salt_Winter_CTRL, depth);
density_Winter_SALT_HIGH_TEMP_HIGH  = rho_eos(temp_Winter_SALT_HIGH_TEMP_HIGH, salt_Winter_SALT_HIGH_TEMP_HIGH, depth);
density_Winter_SALT_HIGH_TEMP_LOW = rho_eos(temp_Winter_SALT_HIGH_TEMP_LOW, salt_Winter_SALT_HIGH_TEMP_LOW, depth);
density_Winter_SALT_LOW_TEMP_HIGH = rho_eos(temp_Winter_SALT_LOW_TEMP_HIGH, salt_Winter_SALT_LOW_TEMP_HIGH, depth);
density_Winter_SALT_LOW_TEMP_LOW = rho_eos(temp_Winter_SALT_LOW_TEMP_LOW, salt_Winter_SALT_LOW_TEMP_LOW, depth);


density_test = rho_eos(-1.2, 34.6, -472)
density_test_2 = seawater_density(34.6, -1.2, -472)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%plotting the gif 
figure, 
for tt=1:length(ocean_time_days)
    subplot(2,1,1)
    pcolor(squeeze(y_rho_adjusted(3,:,:)),squeeze(depth(3,:,:)),squeeze(temp(3,:,:,tt))),shading flat 
    %pcolor(squeeze(y_rho_adjusted(3,:,:)),squeeze(depth(3,:,:)),squeeze(temp(3,:,:,30-end:end))),shading flat 
    hcb=colorbar; 
    set(gca,'colorscale','log');
    title(hcb, 'temperature (C)'), caxis([-1.95,-1.89])
    title('Animation of 2D modelled temperature over a year in Antarctica with ice shelf and bathymetry')
    xlabel('horizontal distance (m)')
    ylabel('depth (m)')
    
    subplot(2,1,2)
    pcolor(squeeze(y_rho_adjusted(3,:,:)),squeeze(depth(3,:,:)),squeeze(salt(3,:,:,tt))),shading flat 
    hcb=colorbar; 
    set(gca,'colorscale','log');
    title(hcb, 'salinity'), caxis([34.53,34.7])
    xlabel('horizontal distance (m)')
    ylabel('depth (m)')
    
    drawnow
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








%want to take mean over shelf break (not including the ice shelf) so want mean from 100000m to 250000000
[~,where]=min(abs(y_rho(1,:)-100000))
%this gives you the output of 38 
%use this code to check how close it is to the value you wanted (i.e.
%100000m)
 y_rho(1,38)
%this will give you 100375m 
%do it again for 250000
[~,where]=min(abs(y_rho(1,:)-250000))
y_rho(1,92)








%plotting time series temperature, mean value surface over 100-250km
subplot(3,2,1);

temp_Annual_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(temp_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,12,:),2),1));
plot(ocean_time_days,temp_Annual_SALT_HIGH_TEMP_HIGH_mean, '-k', 'DisplayName', 'TEMP -1.5', 'LineWidth',2)

xlim([0 365])
title('Temperature')
xlabel('days')
ylabel('Temperature (degrees C)')
grid on
hold on 

temp_Annual_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(temp_Annual_SALT_HIGH_TEMP_LOW(:,38:92,12,:),2),1));
plot(ocean_time_days,temp_Annual_SALT_HIGH_TEMP_LOW_mean, '-r', 'DisplayName', 'TEMP -1.6', 'LineWidth',2)

temp_Annual_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(temp_Annual_SALT_LOW_TEMP_HIGH(:,38:92,12,:),2),1));
plot(ocean_time_days,temp_Annual_SALT_LOW_TEMP_HIGH_mean,'-g', 'DisplayName', 'TEMP -1.7', 'LineWidth',2)

temp_Annual_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(temp_Annual_SALT_LOW_TEMP_LOW(:,38:92,12,:),2),1));
plot(ocean_time_days,temp_Annual_SALT_LOW_TEMP_LOW_mean,'-c', 'DisplayName', 'TEMP -1.8', 'LineWidth',2)

temp_Winter_CTRL_mean = squeeze(mean(mean(temp_Winter_CTRL(:,38:92,12,:),2),1));
plot(ocean_time_days,temp_Winter_CTRL_mean, 'DisplayName', 'TEMP -1.9', 'LineWidth',2)


temp_Winter_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(temp_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,12,:),2),1));
plot(ocean_time_days,temp_Winter_SALT_HIGH_TEMP_HIGH_mean, '-m','DisplayName', 'SALT 34.5', 'LineWidth',2)

temp_Winter_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(temp_Winter_SALT_HIGH_TEMP_LOW(:,38:92,12,:),2),1));
plot(ocean_time_days,temp_Winter_SALT_HIGH_TEMP_LOW_mean, '-y','DisplayName', 'SALT 34.6', 'LineWidth',2)

temp_Winter_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(temp_Winter_SALT_LOW_TEMP_HIGH(:,38:92,12,:),2),1));
plot(ocean_time_days,temp_Winter_SALT_LOW_TEMP_HIGH_mean, 'DisplayName', 'SALT 34.7', 'LineWidth',2)

temp_Winter_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(temp_Winter_SALT_LOW_TEMP_LOW(:,38:92,12,:),2),1));
plot(ocean_time_days,temp_Winter_SALT_LOW_TEMP_LOW_mean, 'DisplayName', 'SALT 34.9', 'LineWidth',2)

temp_Annual_CTRL_mean = squeeze(mean(mean(temp_Annual_CTRL(:,38:92,12,:),2),1));
plot(ocean_time_days,temp_Annual_CTRL_mean, 'DisplayName', 'CTRL', 'LineWidth',2)



hold off




%plotting time series salinity, mean value sea floor over 100-250km
subplot(3,2,3);

salt_Annual_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(salt_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,12,:),2),1));
plot(ocean_time_days,salt_Annual_SALT_HIGH_TEMP_HIGH_mean, '-k', 'DisplayName', 'TEMP -1.5', 'LineWidth',2)

xlim([0 365])
title('Salinity')
xlabel('days')
ylabel('Salinity')
grid on
hold on 


salt_Annual_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(salt_Annual_SALT_HIGH_TEMP_LOW(:,38:92,12,:),2),1));
plot(ocean_time_days,salt_Annual_SALT_HIGH_TEMP_LOW_mean, '-r', 'DisplayName', 'TEMP -1.6', 'LineWidth',2)

salt_Annual_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(salt_Annual_SALT_LOW_TEMP_HIGH(:,38:92,12,:),2),1));
plot(ocean_time_days,salt_Annual_SALT_LOW_TEMP_HIGH_mean,'-g', 'DisplayName', 'TEMP -1.7', 'LineWidth',2)

salt_Annual_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(salt_Annual_SALT_LOW_TEMP_LOW(:,38:92,12,:),2),1));
plot(ocean_time_days,salt_Annual_SALT_LOW_TEMP_LOW_mean,'-c', 'DisplayName', 'TEMP -1.8', 'LineWidth',2)

salt_Winter_CTRL_mean = squeeze(mean(mean(salt_Winter_CTRL(:,38:92,12,:),2),1));
plot(ocean_time_days,salt_Winter_CTRL_mean, 'DisplayName', 'TEMP -1.9', 'LineWidth',2)


salt_Winter_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(salt_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,12,:),2),1));
plot(ocean_time_days,salt_Winter_SALT_HIGH_TEMP_HIGH_mean, '-m','DisplayName', 'SALT 34.5', 'LineWidth',2)

salt_Winter_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(salt_Winter_SALT_HIGH_TEMP_LOW(:,38:92,12,:),2),1));
plot(ocean_time_days,salt_Winter_SALT_HIGH_TEMP_LOW_mean, '-y','DisplayName', 'SALT 34.6', 'LineWidth',2)

salt_Winter_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(salt_Winter_SALT_LOW_TEMP_HIGH(:,38:92,12,:),2),1));
plot(ocean_time_days,salt_Winter_SALT_LOW_TEMP_HIGH_mean, 'DisplayName', 'SALT 34.7', 'LineWidth',2)

salt_Winter_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(salt_Winter_SALT_LOW_TEMP_LOW(:,38:92,12,:),2),1));
plot(ocean_time_days,salt_Winter_SALT_LOW_TEMP_LOW_mean, 'DisplayName', 'SALT 34.9', 'LineWidth',2)

salt_Annual_CTRL_mean = squeeze(mean(mean(salt_Annual_CTRL(:,38:92,12,:),2),1));
plot(ocean_time_days,salt_Annual_CTRL_mean, 'DisplayName', 'CTRL', 'LineWidth',2)


hold off



%plotting time series density, mean value sea floor over 100-250km
subplot(3,2,5);

density_Annual_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(density_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,12,:),2),1));
plot(ocean_time_days,density_Annual_SALT_HIGH_TEMP_HIGH_mean, '-k', 'DisplayName', 'TEMP -1.5', 'LineWidth',2)

xlim([0 365])
title('Density')
xlabel('days')
ylabel('Density (kg/m^3)')
grid on
hold on 

density_Annual_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(density_Annual_SALT_HIGH_TEMP_LOW(:,38:92,12,:),2),1));
plot(ocean_time_days,density_Annual_SALT_HIGH_TEMP_LOW_mean, '-r', 'DisplayName', 'TEMP -1.6', 'LineWidth',2)

density_Annual_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(density_Annual_SALT_LOW_TEMP_HIGH(:,38:92,12,:),2),1));
plot(ocean_time_days,density_Annual_SALT_LOW_TEMP_HIGH_mean,'-g', 'DisplayName', 'TEMP -1.7', 'LineWidth',2)

density_Annual_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(density_Annual_SALT_LOW_TEMP_LOW(:,38:92,12,:),2),1));
plot(ocean_time_days,density_Annual_SALT_LOW_TEMP_LOW_mean,'-c', 'DisplayName', 'TEMP -1.8', 'LineWidth',2)

density_Winter_CTRL_mean = squeeze(mean(mean(density_Winter_CTRL(:,38:92,12,:),2),1));
plot(ocean_time_days,density_Winter_CTRL_mean, 'DisplayName', 'TEMP -1.9', 'LineWidth',2)


density_Winter_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(density_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,12,:),2),1));
plot(ocean_time_days,density_Winter_SALT_HIGH_TEMP_HIGH_mean, '-m','DisplayName', 'SALT 34.5', 'LineWidth',2)

density_Winter_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(density_Winter_SALT_HIGH_TEMP_LOW(:,38:92,12,:),2),1));
plot(ocean_time_days,density_Winter_SALT_HIGH_TEMP_LOW_mean, '-y','DisplayName', 'SALT 34.6', 'LineWidth',2)

density_Winter_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(density_Winter_SALT_LOW_TEMP_HIGH(:,38:92,12,:),2),1));
plot(ocean_time_days,density_Winter_SALT_LOW_TEMP_HIGH_mean, 'DisplayName', 'SALT 34.7', 'LineWidth',2)

density_Winter_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(density_Winter_SALT_LOW_TEMP_LOW(:,38:92,12,:),2),1));
plot(ocean_time_days,density_Winter_SALT_LOW_TEMP_LOW_mean, 'DisplayName', 'SALT 34.9', 'LineWidth',2)

density_Annual_CTRL_mean = squeeze(mean(mean(density_Annual_CTRL(:,38:92,12,:),2),1));
plot(ocean_time_days,density_Annual_CTRL_mean, 'DisplayName', 'CTRL', 'LineWidth',2)


hold off

lgd = legend;
lgd.FontSize = 10;
lgd.Title.String = 'Model Run';
lgd.Location = 'southoutside';






%plotting time series temperature, mean value sea floor over 100-250km
%difference from control
subplot(3,2,2);

temp_Annual_SALT_HIGH_TEMP_HIGH_mean_diff = minus(temp_Annual_SALT_HIGH_TEMP_HIGH_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Annual_SALT_HIGH_TEMP_HIGH_mean_diff, '-k','DisplayName', 'TEMP -1.5', 'LineWidth',2)

xlim([0 365])
title('Temperature - difference from CTRL')
xlabel('days')
ylabel('Temperature (degrees C)')
grid on
hold on 


temp_Annual_SALT_HIGH_TEMP_LOW_mean_diff = minus(temp_Annual_SALT_HIGH_TEMP_LOW_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Annual_SALT_HIGH_TEMP_LOW_mean_diff, '-r','DisplayName', 'TEMP -1.6', 'LineWidth',2)

temp_Annual_SALT_LOW_TEMP_HIGH_mean_diff = minus(temp_Annual_SALT_LOW_TEMP_HIGH_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Annual_SALT_LOW_TEMP_HIGH_mean_diff, '-g','DisplayName', 'TEMP -1.7', 'LineWidth',2)

temp_Annual_SALT_LOW_TEMP_LOW_mean_diff = minus(temp_Annual_SALT_LOW_TEMP_LOW_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Annual_SALT_LOW_TEMP_LOW_mean_diff, '-c','DisplayName', 'TEMP -1.8', 'LineWidth',2)

temp_Winter_CTRL_mean_diff = minus(temp_Winter_CTRL_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Winter_CTRL_mean_diff,'DisplayName', 'TEMP -1.9', 'LineWidth',2)



temp_Winter_SALT_HIGH_TEMP_HIGH_mean_diff = minus(temp_Winter_SALT_HIGH_TEMP_HIGH_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Winter_SALT_HIGH_TEMP_HIGH_mean_diff, '-m','DisplayName', 'SALT 34.5', 'LineWidth',2)

temp_Winter_SALT_HIGH_TEMP_LOW_mean_diff = minus(temp_Winter_SALT_HIGH_TEMP_LOW_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Winter_SALT_HIGH_TEMP_LOW_mean_diff, '-y','DisplayName', 'SALT 34.6', 'LineWidth',2)

temp_Winter_SALT_LOW_TEMP_HIGH_mean_diff = minus(temp_Winter_SALT_LOW_TEMP_HIGH_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Winter_SALT_LOW_TEMP_HIGH_mean_diff, 'DisplayName', 'SALT 34.7', 'LineWidth',2)

temp_Winter_SALT_LOW_TEMP_LOW_mean_diff = minus(temp_Winter_SALT_LOW_TEMP_LOW_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Winter_SALT_LOW_TEMP_LOW_mean_diff, 'DisplayName', 'SALT 34.9', 'LineWidth',2)


hold off





%plotting time series salinity, mean value sea floor over 100-250km
%difference from control
subplot(3,2,4);

salt_Annual_SALT_HIGH_TEMP_HIGH_mean_diff = minus(salt_Annual_SALT_HIGH_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Annual_SALT_HIGH_TEMP_HIGH_mean_diff, '-k','DisplayName', 'TEMP -1.5', 'LineWidth',2)

xlim([0 365])
title('Salinity - difference from CTRL')
xlabel('days')
ylabel('Salinity')
grid on
hold on 

salt_Annual_SALT_HIGH_TEMP_LOW_mean_diff = minus(salt_Annual_SALT_HIGH_TEMP_LOW_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Annual_SALT_HIGH_TEMP_LOW_mean_diff, '-r','DisplayName', 'TEMP -1.6', 'LineWidth',2)

salt_Annual_SALT_LOW_TEMP_HIGH_mean_diff = minus(salt_Annual_SALT_LOW_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Annual_SALT_LOW_TEMP_HIGH_mean_diff, '-g','DisplayName', 'TEMP -1.7', 'LineWidth',2)

salt_Annual_SALT_LOW_TEMP_LOW_mean_diff = minus(salt_Annual_SALT_HIGH_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Annual_SALT_LOW_TEMP_LOW_mean_diff, '-c','DisplayName', 'TEMP -1.8', 'LineWidth',2)

salt_Winter_CTRL_mean_diff = minus(salt_Winter_CTRL_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Winter_CTRL_mean_diff,'DisplayName', 'TEMP -1.9', 'LineWidth',2)



salt_Winter_SALT_HIGH_TEMP_HIGH_mean_diff = minus(salt_Winter_SALT_HIGH_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Winter_SALT_HIGH_TEMP_HIGH_mean_diff, '-m','DisplayName', 'SALT 34.5', 'LineWidth',2)

salt_Winter_SALT_HIGH_TEMP_LOW_mean_diff = minus(salt_Winter_SALT_HIGH_TEMP_LOW_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Winter_SALT_HIGH_TEMP_LOW_mean_diff, '-y','DisplayName', 'SALT 34.6', 'LineWidth',2)

salt_Winter_SALT_LOW_TEMP_HIGH_mean_diff = minus(salt_Winter_SALT_LOW_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Winter_SALT_LOW_TEMP_HIGH_mean_diff, 'DisplayName', 'SALT 34.7', 'LineWidth',2)

salt_Winter_SALT_LOW_TEMP_LOW_mean_diff = minus(salt_Winter_SALT_LOW_TEMP_LOW_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Winter_SALT_LOW_TEMP_LOW_mean_diff, 'DisplayName', 'SALT 34.9', 'LineWidth',2)

hold off




%plotting time series density, mean value sea floor over 100-250km
%difference from control
subplot(3,2,6);

density_Annual_SALT_HIGH_TEMP_HIGH_mean_diff = minus(density_Annual_SALT_HIGH_TEMP_HIGH_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Annual_SALT_HIGH_TEMP_HIGH_mean_diff, '-k','DisplayName', 'TEMP -1.5', 'LineWidth',2)

xlim([0 365])
title('Density - difference from CTRL')
xlabel('days')
ylabel('Density (kg/m^3)')
grid on
hold on 

density_Annual_SALT_HIGH_TEMP_LOW_mean_diff = minus(density_Annual_SALT_HIGH_TEMP_LOW_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Annual_SALT_HIGH_TEMP_LOW_mean_diff, '-r','DisplayName', 'TEMP -1.6', 'LineWidth',2)

density_Annual_SALT_LOW_TEMP_HIGH_mean_diff = minus(density_Annual_SALT_LOW_TEMP_HIGH_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Annual_SALT_LOW_TEMP_HIGH_mean_diff, '-g','DisplayName', 'TEMP -1.7', 'LineWidth',2)

density_Annual_SALT_LOW_TEMP_LOW_mean_diff = minus(density_Annual_SALT_HIGH_TEMP_HIGH_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Annual_SALT_LOW_TEMP_LOW_mean_diff, '-c','DisplayName', 'TEMP -1.8', 'LineWidth',2)

density_Winter_CTRL_mean_diff = minus(density_Winter_CTRL_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Winter_CTRL_mean_diff,'DisplayName', 'TEMP -1.9', 'LineWidth',2)


density_Winter_SALT_HIGH_TEMP_HIGH_mean_diff = minus(density_Winter_SALT_HIGH_TEMP_HIGH_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Winter_SALT_HIGH_TEMP_HIGH_mean_diff, '-m','DisplayName', 'SALT 34.5', 'LineWidth',2)

density_Winter_SALT_HIGH_TEMP_LOW_mean_diff = minus(density_Winter_SALT_HIGH_TEMP_LOW_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Winter_SALT_HIGH_TEMP_LOW_mean_diff, '-y','DisplayName', 'SALT 34.6', 'LineWidth',2)

density_Winter_SALT_LOW_TEMP_HIGH_mean_diff = minus(density_Winter_SALT_LOW_TEMP_HIGH_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Winter_SALT_LOW_TEMP_HIGH_mean_diff, 'DisplayName', 'SALT 34.7', 'LineWidth',2)

density_Winter_SALT_LOW_TEMP_LOW_mean_diff = minus(density_Winter_SALT_LOW_TEMP_LOW_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Winter_SALT_LOW_TEMP_LOW_mean_diff, 'DisplayName', 'SALT 34.9', 'LineWidth',2)

hold off

lgd = legend;
lgd.FontSize = 10;
lgd.Title.String = 'Model Run';
lgd.Location = 'southoutside';


%title when depth is 12 (aka 1 below surface)
% figured this out by running this code:
%mean(mean(depth(:,39:92,12,:),2),1)
sgtitle('Surface Water (~13.13m below surface)')























%plotting time series temperature, mean value sea floor over 100-250km
subplot(3,2,1);

temp_Annual_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(temp_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Annual_SALT_HIGH_TEMP_HIGH_mean, '-k', 'DisplayName', 'TEMP -1.5', 'LineWidth',2)

xlim([0 365])
title('Temperature')
xlabel('days')
ylabel('Temperature (degrees C)')
grid on
hold on 

temp_Annual_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(temp_Annual_SALT_HIGH_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Annual_SALT_HIGH_TEMP_LOW_mean, '-r', 'DisplayName', 'TEMP -1.6', 'LineWidth',2)

temp_Annual_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(temp_Annual_SALT_LOW_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Annual_SALT_LOW_TEMP_HIGH_mean,'-g', 'DisplayName', 'TEMP -1.7', 'LineWidth',2)

temp_Annual_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(temp_Annual_SALT_LOW_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Annual_SALT_LOW_TEMP_LOW_mean,'-c', 'DisplayName', 'TEMP -1.8', 'LineWidth',2)

temp_Winter_CTRL_mean = squeeze(mean(mean(temp_Winter_CTRL(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Winter_CTRL_mean, 'DisplayName', 'TEMP -1.9', 'LineWidth',2)


temp_Winter_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(temp_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Winter_SALT_HIGH_TEMP_HIGH_mean, '-m','DisplayName', 'SALT 34.5', 'LineWidth',2)

temp_Winter_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(temp_Winter_SALT_HIGH_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Winter_SALT_HIGH_TEMP_LOW_mean, '-y','DisplayName', 'SALT 34.6', 'LineWidth',2)

temp_Winter_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(temp_Winter_SALT_LOW_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Winter_SALT_LOW_TEMP_HIGH_mean, 'DisplayName', 'SALT 34.7', 'LineWidth',2)

temp_Winter_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(temp_Winter_SALT_LOW_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Winter_SALT_LOW_TEMP_LOW_mean, 'DisplayName', 'SALT 34.9', 'LineWidth',2)

temp_Annual_CTRL_mean = squeeze(mean(mean(temp_Annual_CTRL(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Annual_CTRL_mean, 'DisplayName', 'CTRL', 'LineWidth',2)



hold off




%plotting time series salinity, mean value sea floor over 100-250km
subplot(3,2,3);

salt_Annual_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(salt_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Annual_SALT_HIGH_TEMP_HIGH_mean, '-k', 'DisplayName', 'TEMP -1.5', 'LineWidth',2)

xlim([0 365])
title('Salinity')
xlabel('days')
ylabel('Salinity')
grid on
hold on 


salt_Annual_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(salt_Annual_SALT_HIGH_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Annual_SALT_HIGH_TEMP_LOW_mean, '-r', 'DisplayName', 'TEMP -1.6', 'LineWidth',2)

salt_Annual_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(salt_Annual_SALT_LOW_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Annual_SALT_LOW_TEMP_HIGH_mean,'-g', 'DisplayName', 'TEMP -1.7', 'LineWidth',2)

salt_Annual_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(salt_Annual_SALT_LOW_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Annual_SALT_LOW_TEMP_LOW_mean,'-c', 'DisplayName', 'TEMP -1.8', 'LineWidth',2)

salt_Winter_CTRL_mean = squeeze(mean(mean(salt_Winter_CTRL(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Winter_CTRL_mean, 'DisplayName', 'TEMP -1.9', 'LineWidth',2)


salt_Winter_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(salt_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Winter_SALT_HIGH_TEMP_HIGH_mean, '-m','DisplayName', 'SALT 34.5', 'LineWidth',2)

salt_Winter_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(salt_Winter_SALT_HIGH_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Winter_SALT_HIGH_TEMP_LOW_mean, '-y','DisplayName', 'SALT 34.6', 'LineWidth',2)

salt_Winter_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(salt_Winter_SALT_LOW_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Winter_SALT_LOW_TEMP_HIGH_mean, 'DisplayName', 'SALT 34.7', 'LineWidth',2)

salt_Winter_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(salt_Winter_SALT_LOW_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Winter_SALT_LOW_TEMP_LOW_mean, 'DisplayName', 'SALT 34.9', 'LineWidth',2)

salt_Annual_CTRL_mean = squeeze(mean(mean(salt_Annual_CTRL(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Annual_CTRL_mean, 'DisplayName', 'CTRL', 'LineWidth',2)


hold off



%plotting time series density, mean value sea floor over 100-250km
subplot(3,2,5);

density_Annual_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(density_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Annual_SALT_HIGH_TEMP_HIGH_mean, '-k', 'DisplayName', 'TEMP -1.5', 'LineWidth',2)

xlim([0 365])
title('Density')
xlabel('days')
ylabel('Density (kg/m^3)')
grid on
hold on 

density_Annual_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(density_Annual_SALT_HIGH_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Annual_SALT_HIGH_TEMP_LOW_mean, '-r', 'DisplayName', 'TEMP -1.6', 'LineWidth',2)

density_Annual_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(density_Annual_SALT_LOW_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Annual_SALT_LOW_TEMP_HIGH_mean,'-g', 'DisplayName', 'TEMP -1.7', 'LineWidth',2)

density_Annual_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(density_Annual_SALT_LOW_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Annual_SALT_LOW_TEMP_LOW_mean,'-c', 'DisplayName', 'TEMP -1.8', 'LineWidth',2)

density_Winter_CTRL_mean = squeeze(mean(mean(density_Winter_CTRL(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Winter_CTRL_mean, 'DisplayName', 'TEMP -1.9', 'LineWidth',2)


density_Winter_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(density_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Winter_SALT_HIGH_TEMP_HIGH_mean, '-m','DisplayName', 'SALT 34.5', 'LineWidth',2)

density_Winter_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(density_Winter_SALT_HIGH_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Winter_SALT_HIGH_TEMP_LOW_mean, '-y','DisplayName', 'SALT 34.6', 'LineWidth',2)

density_Winter_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(density_Winter_SALT_LOW_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Winter_SALT_LOW_TEMP_HIGH_mean, 'DisplayName', 'SALT 34.7', 'LineWidth',2)

density_Winter_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(density_Winter_SALT_LOW_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Winter_SALT_LOW_TEMP_LOW_mean, 'DisplayName', 'SALT 34.9', 'LineWidth',2)

density_Annual_CTRL_mean = squeeze(mean(mean(density_Annual_CTRL(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Annual_CTRL_mean, 'DisplayName', 'CTRL', 'LineWidth',2)


hold off

%lgd = legend;
%lgd.FontSize = 10;
%lgd.Title.String = 'Model Run';
%lgd.Location = 'southoutside';






%plotting time series temperature, mean value sea floor over 100-250km
%difference from control
subplot(3,2,2);

temp_Annual_SALT_HIGH_TEMP_HIGH_mean_diff = minus(temp_Annual_SALT_HIGH_TEMP_HIGH_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Annual_SALT_HIGH_TEMP_HIGH_mean_diff, '-k','DisplayName', 'TEMP -1.5', 'LineWidth',2)

xlim([0 365])
title('Temperature - difference from CTRL')
xlabel('days')
ylabel('Temperature (degrees C)')
grid on
hold on 


temp_Annual_SALT_HIGH_TEMP_LOW_mean_diff = minus(temp_Annual_SALT_HIGH_TEMP_LOW_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Annual_SALT_HIGH_TEMP_LOW_mean_diff, '-r','DisplayName', 'TEMP -1.6', 'LineWidth',2)

temp_Annual_SALT_LOW_TEMP_HIGH_mean_diff = minus(temp_Annual_SALT_LOW_TEMP_HIGH_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Annual_SALT_LOW_TEMP_HIGH_mean_diff, '-g','DisplayName', 'TEMP -1.7', 'LineWidth',2)

temp_Annual_SALT_LOW_TEMP_LOW_mean_diff = minus(temp_Annual_SALT_LOW_TEMP_LOW_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Annual_SALT_LOW_TEMP_LOW_mean_diff, '-c','DisplayName', 'TEMP -1.8', 'LineWidth',2)

temp_Winter_CTRL_mean_diff = minus(temp_Winter_CTRL_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Winter_CTRL_mean_diff, 'DisplayName', 'TEMP -1.9', 'LineWidth',2)



temp_Winter_SALT_HIGH_TEMP_HIGH_mean_diff = minus(temp_Winter_SALT_HIGH_TEMP_HIGH_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Winter_SALT_HIGH_TEMP_HIGH_mean_diff, '-m','DisplayName', 'SALT 34.5', 'LineWidth',2)

temp_Winter_SALT_HIGH_TEMP_LOW_mean_diff = minus(temp_Winter_SALT_HIGH_TEMP_LOW_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Winter_SALT_HIGH_TEMP_LOW_mean_diff, '-y','DisplayName', 'SALT 34.6', 'LineWidth',2)

temp_Winter_SALT_LOW_TEMP_HIGH_mean_diff = minus(temp_Winter_SALT_LOW_TEMP_HIGH_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Winter_SALT_LOW_TEMP_HIGH_mean_diff, 'DisplayName', 'SALT 34.7', 'LineWidth',2)

temp_Winter_SALT_LOW_TEMP_LOW_mean_diff = minus(temp_Winter_SALT_LOW_TEMP_LOW_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Winter_SALT_LOW_TEMP_LOW_mean_diff, 'DisplayName', 'SALT 34.9', 'LineWidth',2)


hold off





%plotting time series salinity, mean value sea floor over 100-250km
%difference from control
subplot(3,2,4);

salt_Annual_SALT_HIGH_TEMP_HIGH_mean_diff = minus(salt_Annual_SALT_HIGH_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Annual_SALT_HIGH_TEMP_HIGH_mean_diff, '-k','DisplayName', 'TEMP -1.5', 'LineWidth',2)

xlim([0 365])
title('Salinity - difference from CTRL')
xlabel('days')
ylabel('Salinity')
grid on
hold on 

salt_Annual_SALT_HIGH_TEMP_LOW_mean_diff = minus(salt_Annual_SALT_HIGH_TEMP_LOW_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Annual_SALT_HIGH_TEMP_LOW_mean_diff, '-r','DisplayName', 'TEMP -1.6', 'LineWidth',2)

salt_Annual_SALT_LOW_TEMP_HIGH_mean_diff = minus(salt_Annual_SALT_LOW_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Annual_SALT_LOW_TEMP_HIGH_mean_diff, '-g','DisplayName', 'TEMP -1.7', 'LineWidth',2)

salt_Annual_SALT_LOW_TEMP_LOW_mean_diff = minus(salt_Annual_SALT_HIGH_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Annual_SALT_LOW_TEMP_LOW_mean_diff, '-c','DisplayName', 'TEMP -1.8', 'LineWidth',2)

salt_Winter_CTRL_mean_diff = minus(salt_Winter_CTRL_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Winter_CTRL_mean_diff, 'DisplayName', 'TEMP -1.9', 'LineWidth',2)



salt_Winter_SALT_HIGH_TEMP_HIGH_mean_diff = minus(salt_Winter_SALT_HIGH_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Winter_SALT_HIGH_TEMP_HIGH_mean_diff, '-m','DisplayName', 'SALT 34.5', 'LineWidth',2)

salt_Winter_SALT_HIGH_TEMP_LOW_mean_diff = minus(salt_Winter_SALT_HIGH_TEMP_LOW_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Winter_SALT_HIGH_TEMP_LOW_mean_diff, '-y','DisplayName', 'SALT 34.6', 'LineWidth',2)

salt_Winter_SALT_LOW_TEMP_HIGH_mean_diff = minus(salt_Winter_SALT_LOW_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Winter_SALT_LOW_TEMP_HIGH_mean_diff, 'DisplayName', 'SALT 34.7', 'LineWidth',2)

salt_Winter_SALT_LOW_TEMP_LOW_mean_diff = minus(salt_Winter_SALT_LOW_TEMP_LOW_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Winter_SALT_LOW_TEMP_LOW_mean_diff, 'DisplayName', 'SALT 34.9', 'LineWidth',2)

hold off




%plotting time series density, mean value sea floor over 100-250km
%difference from control
subplot(3,2,6);

density_Annual_SALT_HIGH_TEMP_HIGH_mean_diff = minus(density_Annual_SALT_HIGH_TEMP_HIGH_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Annual_SALT_HIGH_TEMP_HIGH_mean_diff, '-k','DisplayName', 'TEMP -1.5', 'LineWidth',2)

xlim([0 365])
title('Density - difference from CTRL')
xlabel('days')
ylabel('Density (kg/m^3)')
grid on
hold on 

density_Annual_SALT_HIGH_TEMP_LOW_mean_diff = minus(density_Annual_SALT_HIGH_TEMP_LOW_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Annual_SALT_HIGH_TEMP_LOW_mean_diff, '-r','DisplayName', 'TEMP -1.6', 'LineWidth',2)

density_Annual_SALT_LOW_TEMP_HIGH_mean_diff = minus(density_Annual_SALT_LOW_TEMP_HIGH_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Annual_SALT_LOW_TEMP_HIGH_mean_diff, '-g','DisplayName', 'TEMP -1.7', 'LineWidth',2)

density_Annual_SALT_LOW_TEMP_LOW_mean_diff = minus(density_Annual_SALT_HIGH_TEMP_HIGH_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Annual_SALT_LOW_TEMP_LOW_mean_diff, '-c','DisplayName', 'TEMP -1.8', 'LineWidth',2)

density_Winter_CTRL_mean_diff = minus(density_Winter_CTRL_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Winter_CTRL_mean_diff,'DisplayName', 'TEMP -1.9', 'LineWidth',2)


density_Winter_SALT_HIGH_TEMP_HIGH_mean_diff = minus(density_Winter_SALT_HIGH_TEMP_HIGH_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Winter_SALT_HIGH_TEMP_HIGH_mean_diff, '-m','DisplayName', 'SALT 34.5', 'LineWidth',2)

density_Winter_SALT_HIGH_TEMP_LOW_mean_diff = minus(density_Winter_SALT_HIGH_TEMP_LOW_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Winter_SALT_HIGH_TEMP_LOW_mean_diff, '-y','DisplayName', 'SALT 34.6', 'LineWidth',2)

density_Winter_SALT_LOW_TEMP_HIGH_mean_diff = minus(density_Winter_SALT_LOW_TEMP_HIGH_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Winter_SALT_LOW_TEMP_HIGH_mean_diff, 'DisplayName', 'SALT 34.7', 'LineWidth',2)

density_Winter_SALT_LOW_TEMP_LOW_mean_diff = minus(density_Winter_SALT_LOW_TEMP_LOW_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Winter_SALT_LOW_TEMP_LOW_mean_diff, 'DisplayName', 'SALT 34.9', 'LineWidth',2)

hold off

%lgd = legend;
%lgd.FontSize = 10;
%lgd.Title.String = 'Model Run';
%lgd.Location = 'southoutside';


%title when depth is 2 (aka 1 above sea floor)
% figured this out by running this code:
%mean(mean(depth(:,39:92,2,:),2),1)
sgtitle('Bottom Water (~472.22m below surface)')













%%%this is the code for my old model runs used to determine the CTRL 

%plotting time series temperature, mean value sea floor over 100-250km
subplot(3,2,1);

temp_Annual_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(temp_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Annual_SALT_HIGH_TEMP_HIGH_mean, '-k', 'DisplayName', 'Annual SALT HIGH TEMP HIGH', 'LineWidth',2)

xlim([0 365])
title('Temperature')
xlabel('days')
ylabel('Temperature (degrees C)')
grid on
hold on 

temp_Annual_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(temp_Annual_SALT_HIGH_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Annual_SALT_HIGH_TEMP_LOW_mean, '-r', 'DisplayName', 'Annual SALT HIGH TEMP LOW', 'LineWidth',2)

temp_Annual_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(temp_Annual_SALT_LOW_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Annual_SALT_LOW_TEMP_HIGH_mean,'-g', 'DisplayName', 'Annual SALT LOW TEMP HIGH', 'LineWidth',2)

temp_Annual_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(temp_Annual_SALT_LOW_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Annual_SALT_LOW_TEMP_LOW_mean,'-c', 'DisplayName', 'Annual SALT LOW TEMP LOW', 'LineWidth',2)


temp_Winter_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(temp_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Winter_SALT_HIGH_TEMP_HIGH_mean, '-m','DisplayName', 'Winter SALT HIGH TEMP HIGH', 'LineWidth',2)

temp_Winter_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(temp_Winter_SALT_HIGH_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Winter_SALT_HIGH_TEMP_LOW_mean, '-y','DisplayName', 'Winter SALT HIGH TEMP LOW', 'LineWidth',2)

temp_Winter_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(temp_Winter_SALT_LOW_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Winter_SALT_LOW_TEMP_HIGH_mean, 'DisplayName', 'Winter SALT LOW TEMP HIGH', 'LineWidth',2)

temp_Winter_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(temp_Winter_SALT_LOW_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Winter_SALT_LOW_TEMP_LOW_mean, 'DisplayName', 'Winter SALT LOW TEMP LOW', 'LineWidth',2)

temp_Annual_CTRL_mean = squeeze(mean(mean(temp_Annual_CTRL(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Annual_CTRL_mean, 'DisplayName', 'Annual CTRL', 'LineWidth',2)

temp_Winter_CTRL_mean = squeeze(mean(mean(temp_Winter_CTRL(:,38:92,2,:),2),1));
plot(ocean_time_days,temp_Winter_CTRL_mean, 'DisplayName', 'Winter CTRL', 'LineWidth',2)

hold off



%plotting time series salinity, mean value sea floor over 100-250km
subplot(3,2,3);

salt_Annual_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(salt_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Annual_SALT_HIGH_TEMP_HIGH_mean, '-k', 'DisplayName', 'Annual SALT HIGH TEMP HIGH', 'LineWidth',2)

xlim([0 365])
title('Salinity')
xlabel('days')
ylabel('Salinity')
grid on
hold on 


salt_Annual_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(salt_Annual_SALT_HIGH_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Annual_SALT_HIGH_TEMP_LOW_mean, '-r', 'DisplayName', 'Annual SALT HIGH TEMP LOW', 'LineWidth',2)

salt_Annual_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(salt_Annual_SALT_LOW_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Annual_SALT_LOW_TEMP_HIGH_mean,'-g', 'DisplayName', 'Annual SALT LOW TEMP HIGH', 'LineWidth',2)

salt_Annual_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(salt_Annual_SALT_LOW_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Annual_SALT_LOW_TEMP_LOW_mean,'-c', 'DisplayName', 'Annual SALT LOW TEMP LOW', 'LineWidth',2)


salt_Winter_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(salt_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Winter_SALT_HIGH_TEMP_HIGH_mean, '-m','DisplayName', 'Winter SALT HIGH TEMP HIGH', 'LineWidth',2)

salt_Winter_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(salt_Winter_SALT_HIGH_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Winter_SALT_HIGH_TEMP_LOW_mean, '-y','DisplayName', 'Winter SALT HIGH TEMP LOW', 'LineWidth',2)

salt_Winter_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(salt_Winter_SALT_LOW_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Winter_SALT_LOW_TEMP_HIGH_mean, 'DisplayName', 'Winter SALT LOW TEMP HIGH', 'LineWidth',2)

salt_Winter_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(salt_Winter_SALT_LOW_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Winter_SALT_LOW_TEMP_LOW_mean, 'DisplayName', 'Winter SALT LOW TEMP LOW', 'LineWidth',2)

salt_Annual_CTRL_mean = squeeze(mean(mean(salt_Annual_CTRL(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Annual_CTRL_mean, 'DisplayName', 'Annual CTRL', 'LineWidth',2)

salt_Winter_CTRL_mean = squeeze(mean(mean(salt_Winter_CTRL(:,38:92,2,:),2),1));
plot(ocean_time_days,salt_Winter_CTRL_mean, 'DisplayName', 'Winter CTRL', 'LineWidth',2)

hold off


%plotting time series density, mean value sea floor over 100-250km
subplot(3,2,5);

density_Annual_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(density_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Annual_SALT_HIGH_TEMP_HIGH_mean, '-k', 'DisplayName', 'Annual SALT HIGH TEMP HIGH', 'LineWidth',2)

xlim([0 365])
ylim([1027 1031])
title('Density')
xlabel('days')
ylabel('Density (kg/m^3)')
grid on
hold on 

density_Annual_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(density_Annual_SALT_HIGH_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Annual_SALT_HIGH_TEMP_LOW_mean, '-r', 'DisplayName', 'Annual SALT HIGH TEMP LOW', 'LineWidth',2)

density_Annual_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(density_Annual_SALT_LOW_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Annual_SALT_LOW_TEMP_HIGH_mean,'-g', 'DisplayName', 'Annual SALT LOW TEMP HIGH', 'LineWidth',2)

density_Annual_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(density_Annual_SALT_LOW_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Annual_SALT_LOW_TEMP_LOW_mean,'-c', 'DisplayName', 'Annual SALT LOW TEMP LOW', 'LineWidth',2)


density_Winter_SALT_HIGH_TEMP_HIGH_mean = squeeze(mean(mean(density_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Winter_SALT_HIGH_TEMP_HIGH_mean, '-m','DisplayName', 'Winter SALT HIGH TEMP HIGH', 'LineWidth',2)

density_Winter_SALT_HIGH_TEMP_LOW_mean = squeeze(mean(mean(density_Winter_SALT_HIGH_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Winter_SALT_HIGH_TEMP_LOW_mean, '-y','DisplayName', 'Winter SALT HIGH TEMP LOW', 'LineWidth',2)

density_Winter_SALT_LOW_TEMP_HIGH_mean = squeeze(mean(mean(density_Winter_SALT_LOW_TEMP_HIGH(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Winter_SALT_LOW_TEMP_HIGH_mean, 'DisplayName', 'Winter SALT LOW TEMP HIGH', 'LineWidth',2)

density_Winter_SALT_LOW_TEMP_LOW_mean = squeeze(mean(mean(density_Winter_SALT_LOW_TEMP_LOW(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Winter_SALT_LOW_TEMP_LOW_mean, 'DisplayName', 'Winter SALT LOW TEMP LOW', 'LineWidth',2)

density_Annual_CTRL_mean = squeeze(mean(mean(density_Annual_CTRL(:,38:92,12,:),2),1));
plot(ocean_time_days,density_Annual_CTRL_mean, 'DisplayName', 'Annual CTRL', 'LineWidth',2)

density_Winter_CTRL_mean = squeeze(mean(mean(density_Winter_CTRL(:,38:92,2,:),2),1));
plot(ocean_time_days,density_Winter_CTRL_mean, 'DisplayName', 'Winter CTRL', 'LineWidth',2)

hold off

%lgd = legend;
%lgd.FontSize = 10;
%lgd.Title.String = 'Model Run';
%lgd.Location = 'southoutside';






%plotting time series temperature, mean value surface over 100-250km
%difference from control
subplot(3,2,2);

temp_Annual_SALT_HIGH_TEMP_HIGH_mean_diff = minus(temp_Annual_SALT_HIGH_TEMP_HIGH_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Annual_SALT_HIGH_TEMP_HIGH_mean_diff, '-k','DisplayName', 'Annual SALT HIGH TEMP HIGH', 'LineWidth',2)

xlim([0 365])
title('Temperature - difference from CTRL')
xlabel('days')
ylabel('Temperature (degrees C)')
grid on
hold on 


temp_Annual_SALT_HIGH_TEMP_LOW_mean_diff = minus(temp_Annual_SALT_HIGH_TEMP_LOW_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Annual_SALT_HIGH_TEMP_LOW_mean_diff, '-r','DisplayName', 'Annual SALT HIGH TEMP LOW', 'LineWidth',2)

temp_Annual_SALT_LOW_TEMP_HIGH_mean_diff = minus(temp_Annual_SALT_LOW_TEMP_HIGH_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Annual_SALT_LOW_TEMP_HIGH_mean_diff, '-g','DisplayName', 'Annual SALT LOW TEMP HIGH', 'LineWidth',2)

temp_Annual_SALT_LOW_TEMP_LOW_mean_diff = minus(temp_Annual_SALT_LOW_TEMP_LOW_mean,temp_Annual_CTRL_mean);
plot(ocean_time_days,temp_Annual_SALT_LOW_TEMP_LOW_mean_diff, '-c','DisplayName', 'Annual SALT LOW TEMP LOW', 'LineWidth',2)




temp_Winter_SALT_HIGH_TEMP_HIGH_mean_diff = minus(temp_Winter_SALT_HIGH_TEMP_HIGH_mean,temp_Winter_CTRL_mean);
plot(ocean_time_days,temp_Winter_SALT_HIGH_TEMP_HIGH_mean_diff, '-m','DisplayName', 'Winter SALT HIGH TEMP HIGH', 'LineWidth',2)

temp_Winter_SALT_HIGH_TEMP_LOW_mean_diff = minus(temp_Winter_SALT_HIGH_TEMP_LOW_mean,temp_Winter_CTRL_mean);
plot(ocean_time_days,temp_Winter_SALT_HIGH_TEMP_LOW_mean_diff, '-y','DisplayName', 'Winter SALT HIGH TEMP LOW', 'LineWidth',2)

temp_Winter_SALT_LOW_TEMP_HIGH_mean_diff = minus(temp_Winter_SALT_LOW_TEMP_HIGH_mean,temp_Winter_CTRL_mean);
plot(ocean_time_days,temp_Winter_SALT_LOW_TEMP_HIGH_mean_diff, 'DisplayName', 'Winter SALT LOW TEMP HIGH', 'LineWidth',2)

temp_Winter_SALT_LOW_TEMP_LOW_mean_diff = minus(temp_Winter_SALT_HIGH_TEMP_HIGH_mean,temp_Winter_CTRL_mean);
plot(ocean_time_days,temp_Winter_SALT_LOW_TEMP_LOW_mean_diff, 'DisplayName', 'Winter SALT LOW TEMP LOW', 'LineWidth',2)


hold off




%plotting time series salinity, mean value sea floor over 100-250km
%difference from control
subplot(3,2,4);

salt_Annual_SALT_HIGH_TEMP_HIGH_mean_diff = minus(salt_Annual_SALT_HIGH_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Annual_SALT_HIGH_TEMP_HIGH_mean_diff, '-k','DisplayName', 'Annual SALT HIGH TEMP HIGH', 'LineWidth',2)

xlim([0 365])
title('Salinity - difference from CTRL')
xlabel('days')
ylabel('Salinity')
grid on
hold on 

salt_Annual_SALT_HIGH_TEMP_LOW_mean_diff = minus(salt_Annual_SALT_HIGH_TEMP_LOW_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Annual_SALT_HIGH_TEMP_LOW_mean_diff, '-r','DisplayName', 'Annual SALT HIGH TEMP LOW', 'LineWidth',2)

salt_Annual_SALT_LOW_TEMP_HIGH_mean_diff = minus(salt_Annual_SALT_LOW_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Annual_SALT_LOW_TEMP_HIGH_mean_diff, '-g','DisplayName', 'Annual SALT LOW TEMP HIGH', 'LineWidth',2)

salt_Annual_SALT_LOW_TEMP_LOW_mean_diff = minus(salt_Annual_SALT_HIGH_TEMP_HIGH_mean,salt_Annual_CTRL_mean);
plot(ocean_time_days,salt_Annual_SALT_LOW_TEMP_LOW_mean_diff, '-c','DisplayName', 'Annual SALT LOW TEMP LOW', 'LineWidth',2)




salt_Winter_SALT_HIGH_TEMP_HIGH_mean_diff = minus(salt_Winter_SALT_HIGH_TEMP_HIGH_mean,salt_Winter_CTRL_mean);
plot(ocean_time_days,salt_Winter_SALT_HIGH_TEMP_HIGH_mean_diff, '-m','DisplayName', 'Winter SALT HIGH TEMP HIGH', 'LineWidth',2)

salt_Winter_SALT_HIGH_TEMP_LOW_mean_diff = minus(salt_Winter_SALT_HIGH_TEMP_LOW_mean,salt_Winter_CTRL_mean);
plot(ocean_time_days,salt_Winter_SALT_HIGH_TEMP_LOW_mean_diff, '-y','DisplayName', 'Winter SALT HIGH TEMP LOW', 'LineWidth',2)

salt_Winter_SALT_LOW_TEMP_HIGH_mean_diff = minus(salt_Winter_SALT_LOW_TEMP_HIGH_mean,salt_Winter_CTRL_mean);
plot(ocean_time_days,salt_Winter_SALT_LOW_TEMP_HIGH_mean_diff, 'DisplayName', 'Winter SALT LOW TEMP HIGH', 'LineWidth',2)

salt_Winter_SALT_LOW_TEMP_LOW_mean_diff = minus(salt_Winter_SALT_LOW_TEMP_LOW_mean,salt_Winter_CTRL_mean);
plot(ocean_time_days,salt_Winter_SALT_LOW_TEMP_LOW_mean_diff, 'DisplayName', 'Winter SALT LOW TEMP LOW', 'LineWidth',2)

hold off





%plotting time series density, mean value sea floor over 100-250km
%difference from control
subplot(3,2,6);

density_Annual_SALT_HIGH_TEMP_HIGH_mean_diff = minus(density_Annual_SALT_HIGH_TEMP_HIGH_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Annual_SALT_HIGH_TEMP_HIGH_mean_diff, '-k','DisplayName', 'Annual SALT HIGH TEMP HIGH', 'LineWidth',2)

xlim([0 365])
title('Density - difference from CTRL')
xlabel('days')
ylabel('Density (kg/m^3)')
grid on
hold on 

density_Annual_SALT_HIGH_TEMP_LOW_mean_diff = minus(density_Annual_SALT_HIGH_TEMP_LOW_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Annual_SALT_HIGH_TEMP_LOW_mean_diff, '-r','DisplayName', 'Annual SALT HIGH TEMP LOW', 'LineWidth',2)

density_Annual_SALT_LOW_TEMP_HIGH_mean_diff = minus(density_Annual_SALT_LOW_TEMP_HIGH_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Annual_SALT_LOW_TEMP_HIGH_mean_diff, '-g','DisplayName', 'Annual SALT LOW TEMP HIGH', 'LineWidth',2)

density_Annual_SALT_LOW_TEMP_LOW_mean_diff = minus(density_Annual_SALT_LOW_TEMP_LOW_mean,density_Annual_CTRL_mean);
plot(ocean_time_days,density_Annual_SALT_LOW_TEMP_LOW_mean_diff, '-c','DisplayName', 'Annual SALT LOW TEMP LOW', 'LineWidth',2)




density_Winter_SALT_HIGH_TEMP_HIGH_mean_diff = minus(density_Winter_SALT_HIGH_TEMP_HIGH_mean,density_Winter_CTRL_mean);
plot(ocean_time_days,density_Winter_SALT_HIGH_TEMP_HIGH_mean_diff, '-m','DisplayName', 'Winter SALT HIGH TEMP HIGH', 'LineWidth',2)

density_Winter_SALT_HIGH_TEMP_LOW_mean_diff = minus(density_Winter_SALT_HIGH_TEMP_LOW_mean,density_Winter_CTRL_mean);
plot(ocean_time_days,density_Winter_SALT_HIGH_TEMP_LOW_mean_diff, '-y','DisplayName', 'Winter SALT HIGH TEMP LOW', 'LineWidth',2)

density_Winter_SALT_LOW_TEMP_HIGH_mean_diff = minus(density_Winter_SALT_LOW_TEMP_HIGH_mean,density_Winter_CTRL_mean);
plot(ocean_time_days,density_Winter_SALT_LOW_TEMP_HIGH_mean_diff, 'DisplayName', 'Winter SALT LOW TEMP HIGH', 'LineWidth',2)

density_Winter_SALT_LOW_TEMP_LOW_mean_diff = minus(density_Winter_SALT_LOW_TEMP_LOW_mean,density_Winter_CTRL_mean);
plot(ocean_time_days,density_Winter_SALT_LOW_TEMP_LOW_mean_diff, 'DisplayName', 'Winter SALT LOW TEMP LOW', 'LineWidth',2)

hold off

lgd = legend;
lgd.FontSize = 10;
lgd.Title.String = 'Model Run';
lgd.Location = 'southoutside';


%title when depth is 2 (aka 1 above sea floor)
% figured this out by running this code:
%mean(mean(depth(:,39:92,2,:),2),1)
sgtitle('Bottom Water (~472.22m below surface)')























%now lets try to plot just the singular mean value for the last 30 days for temperature 

temp_Annual_CTRL_mean_last = (mean(mean(mean(temp_Annual_CTRL(:,38:92,2,336:366),4),2),1));
temp_Annual_CTRL_mean_last = round(temp_Annual_CTRL_mean_last, 2);
temp_Annual_CTRL_mean_last_surface = (mean(mean(mean(temp_Annual_CTRL(:,38:92,12,336:366),4),2),1));
temp_Annual_CTRL_mean_last_surface = round(temp_Annual_CTRL_mean_last_surface, 2);

temp_Annual_SALT_HIGH_TEMP_HIGH_mean_last = (mean(mean(mean(temp_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,2,336:366),4),2),1));
temp_Annual_SALT_HIGH_TEMP_HIGH_mean_last = round(temp_Annual_SALT_HIGH_TEMP_HIGH_mean_last, 2);
temp_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface = (mean(mean(mean(temp_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,12,336:366),4),2),1));
temp_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface = round(temp_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface, 2);

temp_Annual_SALT_HIGH_TEMP_LOW_mean_last = (mean(mean(mean(temp_Annual_SALT_HIGH_TEMP_LOW(:,38:92,2,336:366),4),2),1));
temp_Annual_SALT_HIGH_TEMP_LOW_mean_last = round(temp_Annual_SALT_HIGH_TEMP_LOW_mean_last, 2);
temp_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface = (mean(mean(mean(temp_Annual_SALT_HIGH_TEMP_LOW(:,38:92,12,336:366),4),2),1));
temp_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface = round(temp_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface, 2);

temp_Annual_SALT_LOW_TEMP_HIGH_mean_last = (mean(mean(mean(temp_Annual_SALT_LOW_TEMP_HIGH(:,38:92,2,336:366),4),2),1));
temp_Annual_SALT_LOW_TEMP_HIGH_mean_last = round(temp_Annual_SALT_LOW_TEMP_HIGH_mean_last, 2);
temp_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface = (mean(mean(mean(temp_Annual_SALT_LOW_TEMP_HIGH(:,38:92,12,336:366),4),2),1));
temp_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface = round(temp_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface, 2);

temp_Annual_SALT_LOW_TEMP_LOW_mean_last = (mean(mean(mean(temp_Annual_SALT_LOW_TEMP_LOW(:,38:92,2,336:366),4),2),1));
temp_Annual_SALT_LOW_TEMP_LOW_mean_last = round(temp_Annual_SALT_LOW_TEMP_LOW_mean_last, 2);
temp_Annual_SALT_LOW_TEMP_LOW_mean_last_surface = (mean(mean(mean(temp_Annual_SALT_LOW_TEMP_LOW(:,38:92,12,336:366),4),2),1));
temp_Annual_SALT_LOW_TEMP_LOW_mean_last_surface = round(temp_Annual_SALT_LOW_TEMP_LOW_mean_last_surface, 2)




temp_Winter_CTRL_mean_last = (mean(mean(mean(temp_Winter_CTRL(:,38:92,2,336:366),4),2),1));
temp_Winter_CTRL_mean_last = round(temp_Winter_CTRL_mean_last, 2);
temp_Winter_CTRL_mean_last_surface = (mean(mean(mean(temp_Winter_CTRL(:,38:92,12,336:366),4),2),1));
temp_Winter_CTRL_mean_last_surface = round(temp_Winter_CTRL_mean_last_surface, 2);

temp_Winter_SALT_HIGH_TEMP_HIGH_mean_last = (mean(mean(mean(temp_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,2,336:366),4),2),1));
temp_Winter_SALT_HIGH_TEMP_HIGH_mean_last = round(temp_Winter_SALT_HIGH_TEMP_HIGH_mean_last, 2);
temp_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface = (mean(mean(mean(temp_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,12,336:366),4),2),1));
temp_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface = round(temp_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface, 2);

temp_Winter_SALT_HIGH_TEMP_LOW_mean_last = (mean(mean(mean(temp_Winter_SALT_HIGH_TEMP_LOW(:,38:92,2,336:366),4),2),1));
temp_Winter_SALT_HIGH_TEMP_LOW_mean_last = round(temp_Winter_SALT_HIGH_TEMP_LOW_mean_last, 2);
temp_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface = (mean(mean(mean(temp_Winter_SALT_HIGH_TEMP_LOW(:,38:92,12,336:366),4),2),1));
temp_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface = round(temp_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface, 2);

temp_Winter_SALT_LOW_TEMP_HIGH_mean_last = (mean(mean(mean(temp_Winter_SALT_LOW_TEMP_HIGH(:,38:92,2,336:366),4),2),1));
temp_Winter_SALT_LOW_TEMP_HIGH_mean_last = round(temp_Winter_SALT_LOW_TEMP_HIGH_mean_last, 2);
temp_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface = (mean(mean(mean(temp_Winter_SALT_LOW_TEMP_HIGH(:,38:92,12,336:366),4),2),1));
temp_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface = round(temp_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface, 2);

temp_Winter_SALT_LOW_TEMP_LOW_mean_last = (mean(mean(mean(temp_Winter_SALT_LOW_TEMP_LOW(:,38:92,2,336:366),4),2),1));
temp_Winter_SALT_LOW_TEMP_LOW_mean_last = round(temp_Winter_SALT_LOW_TEMP_LOW_mean_last, 2);
temp_Winter_SALT_LOW_TEMP_LOW_mean_last_surface = (mean(mean(mean(temp_Winter_SALT_LOW_TEMP_LOW(:,38:92,12,336:366),4),2),1));
temp_Winter_SALT_LOW_TEMP_LOW_mean_last_surface = round(temp_Winter_SALT_LOW_TEMP_LOW_mean_last_surface, 2)




%now lets try to plot just the singular mean value for the last 30 days for salinity 

salt_Annual_CTRL_mean_last = (mean(mean(mean(salt_Annual_CTRL(:,38:92,2,336:366),4),2),1));
salt_Annual_CTRL_mean_last = round(salt_Annual_CTRL_mean_last, 2);
salt_Annual_CTRL_mean_last_surface = (mean(mean(mean(salt_Annual_CTRL(:,38:92,12,336:366),4),2),1));
salt_Annual_CTRL_mean_last_surface = round(salt_Annual_CTRL_mean_last_surface, 2);

salt_Annual_SALT_HIGH_TEMP_HIGH_mean_last = (mean(mean(mean(salt_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,2,336:366),4),2),1));
salt_Annual_SALT_HIGH_TEMP_HIGH_mean_last = round(salt_Annual_SALT_HIGH_TEMP_HIGH_mean_last, 2);
salt_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface = (mean(mean(mean(salt_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,12,336:366),4),2),1));
salt_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface = round(salt_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface, 2);

salt_Annual_SALT_HIGH_TEMP_LOW_mean_last = (mean(mean(mean(salt_Annual_SALT_HIGH_TEMP_LOW(:,38:92,2,336:366),4),2),1));
salt_Annual_SALT_HIGH_TEMP_LOW_mean_last = round(salt_Annual_SALT_HIGH_TEMP_LOW_mean_last, 2);
salt_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface = (mean(mean(mean(salt_Annual_SALT_HIGH_TEMP_LOW(:,38:92,12,336:366),4),2),1));
salt_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface = round(salt_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface, 2);

salt_Annual_SALT_LOW_TEMP_HIGH_mean_last = (mean(mean(mean(salt_Annual_SALT_LOW_TEMP_HIGH(:,38:92,2,336:366),4),2),1));
salt_Annual_SALT_LOW_TEMP_HIGH_mean_last = round(salt_Annual_SALT_LOW_TEMP_HIGH_mean_last, 2);
salt_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface = (mean(mean(mean(salt_Annual_SALT_LOW_TEMP_HIGH(:,38:92,12,336:366),4),2),1));
salt_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface = round(salt_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface, 2);

salt_Annual_SALT_LOW_TEMP_LOW_mean_last = (mean(mean(mean(salt_Annual_SALT_LOW_TEMP_LOW(:,38:92,2,336:366),4),2),1));
salt_Annual_SALT_LOW_TEMP_LOW_mean_last = round(salt_Annual_SALT_LOW_TEMP_LOW_mean_last, 2);
salt_Annual_SALT_LOW_TEMP_LOW_mean_last_surface = (mean(mean(mean(salt_Annual_SALT_LOW_TEMP_LOW(:,38:92,12,336:366),4),2),1));
salt_Annual_SALT_LOW_TEMP_LOW_mean_last_surface = round(salt_Annual_SALT_LOW_TEMP_LOW_mean_last_surface, 2);




salt_Winter_CTRL_mean_last = (mean(mean(mean(salt_Winter_CTRL(:,38:92,2,336:366),4),2),1));
salt_Winter_CTRL_mean_last = round(salt_Winter_CTRL_mean_last, 2);
salt_Winter_CTRL_mean_last_surface = (mean(mean(mean(salt_Winter_CTRL(:,38:92,12,336:366),4),2),1));
salt_Winter_CTRL_mean_last_surface = round(salt_Winter_CTRL_mean_last_surface, 2);

salt_Winter_SALT_HIGH_TEMP_HIGH_mean_last = (mean(mean(mean(salt_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,2,336:366),4),2),1));
salt_Winter_SALT_HIGH_TEMP_HIGH_mean_last = round(salt_Winter_SALT_HIGH_TEMP_HIGH_mean_last, 2);
salt_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface = (mean(mean(mean(salt_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,12,336:366),4),2),1));
salt_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface = round(salt_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface, 2);

salt_Winter_SALT_HIGH_TEMP_LOW_mean_last = (mean(mean(mean(salt_Winter_SALT_HIGH_TEMP_LOW(:,38:92,2,336:366),4),2),1));
salt_Winter_SALT_HIGH_TEMP_LOW_mean_last = round(salt_Winter_SALT_HIGH_TEMP_LOW_mean_last, 2);
salt_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface = (mean(mean(mean(salt_Winter_SALT_HIGH_TEMP_LOW(:,38:92,12,336:366),4),2),1));
salt_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface = round(salt_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface, 2);

salt_Winter_SALT_LOW_TEMP_HIGH_mean_last = (mean(mean(mean(salt_Winter_SALT_LOW_TEMP_HIGH(:,38:92,2,336:366),4),2),1));
salt_Winter_SALT_LOW_TEMP_HIGH_mean_last = round(salt_Winter_SALT_LOW_TEMP_HIGH_mean_last, 2);
salt_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface = (mean(mean(mean(salt_Winter_SALT_LOW_TEMP_HIGH(:,38:92,12,336:366),4),2),1));
salt_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface = round(salt_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface, 2);

salt_Winter_SALT_LOW_TEMP_LOW_mean_last = (mean(mean(mean(salt_Winter_SALT_LOW_TEMP_LOW(:,38:92,2,336:366),4),2),1));
salt_Winter_SALT_LOW_TEMP_LOW_mean_last = round(salt_Winter_SALT_LOW_TEMP_LOW_mean_last, 2);
salt_Winter_SALT_LOW_TEMP_LOW_mean_last_surface = (mean(mean(mean(salt_Winter_SALT_LOW_TEMP_LOW(:,38:92,12,336:366),4),2),1));
salt_Winter_SALT_LOW_TEMP_LOW_mean_last_surface = round(salt_Winter_SALT_LOW_TEMP_LOW_mean_last_surface, 2);




%now lets try to plot just the singular mean value for the last 30 days for density 

density_Annual_CTRL_mean_last = (mean(mean(mean(density_Annual_CTRL(:,38:92,2,336:366),4),2),1));
density_Annual_CTRL_mean_last = density_Annual_CTRL_mean_last - 1000;
density_Annual_CTRL_mean_last = round(density_Annual_CTRL_mean_last,2);
density_Annual_CTRL_mean_last_surface = (mean(mean(mean(density_Annual_CTRL(:,38:92,12,336:366),4),2),1));
density_Annual_CTRL_mean_last_surface = density_Annual_CTRL_mean_last_surface - 1000;
density_Annual_CTRL_mean_last_surface = round(density_Annual_CTRL_mean_last_surface, 2);

density_Annual_SALT_HIGH_TEMP_HIGH_mean_last = (mean(mean(mean(density_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,2,336:366),4),2),1));
density_Annual_SALT_HIGH_TEMP_HIGH_mean_last = density_Annual_SALT_HIGH_TEMP_HIGH_mean_last - 1000;
density_Annual_SALT_HIGH_TEMP_HIGH_mean_last = round(density_Annual_SALT_HIGH_TEMP_HIGH_mean_last, 2);
density_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface = (mean(mean(mean(density_Annual_SALT_HIGH_TEMP_HIGH(:,38:92,12,336:366),4),2),1));
density_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface = density_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface - 1000;
density_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface = round(density_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface, 2);

density_Annual_SALT_HIGH_TEMP_LOW_mean_last = (mean(mean(mean(density_Annual_SALT_HIGH_TEMP_LOW(:,38:92,2,336:366),4),2),1));
density_Annual_SALT_HIGH_TEMP_LOW_mean_last = density_Annual_SALT_HIGH_TEMP_LOW_mean_last - 1000;
density_Annual_SALT_HIGH_TEMP_LOW_mean_last = round(density_Annual_SALT_HIGH_TEMP_LOW_mean_last, 2);
density_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface = (mean(mean(mean(density_Annual_SALT_HIGH_TEMP_LOW(:,38:92,12,336:366),4),2),1));
density_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface = density_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface - 1000;
density_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface = round(density_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface, 2);

density_Annual_SALT_LOW_TEMP_HIGH_mean_last = (mean(mean(mean(density_Annual_SALT_LOW_TEMP_HIGH(:,38:92,2,336:366),4),2),1));
density_Annual_SALT_LOW_TEMP_HIGH_mean_last = density_Annual_SALT_LOW_TEMP_HIGH_mean_last - 1000;
density_Annual_SALT_LOW_TEMP_HIGH_mean_last = round(density_Annual_SALT_LOW_TEMP_HIGH_mean_last, 2);
density_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface = (mean(mean(mean(density_Annual_SALT_LOW_TEMP_HIGH(:,38:92,12,336:366),4),2),1));
density_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface = density_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface - 1000;
density_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface = round(density_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface, 2);

density_Annual_SALT_LOW_TEMP_LOW_mean_last = (mean(mean(mean(density_Annual_SALT_LOW_TEMP_LOW(:,38:92,2,336:366),4),2),1));
density_Annual_SALT_LOW_TEMP_LOW_mean_last = density_Annual_SALT_LOW_TEMP_LOW_mean_last - 1000;
density_Annual_SALT_LOW_TEMP_LOW_mean_last = round(density_Annual_SALT_LOW_TEMP_LOW_mean_last, 2);
density_Annual_SALT_LOW_TEMP_LOW_mean_last_surface = (mean(mean(mean(density_Annual_SALT_LOW_TEMP_LOW(:,38:92,12,336:366),4),2),1));
density_Annual_SALT_LOW_TEMP_LOW_mean_last_surface = density_Annual_SALT_LOW_TEMP_LOW_mean_last_surface - 1000;
density_Annual_SALT_LOW_TEMP_LOW_mean_last_surface = round(density_Annual_SALT_LOW_TEMP_LOW_mean_last_surface, 2);




density_Winter_CTRL_mean_last = (mean(mean(mean(density_Winter_CTRL(:,38:92,2,336:366),4),2),1));
density_Winter_CTRL_mean_last = density_Winter_CTRL_mean_last - 1000;
density_Winter_CTRL_mean_last = round(density_Winter_CTRL_mean_last,2);
density_Winter_CTRL_mean_last_surface = (mean(mean(mean(density_Winter_CTRL(:,38:92,12,336:366),4),2),1));
density_Winter_CTRL_mean_last_surface = density_Winter_CTRL_mean_last_surface - 1000;
density_Winter_CTRL_mean_last_surface = round(density_Winter_CTRL_mean_last_surface, 2);

density_Winter_SALT_HIGH_TEMP_HIGH_mean_last = (mean(mean(mean(density_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,2,336:366),4),2),1));
density_Winter_SALT_HIGH_TEMP_HIGH_mean_last = density_Winter_SALT_HIGH_TEMP_HIGH_mean_last - 1000;
density_Winter_SALT_HIGH_TEMP_HIGH_mean_last = round(density_Winter_SALT_HIGH_TEMP_HIGH_mean_last, 2);
density_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface = (mean(mean(mean(density_Winter_SALT_HIGH_TEMP_HIGH(:,38:92,12,336:366),4),2),1));
density_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface = density_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface - 1000;
density_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface = round(density_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface, 2);

density_Winter_SALT_HIGH_TEMP_LOW_mean_last = (mean(mean(mean(density_Winter_SALT_HIGH_TEMP_LOW(:,38:92,2,336:366),4),2),1));
density_Winter_SALT_HIGH_TEMP_LOW_mean_last = density_Winter_SALT_HIGH_TEMP_LOW_mean_last - 1000; 
density_Winter_SALT_HIGH_TEMP_LOW_mean_last = round(density_Winter_SALT_HIGH_TEMP_LOW_mean_last, 2);
density_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface = (mean(mean(mean(density_Winter_SALT_HIGH_TEMP_LOW(:,38:92,12,336:366),4),2),1));
density_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface = density_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface - 1000;
density_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface = round(density_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface, 2);

density_Winter_SALT_LOW_TEMP_HIGH_mean_last = (mean(mean(mean(density_Winter_SALT_LOW_TEMP_HIGH(:,38:92,2,336:366),4),2),1));
density_Winter_SALT_LOW_TEMP_HIGH_mean_last = density_Winter_SALT_LOW_TEMP_HIGH_mean_last - 1000;
density_Winter_SALT_LOW_TEMP_HIGH_mean_last = round(density_Winter_SALT_LOW_TEMP_HIGH_mean_last, 2);
density_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface = (mean(mean(mean(density_Winter_SALT_LOW_TEMP_HIGH(:,38:92,12,336:366),4),2),1));
density_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface = density_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface - 1000;
density_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface = round(density_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface, 2);

density_Winter_SALT_LOW_TEMP_LOW_mean_last = (mean(mean(mean(density_Winter_SALT_LOW_TEMP_LOW(:,38:92,2,336:366),4),2),1));
density_Winter_SALT_LOW_TEMP_LOW_mean_last = density_Winter_SALT_LOW_TEMP_LOW_mean_last -1000;
density_Winter_SALT_LOW_TEMP_LOW_mean_last = round(density_Winter_SALT_LOW_TEMP_LOW_mean_last, 2);
density_Winter_SALT_LOW_TEMP_LOW_mean_last_surface = (mean(mean(mean(density_Winter_SALT_LOW_TEMP_LOW(:,38:92,12,336:366),4),2),1));
density_Winter_SALT_LOW_TEMP_LOW_mean_last_surface = density_Winter_SALT_LOW_TEMP_LOW_mean_last_surface - 1000;
density_Winter_SALT_LOW_TEMP_LOW_mean_last_surface = round(density_Winter_SALT_LOW_TEMP_LOW_mean_last_surface, 2);



subplot(1,3,1);
%set up the x and y vectors
X_temp = categorical({'Annual CTRL', 'Annual SALT HIGH TEMP HIGH', 'Annual SALT HIGH TEMP LOW', 'Annual SALT LOW TEMP HIGH', 'Annual SALT LOW TEMP LOW', 'Winter CTRL', 'Winter SALT HIGH TEMP HIGH', 'Winter SALT HIGH TEMP LOW', 'Winter SALT LOW TEMP HIGH', 'Winter SALT LOW TEMP LOW'});
X_temp = reordercats(X_temp, {'Annual CTRL', 'Annual SALT HIGH TEMP HIGH', 'Annual SALT HIGH TEMP LOW', 'Annual SALT LOW TEMP HIGH', 'Annual SALT LOW TEMP LOW', 'Winter CTRL', 'Winter SALT HIGH TEMP HIGH', 'Winter SALT HIGH TEMP LOW', 'Winter SALT LOW TEMP HIGH', 'Winter SALT LOW TEMP LOW'})
Y_temp = [temp_Annual_CTRL_mean_last temp_Annual_CTRL_mean_last_surface; temp_Annual_SALT_HIGH_TEMP_HIGH_mean_last temp_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface; temp_Annual_SALT_HIGH_TEMP_LOW_mean_last temp_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface; temp_Annual_SALT_LOW_TEMP_HIGH_mean_last temp_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface; temp_Annual_SALT_LOW_TEMP_LOW_mean_last temp_Annual_SALT_LOW_TEMP_LOW_mean_last_surface;temp_Winter_CTRL_mean_last temp_Winter_CTRL_mean_last_surface; temp_Winter_SALT_HIGH_TEMP_HIGH_mean_last temp_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface; temp_Winter_SALT_HIGH_TEMP_LOW_mean_last temp_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface; temp_Winter_SALT_LOW_TEMP_HIGH_mean_last temp_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface; temp_Winter_SALT_LOW_TEMP_LOW_mean_last temp_Winter_SALT_LOW_TEMP_LOW_mean_last_surface];


b = bar(X_temp, Y_temp)
grid on;
lgd = legend('sea floor', 'surface');
lgd.FontSize = 14;
lgd.Title.String = 'Depth';
lgd.Location = 'northeast';
ylim([-2.5 1.5])
%b.FaceColor = 'flat'
%b.CData(1,:) = [1 0 0] %this is the RBG triplet value for red
%this puts the actual values on the tops of the bars
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','top')
xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center','VerticalAlignment','top')
% add titles
title('Average temperature over last month model ran', 'Color', 'k', 'FontWeight', 'bold')
xlabel('Model run')
ylabel('Temperature (degrees C)')




subplot(1,3,2);
%set up the x and y vectors
X_salt = categorical({'Annual CTRL', 'Annual SALT HIGH TEMP HIGH', 'Annual SALT HIGH TEMP LOW', 'Annual SALT LOW TEMP HIGH', 'Annual SALT LOW TEMP LOW', 'Winter CTRL', 'Winter SALT HIGH TEMP HIGH', 'Winter SALT HIGH TEMP LOW', 'Winter SALT LOW TEMP HIGH', 'Winter SALT LOW TEMP LOW'});
X_salt = reordercats(X_salt, {'Annual CTRL', 'Annual SALT HIGH TEMP HIGH', 'Annual SALT HIGH TEMP LOW', 'Annual SALT LOW TEMP HIGH', 'Annual SALT LOW TEMP LOW', 'Winter CTRL', 'Winter SALT HIGH TEMP HIGH', 'Winter SALT HIGH TEMP LOW', 'Winter SALT LOW TEMP HIGH', 'Winter SALT LOW TEMP LOW'})
Y_salt = [salt_Annual_CTRL_mean_last salt_Annual_CTRL_mean_last_surface; salt_Annual_SALT_HIGH_TEMP_HIGH_mean_last salt_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface; salt_Annual_SALT_HIGH_TEMP_LOW_mean_last salt_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface; salt_Annual_SALT_LOW_TEMP_HIGH_mean_last salt_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface; salt_Annual_SALT_LOW_TEMP_LOW_mean_last salt_Annual_SALT_LOW_TEMP_LOW_mean_last_surface; salt_Winter_CTRL_mean_last salt_Winter_CTRL_mean_last_surface; salt_Winter_SALT_HIGH_TEMP_HIGH_mean_last salt_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface; salt_Winter_SALT_HIGH_TEMP_LOW_mean_last salt_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface; salt_Winter_SALT_LOW_TEMP_HIGH_mean_last salt_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface; salt_Winter_SALT_LOW_TEMP_LOW_mean_last salt_Winter_SALT_LOW_TEMP_LOW_mean_last_surface];
%Y = [temp_CTRL_mean_last, temp_TEMP_LOW_mean_last, temp_TEMP_HIGH_mean_last, temp_SALT_LOW_mean_last, temp_SALT_HIGH_mean_last];

b = bar(X_salt, Y_salt)
grid on;
lgd = legend('sea floor', 'surface');
lgd.FontSize = 14;
lgd.Title.String = 'Depth';
lgd.Location = 'northwest';
ylim([32 35.5])
%b.FaceColor = 'flat'
%b.CData(1,:) = [1 0 0] %this is the RBG triplet value for red
%this puts the actual values on the tops of the bars
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','bottom')
xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center','VerticalAlignment','bottom')
% add titles
title('Average salinity over last month model ran', 'Color', 'k', 'FontWeight', 'bold')
xlabel('Model run')
ylabel('Salinity')




subplot(1,3,3);
%set up the x and y vectors
X_density = categorical({'Annual CTRL', 'Annual SALT HIGH TEMP HIGH', 'Annual SALT HIGH TEMP LOW', 'Annual SALT LOW TEMP HIGH', 'Annual SALT LOW TEMP LOW', 'Winter CTRL', 'Winter SALT HIGH TEMP HIGH', 'Winter SALT HIGH TEMP LOW', 'Winter SALT LOW TEMP HIGH', 'Winter SALT LOW TEMP LOW'});
X_density = reordercats(X_density, {'Annual CTRL', 'Annual SALT HIGH TEMP HIGH', 'Annual SALT HIGH TEMP LOW', 'Annual SALT LOW TEMP HIGH', 'Annual SALT LOW TEMP LOW', 'Winter CTRL', 'Winter SALT HIGH TEMP HIGH', 'Winter SALT HIGH TEMP LOW', 'Winter SALT LOW TEMP HIGH', 'Winter SALT LOW TEMP LOW'})
Y_density = [density_Annual_CTRL_mean_last density_Annual_CTRL_mean_last_surface; density_Annual_SALT_HIGH_TEMP_HIGH_mean_last density_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface; density_Annual_SALT_HIGH_TEMP_LOW_mean_last density_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface; density_Annual_SALT_LOW_TEMP_HIGH_mean_last density_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface; density_Annual_SALT_LOW_TEMP_LOW_mean_last density_Annual_SALT_LOW_TEMP_LOW_mean_last_surface; density_Winter_CTRL_mean_last density_Winter_CTRL_mean_last_surface; density_Winter_SALT_HIGH_TEMP_HIGH_mean_last density_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface; density_Winter_SALT_HIGH_TEMP_LOW_mean_last density_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface; density_Winter_SALT_LOW_TEMP_HIGH_mean_last density_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface; density_Winter_SALT_LOW_TEMP_LOW_mean_last density_Winter_SALT_LOW_TEMP_LOW_mean_last_surface];
%Y = [temp_CTRL_mean_last, temp_TEMP_LOW_mean_last, temp_TEMP_HIGH_mean_last, temp_SALT_LOW_mean_last, temp_SALT_HIGH_mean_last];

b = bar(X_density, Y_density)
grid on;
lgd = legend('sea floor', 'surface');
lgd.FontSize = 14;
lgd.Title.String = 'Depth';
lgd.Location = 'northwest';
ylim([1027.7 1028])
%b.FaceColor = 'flat'
%b.CData(1,:) = [1 0 0] %this is the RBG triplet value for red
%this puts the actual values on the tops of the bars
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','bottom')
xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center','VerticalAlignment','bottom')
% add titles
title('Average density over last month model ran', 'Color', 'k', 'FontWeight', 'bold')
xlabel('Model run')
ylabel('Potential density (kg/m^3)')


sgtitle('Mean values over last month of model run')
%sgtitle('Mean values over last month of model run', 'FontSize', 25)


















subplot(1,3,1);
%set up the x and y vectors
X_temp = categorical({'CTRL', 'TEMP -1.5', 'TEMP -1.6', 'TEMP -1.7', 'TEMP -1.8', 'TEMP -1.9', 'SALT 34.5', 'SALT 34.6', 'SALT 34.7', 'SALT 34.9'});
X_temp = reordercats(X_temp, {'CTRL', 'TEMP -1.5', 'TEMP -1.6', 'TEMP -1.7', 'TEMP -1.8', 'TEMP -1.9', 'SALT 34.5', 'SALT 34.6', 'SALT 34.7', 'SALT 34.9'})
Y_temp = [temp_Annual_CTRL_mean_last temp_Annual_CTRL_mean_last_surface; temp_Annual_SALT_HIGH_TEMP_HIGH_mean_last temp_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface; temp_Annual_SALT_HIGH_TEMP_LOW_mean_last temp_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface; temp_Annual_SALT_LOW_TEMP_HIGH_mean_last temp_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface; temp_Annual_SALT_LOW_TEMP_LOW_mean_last temp_Annual_SALT_LOW_TEMP_LOW_mean_last_surface;temp_Winter_CTRL_mean_last temp_Winter_CTRL_mean_last_surface; temp_Winter_SALT_HIGH_TEMP_HIGH_mean_last temp_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface; temp_Winter_SALT_HIGH_TEMP_LOW_mean_last temp_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface; temp_Winter_SALT_LOW_TEMP_HIGH_mean_last temp_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface; temp_Winter_SALT_LOW_TEMP_LOW_mean_last temp_Winter_SALT_LOW_TEMP_LOW_mean_last_surface];


b = bar(X_temp, Y_temp)
grid on;
lgd = legend('sea floor', 'surface');
lgd.FontSize = 14;
lgd.Title.String = 'Depth';
lgd.Location = 'southwest';
ylim([-2 -1.5])
%b.FaceColor = 'flat'
%b.CData(1,:) = [1 0 0] %this is the RBG triplet value for red
%this puts the actual values on the tops of the bars
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','top')
xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center','VerticalAlignment','top')
% add titles
title('Average temperature over last month model ran', 'Color', 'k', 'FontWeight', 'bold')
xlabel('Model run')
ylabel('Temperature (degrees C)')




subplot(1,3,2);
%set up the x and y vectors
X_salt = categorical({'CTRL', 'TEMP -1.5', 'TEMP -1.6', 'TEMP -1.7', 'TEMP -1.8', 'TEMP -1.9', 'SALT 34.5', 'SALT 34.6', 'SALT 34.7', 'SALT 34.9'});
X_salt = reordercats(X_salt, {'CTRL', 'TEMP -1.5', 'TEMP -1.6', 'TEMP -1.7', 'TEMP -1.8', 'TEMP -1.9', 'SALT 34.5', 'SALT 34.6', 'SALT 34.7', 'SALT 34.9'})
Y_salt = [salt_Annual_CTRL_mean_last salt_Annual_CTRL_mean_last_surface; salt_Annual_SALT_HIGH_TEMP_HIGH_mean_last salt_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface; salt_Annual_SALT_HIGH_TEMP_LOW_mean_last salt_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface; salt_Annual_SALT_LOW_TEMP_HIGH_mean_last salt_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface; salt_Annual_SALT_LOW_TEMP_LOW_mean_last salt_Annual_SALT_LOW_TEMP_LOW_mean_last_surface; salt_Winter_CTRL_mean_last salt_Winter_CTRL_mean_last_surface; salt_Winter_SALT_HIGH_TEMP_HIGH_mean_last salt_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface; salt_Winter_SALT_HIGH_TEMP_LOW_mean_last salt_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface; salt_Winter_SALT_LOW_TEMP_HIGH_mean_last salt_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface; salt_Winter_SALT_LOW_TEMP_LOW_mean_last salt_Winter_SALT_LOW_TEMP_LOW_mean_last_surface];
%Y = [temp_CTRL_mean_last, temp_TEMP_LOW_mean_last, temp_TEMP_HIGH_mean_last, temp_SALT_LOW_mean_last, temp_SALT_HIGH_mean_last];

b = bar(X_salt, Y_salt)
grid on;
lgd = legend('sea floor', 'surface');
lgd.FontSize = 14;
lgd.Title.String = 'Depth';
lgd.Location = 'northwest';
ylim([34.5 34.75])
%b.FaceColor = 'flat'
%b.CData(1,:) = [1 0 0] %this is the RBG triplet value for red
%this puts the actual values on the tops of the bars
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','bottom')
xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center','VerticalAlignment','bottom')
% add titles
title('Average salinity over last month model ran', 'Color', 'k', 'FontWeight', 'bold')
xlabel('Model run')
ylabel('Salinity')




subplot(1,3,3);
%set up the x and y vectors
X_density = categorical({'CTRL', 'TEMP -1.5', 'TEMP -1.6', 'TEMP -1.7', 'TEMP -1.8', 'TEMP -1.9', 'SALT 34.5', 'SALT 34.6', 'SALT 34.7', 'SALT 34.9'});
X_density = reordercats(X_density, {'CTRL', 'TEMP -1.5', 'TEMP -1.6', 'TEMP -1.7', 'TEMP -1.8', 'TEMP -1.9', 'SALT 34.5', 'SALT 34.6', 'SALT 34.7', 'SALT 34.9'})
Y_density = [density_Annual_CTRL_mean_last density_Annual_CTRL_mean_last_surface; density_Annual_SALT_HIGH_TEMP_HIGH_mean_last density_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface; density_Annual_SALT_HIGH_TEMP_LOW_mean_last density_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface; density_Annual_SALT_LOW_TEMP_HIGH_mean_last density_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface; density_Annual_SALT_LOW_TEMP_LOW_mean_last density_Annual_SALT_LOW_TEMP_LOW_mean_last_surface; density_Winter_CTRL_mean_last density_Winter_CTRL_mean_last_surface; density_Winter_SALT_HIGH_TEMP_HIGH_mean_last density_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface; density_Winter_SALT_HIGH_TEMP_LOW_mean_last density_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface; density_Winter_SALT_LOW_TEMP_HIGH_mean_last density_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface; density_Winter_SALT_LOW_TEMP_LOW_mean_last density_Winter_SALT_LOW_TEMP_LOW_mean_last_surface];
%Y = [temp_CTRL_mean_last, temp_TEMP_LOW_mean_last, temp_TEMP_HIGH_mean_last, temp_SALT_LOW_mean_last, temp_SALT_HIGH_mean_last];

b = bar(X_density, Y_density)
grid on;
lgd = legend('sea floor', 'surface');
lgd.FontSize = 14;
lgd.Title.String = 'Depth';
lgd.Location = 'northwest';
ylim([27.7 28])
%b.FaceColor = 'flat'
%b.CData(1,:) = [1 0 0] %this is the RBG triplet value for red
%this puts the actual values on the tops of the bars
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','bottom')
xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center','VerticalAlignment','bottom')
% add titles
title('Average density over last month model ran', 'Color', 'k', 'FontWeight', 'bold')
xlabel('Model run')
ylabel('Density (kg/m^3)')


sgtitle('Mean values over last month of model run')
%sgtitle('Mean values over last month of model run', 'FontSize', 25)


























%create a table elements of TS variables so can export as csv and use in python
%ModelRun = ["Annual_CTRL_surface";"Annual_CTRL_bottom";"Annual_SaltHighTempHigh_surface";"Annual_SaltHighTempHigh_bottom";
    "Annual_SaltHighTempLow_surface";"Annual_SaltHighTempLow_bottom";"Annual_SaltLowTempHigh_surface";
    "Annual_SaltLowTempHigh_bottom";"Annual_SaltLowTempLow_surface";"Annual_SaltLowTempLow_bottom";"Winter_CTRL_surface";
    "Winter_CTRL_bottom";"Winter_SaltHighTempHigh_surface";"Winter_SaltHighTempHigh_bottom";
    "Winter_SaltHighTempLow_surface";"Winter_SaltHighTempLow_bottom";"Winter_SaltLowTempHigh_surface";
    "Winter_SaltLowTempHigh_bottom";"Winter_SaltLowTempLow_surface";"Winter_SaltLowTempLow_bottom"];

ModelRun = ["CTRL_surface";"CTRL_bottom";"TEMP_-1.5_surface";"TEMP_-1.5_bottom";
    "TEMP_-1.6_surface";"TEMP_-1.6_bottom";"TEMP_-1.7_surface";
    "TEMP_-1.7_bottom";"TEMP_-1.8_surface";"TEMP_-1.8_bottom";"TEMP_-1.9_surface";
    "TEMP_-1.9_bottom";"SALT_34.5_surface";"SALT_34.5_bottom";
    "SALT_34.6_surface";"SALT_34.6_bottom";"SALT_34.7_surface";
    "SALT_34.7_bottom";"SALT_34.9_surface";"SALT_34.9_bottom"];
ModelDepth = [13.13;472.22;13.13;472.22;13.13;472.22;13.13;472.22;13.13;472.22;13.13;472.22;13.13;472.22;13.13;472.22;13.13;472.22;13.13;472.22]
salinity = [salt_Annual_CTRL_mean_last_surface;salt_Annual_CTRL_mean_last;salt_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface;
    salt_Annual_SALT_HIGH_TEMP_HIGH_mean_last;salt_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface;salt_Annual_SALT_HIGH_TEMP_LOW_mean_last;
    salt_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface;salt_Annual_SALT_LOW_TEMP_HIGH_mean_last;salt_Annual_SALT_LOW_TEMP_LOW_mean_last_surface;
    salt_Annual_SALT_LOW_TEMP_LOW_mean_last;
    salt_Winter_CTRL_mean_last_surface;salt_Winter_CTRL_mean_last;salt_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface;
    salt_Winter_SALT_HIGH_TEMP_HIGH_mean_last;salt_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface;salt_Winter_SALT_HIGH_TEMP_LOW_mean_last;
    salt_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface;salt_Winter_SALT_LOW_TEMP_HIGH_mean_last;salt_Winter_SALT_LOW_TEMP_LOW_mean_last_surface;
    salt_Winter_SALT_LOW_TEMP_LOW_mean_last];
temperature = [temp_Annual_CTRL_mean_last_surface;temp_Annual_CTRL_mean_last;temp_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface;
    temp_Annual_SALT_HIGH_TEMP_HIGH_mean_last;temp_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface;temp_Annual_SALT_HIGH_TEMP_LOW_mean_last;
    temp_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface;temp_Annual_SALT_LOW_TEMP_HIGH_mean_last;temp_Annual_SALT_LOW_TEMP_LOW_mean_last_surface;
    temp_Annual_SALT_LOW_TEMP_LOW_mean_last;
    temp_Winter_CTRL_mean_last_surface;temp_Winter_CTRL_mean_last;temp_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface;
    temp_Winter_SALT_HIGH_TEMP_HIGH_mean_last;temp_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface;temp_Winter_SALT_HIGH_TEMP_LOW_mean_last;
    temp_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface;temp_Winter_SALT_LOW_TEMP_HIGH_mean_last;temp_Winter_SALT_LOW_TEMP_LOW_mean_last_surface;
    temp_Winter_SALT_LOW_TEMP_LOW_mean_last];
density = [density_Annual_CTRL_mean_last_surface;density_Annual_CTRL_mean_last;density_Annual_SALT_HIGH_TEMP_HIGH_mean_last_surface;
    density_Annual_SALT_HIGH_TEMP_HIGH_mean_last;density_Annual_SALT_HIGH_TEMP_LOW_mean_last_surface;density_Annual_SALT_HIGH_TEMP_LOW_mean_last;
    density_Annual_SALT_LOW_TEMP_HIGH_mean_last_surface;density_Annual_SALT_LOW_TEMP_HIGH_mean_last;density_Annual_SALT_LOW_TEMP_LOW_mean_last_surface;
    density_Annual_SALT_LOW_TEMP_LOW_mean_last;
    density_Winter_CTRL_mean_last_surface;density_Winter_CTRL_mean_last;density_Winter_SALT_HIGH_TEMP_HIGH_mean_last_surface;
    density_Winter_SALT_HIGH_TEMP_HIGH_mean_last;density_Winter_SALT_HIGH_TEMP_LOW_mean_last_surface;density_Winter_SALT_HIGH_TEMP_LOW_mean_last;
    density_Winter_SALT_LOW_TEMP_HIGH_mean_last_surface;density_Winter_SALT_LOW_TEMP_HIGH_mean_last;density_Winter_SALT_LOW_TEMP_LOW_mean_last_surface;
    density_Winter_SALT_LOW_TEMP_LOW_mean_last];

    
%create the table and export as csv
ModelOutput = table(ModelRun,ModelDepth,salinity,temperature,density)
filename = 'ModelOutputDSWTests.csv';
writetable(ModelOutput,filename);






