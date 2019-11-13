function [lat_def, lon_def, precip_def] = GlobalPPT_CPC_extract(DateS, DateF, CPC_Dir)

disp('Extracting daily rainfall values in mm/24h from the CPC Unified')
disp('Gauged-Based Analysis of Global Daily Precipitation for the period')
disp('of interest.')


% Setting the array that contains the dates involved in the analysis period
DateS = datetime(DateS,'InputFormat','yyyy-MM-dd');
DateF = datetime(DateF,'InputFormat','yyyy-MM-dd');
[YearS,MonthS,DayS] = ymd(DateS);
[YearF,MonthF,DayF] = ymd(DateF);
Analysis_Years = YearS:YearF;
Num_Years = length(Analysis_Years);


% Extract the rainfall values for the analysis period
precip_tot = [];
Tot_NumDays = 0;
disp(' ')

for i = 1 : Num_Years
    
    % Setting the dates
    Year = Analysis_Years(i);
    Dates_arr = datenum(Year,1,1) : datenum(Year,12,31);
    NumDays = length(Dates_arr);
    
    disp(['Post-Processing year: ', num2str(Year)])
    
    % Read the NetCDF file for one specific year and extract the precipitation data
    NetCDF_File = strcat(CPC_Dir, '/precip.', num2str(Year), '.nc');
    precip = ncread(NetCDF_File,'precip');
        
    % Check that the precipiation file contain the correct number of days
    [~,~,numdays] = size(precip);
    if numdays ~= NumDays
        error('There are days missing in the NetCDF file.')
    end
    
    % Extract the required subset of dates
    if Year == YearS
        pointer = find(Dates_arr == datenum(YearS,MonthS,DayS));
        precip_temp = precip(:,:,pointer:end);
    elseif Year == YearF
        pointer = find(Dates_arr == datenum(YearF,MonthF,DayF));
        precip_temp = precip(:,:,1:pointer);
    else
        precip_temp = precip(:,:,:);
    end
    precip_tot = cat (3, precip_tot,  precip_temp);
    [~,~,NumDays] = size(precip_temp); 
    Tot_NumDays = Tot_NumDays + NumDays;
end
precip_tot(precip_tot<0) = nan; % negative values in the original NetCDFs
                                % represent "no values". Those have been 
                                % sostitute with "nan" values. Matlab,
                                % indeed, provides functions that would
                                % facilitate the exclusion of such values.
                                % Negative values would be read as normal
                                % values and they might influence certain
                                % computations.
                                
disp(['Total number of days in the analysis period: ', num2str(Tot_NumDays)])


%Extract the lat/lon coordinates for the NetCDF grid 
lat = ncread(NetCDF_File,'lat');
lon = ncread(NetCDF_File,'lon'); 
n_lat = length(lat);
n_lon = length(lon);

disp(' ')
disp('The original NetCDFs represent global fields in regular lat/lon grids with')
disp([' - ', num2str(n_lat), ' points for the latitudes coordinates (y-dir)'])
disp([' - ', num2str(n_lon), ' points for the longitudes coordinates (x-dir)'])

                                
% Adapt the data to display the longitudes coordinates from 0 to 360°
disp(' ')
disp('Adapting the fields to display the longitudes coordinates from 0° to 360°')
lat_temp = repmat(lat',n_lon,1);
lon_temp = repmat(lon, 1, n_lat);
lon_temp = lon_temp - 180;
pointer1 = find(lon_temp(:,1)<0);
pointer2 = find(lon_temp(:,1)>=0);
lat_def = [lat_temp(pointer2,:); lat_temp(pointer1,:)];
lon_def = [lon_temp(pointer2,:); lon_temp(pointer1,:)+360];

[m,n,p] = size(precip_tot);
precip_def = zeros(m,n,p);
for i = 1 : p
    precip_temp = precip_tot(:,:,i);
    precip_def(:,:,i) = [precip_temp(pointer2,:); precip_temp(pointer1,:)];
end