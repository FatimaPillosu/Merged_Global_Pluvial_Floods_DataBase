          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
          %                                                      %
          %                    MATLAB TOOLBOX                    %
          %   MERGED GLOBAL FLASH FLOOD DATABASE - VERSION 1.0   %
          %                                                      %
          %                     developed by                     %
          %      Fatima Pillosu (Reading University & ECMWF)     %
          %                                                      %
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The objective of this toolbox is to collect data from different sources
% on flash flood occurrences around the world due to heavy rainfall, and
% merged such information in one single global flash flood database. The 
% merging operation undertaken in this toolbox is not a mere blending of 
% raw data from different sources, but it uses data wrangling to ehnhance 
% the usability of such raw datasets in understanding the capability of
% current rainfall forecasting systems in predicting the likelihood of 
% having a flash flood on a particular location. 

% The code can be downloaded, run interactively on a web browser, or cited 
% from the following GitHub repository:
% https://github.com/FatimaPillosu/Merged-Global-Flash-Flood-DB


%% CLEAN THE WORKSPACE AND THE COMMAND WINDOW
clear
clc


%% USER'S INPUTS
% Users are asked to enter some input parameters needed to run the toolbox.
% Therefore, users may change the values of the input parameters in the 
% "INPUTS" section according to their description in "DEFINITIONS".

% DEFINITIONS
% DateS (string): analysis period start date, in YYYY-MM-DD format.
% DateF (string): analysis period final date, in YYYY-MM-DD format.
% RawDBs (cell of chars): raw databases imported to be merged.
%                         List of databases that can be currently imported:
%                            - 'FL': FloodList;
%                            - 'EMDAT': Emergency Events Database;
%                            - 'ESWD': European Severe Weather Database;
%                            - 'SED': Storm Event Database.

% INPUTS
DateS = "2016-04-01";
DateF = "2017-03-31";
RawDBs = {'FL','EMDAT','ESWD','SED'};


%% IMPORTANT NOTE
% Users must not modify the code from now on to avoid triggering
% malfunctions in the toolbox.


%% PATHS SETUP

% Working Directory
% It coincides with the directory created by cloning the Github repository
WorkDir = pwd;

% Raw Databases
RawDBs_Dir = strcat(WorkDir, '/RawDBs');

% CPC Unified Gauge-Based Analysis of Global Daily Precipitation
CPC_Dir = strcat(WorkDir, '/CPC_GLOBAL_PRCP_V1.0');


%% MERGED DATABASE SETUP

% Attributes' Names
FinalAtt = {'OriginalSource', 'OriginalSourceID', 'OriginalReportQuality', 'Event_DateS', 'Event_DateF', 'Event_TimeS', 'Event_TimeF', 'Continent', 'Country', 'Location', 'Latitude', 'Longitude', 'EventType_CoastalFlood', 'EventType_FlashFlood', 'EventType_InlandFlood', 'EventType_TypeRiverFlood', 'EventType_TypeStormSurge', 'EventType_TypeUnknown', 'EventType_TypeLandslide', 'EventCause_DamBreak', 'EventCause_ExtremeRainfall', 'EventCause_IceJam', 'EventCause_HighTide', 'EventCause_LongTermRainfall', 'EventCause_ReservoirRelease', 'EventCause_Snowmelt', 'EventCause_SoilSaturation', 'EventCause_StormSurge', 'EventCause_Tsunami', 'Rainfall_Magnitude', 'CPC_Rainfall', 'ReportQuality'};

% Attributes' Types
FinalAttType = {'cell', 'double', 'double', 'cell', 'cell', 'double', 'double', 'cell', 'cell', 'cell', 'double', 'double', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'categorical', 'double', 'double', 'double'};


%% DISPLAY ON SCREEN TOOLBOX GENERAL INFORMATION AND USER'S INPUTS

disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
disp("%                                                      %")
disp("%                    MATLAB TOOLBOX                    %")
disp("%   MERGED GLOBAL FLASH FLOOD DATABASE - VERSION 1.0   %")
disp("%                                                      %")
disp("%                     developed by                     %")
disp("%      Fatima Pillosu (Reading University & ECMWF)     %")
disp("%                                                      %")
disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")

disp(" ")
disp("The objective of this toolbox is to collect data from different sources")
disp("on flash flood occurrences around the world due to heavy rainfall, and")
disp("merged such information in one single global flash flood database. The")
disp("merging operation undertaken in this toolbox is not a mere blending of")
disp("raw data from different sources, but it uses data wrangling to ehnhance")
disp("the usability of such raw datasets in understanding the capability of")
disp("current rainfall forecasting systems in predicting the likelihood of") 
disp("having a flash flood on a particular location.")

disp(" ")
disp("The code can be downloaded, run interactively on a web browser, or cited from the following GitHub repository:")
disp("https://github.com/FatimaPillosu/Merged-Global-Flash-Flood-DB")

disp(" ")
disp("*** USER'S INPUTS ***")
disp(" - Analysis Period: ")
disp(strcat("    from ", DateS, " to ", DateF))
disp(" - Raw Databases: ")
disp(RawDBs)

disp("*** TOOLBOX DIRECTORIES ***")
disp(" - Working directory: ")
disp(strcat("    ", WorkDir))
disp(" - Raw databases: ")
disp(strcat("    ", RawDBs_Dir))
disp(" - CPC unified gauge-based analysis of global daily precipitation: ")
disp(strcat("    ", CPC_Dir))

disp(" ")
disp("*** MERGED GLOBAL FLASH FLOOD DATABASE ***")
disp(" - Attributes: ")
for i = 1 : length(FinalAtt)
    disp(strcat("    ", FinalAtt{i}))
end


%% RAW DATABASES PRE-PROCESSING

disp(" ")
disp(" ")
disp("****************************")
disp("PRE-PROCESSING RAW DATABASES")
disp("****************************")

Num_RawDBs = length(RawDBs);
ind_RawDB = 4;


NameRawDB = RawDBs{ind_RawDB};
disp(" ")
disp(strcat("*** PRE-PROCESSING '", NameRawDB, "' RAW DATABASE ***"))

% Setting database-specific variables
switch NameRawDB
    case 'FL'
        % Number of attributes
        NumVars = 50; 
        % Row where the data starts
        DataLine = 2; 
        % Data delimiter
        Delimiter = ",";
        % Attributes names
        NameAtt = ["identifier", "source_id", "source", "web", "onset", "expires", "location_name", "country", "continent", "latitude", "longitude", "TypeCoastalFlood", "TypeFlashFlood", "TypeInlandFlood", "TypeRiverFlood", "TypeStormSurge", "TypeUnknown", "TypeLandslide", "CauseDamBreak", "CauseExtremeRainfall", "CauseIceJam", "CauseHighTide", "CauseLongTermRainfall", "CauseReservoirRelease", "CauseSnowmelt", "CauseSoilSaturation", "CauseStormSurge", "CauseTsunami", "CauseUnknown", "affected_quantitative", "agriculture_quantitative", "communications_quantitative", "cultural_heritage_quantitative", "death_quantitative", "education_quantitative", "environment_description", "environment_quantitative", "evacuated_quantitative", "forest_quantitative", "health_sector_quantitative", "heritage_quantitative", "houses_damaged_quantitative", "houses_destroyed_quantitative", "industry_quantitative", "injured_quantitative", "magnitude_description", "missing_quantitative", "roads_quantitative", "spatial_extent_quantitative", "transport_quantitative"];
        % Attributes types
        TypeAtt = ["double", "double", "string", "string", "string", "string", "string", "string", "string", "double", "double", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string"];
        % Attributes that one is certain wants to delete
        Att4Del = {'identifier','web', 'CauseUnknown', 'affected_quantitative', 'agriculture_quantitative', 'communications_quantitative', 'cultural_heritage_quantitative', 'death_quantitative', 'education_quantitative', 'environment_description', 'environment_quantitative', 'evacuated_quantitative', 'forest_quantitative', 'health_sector_quantitative', 'heritage_quantitative', 'houses_damaged_quantitative', 'houses_destroyed_quantitative', 'industry_quantitative', 'injured_quantitative', 'missing_quantitative', 'roads_quantitative', 'spatial_extent_quantitative', 'transport_quantitative'};
        % Attributes that store lat/lon values
        LatLon_Att = {'latitude','longitude'}; 
        % Max tollerance (in percent) of missing values per attribute
        MissTol = 50;
    case 'EMDAT'
        NumVars = 19;
        DataLine = 3;
        Delimiter = ",";
        NameAtt = ["Start date","End date","Country","ISO","Location","Latitude","Longitude","Magnitude value","Magnitude scale","Disaster type","Disaster subtype","Associated disaster","Associated disaster2","Total deaths","Total affected","Total damage ('000 US$)","Insured losses ('000 US$)","Disaster name","Disaster No."];
        TypeAtt = ["string", "string", "string", "string",	"string", "double",	"double", "double",	"string", "string", "string", "string", "string", "double", "double", "double",	"double", "string",	"string"];
     case 'ESWD'
        NumVars = 97;
        DataLine = 2;
        Delimiter = ",";
        NameAtt = ["ID","QC_LEVEL","INFO_SOURCE","CONTACT","EMAIL","ORGANISATION","ORGANISATION_ID","NO_REVISION","PERSON_REVISION","TIME_EVENT","TIME_CREATION","TIME_LAST_REVISION","TIME_ACCURACY","COUNTRY","STATE","PLACE","PLACE_LOCAL_LANGUAGE","DETAILED_LOCATION","NEAREST_CITY","LATITUDE","LONGITUDE","PLACE_ACCURACY","OROGRAPHY","SURFACE_INITIAL_LOCATION","SURFACE_CROSSED","TYPE_EVENT","NO_OBJECTS","MAX_HAIL_DIAMETER","MAX_HAILSTONE_WEIGHT","AVERAGE_HAIL_DIAMETER","THICKNESS_HAIL_LAYER","HAILSTONE","F_SCALE","T_SCALE","RATING_BASIS","WIND_SPEED","TEN_MIN_WIND_SPEED","FUNNEL_SIGHTED","SUCTION_VORTICES","PRECIPITATION_AMOUNT","SNOW_FALL_AMOUNT","PEAK_PRECIP_AMOUNT","PEAK_SNOW_FALL_AMOUNT","PEAK_PRECIP_PERIOD","MAX_6_HOUR_PRECIP","MAX_6_HOUR_SNOW_FALL","MAX_12_HOUR_PRECIP","MAX_12_HOUR_SNOW_FALL","MAX_24_HOUR_PRECIP","MAX_24_HOUR_SNOW_FALL","CONVECTIVE","TOTAL_DURATION","TYPE_PRECIP","SIZE_ACCOMPANYING_HAIL","POSSIBILITIES","PATH_LENGTH","MEAN_PATH_WIDTH","MAX_PATH_WIDTH","MAX_VERTICAL_DEVELOP","DIRECTION_MOVEMENT","SNOW_HAZARDS","MEAN_HEIGHT_SNOW_CORNICES","MAX_HEIGHT_SNOW_CORNICES","ICE_HAZARDS","THICKNESS_ICE_COVER","THICKNESS_RIME_COVER","AVALANCHE_TYPE","AVALANCHE_FLOW_TYPE","SNOW_MASS_TYPE","AVALANCHE_SIZE","AVALANCHE_TRIGGER","ELEVATION_START","ELEVATION_DIFFERENCE","LIGHTNING_DAMAGE_TO","PEAK_CURRENT","POLARITY","EXCEPT_ELEC_PHENOM","PROPERTY_DAMAGE","CROP_FOREST_DAMAGE","TOTAL_DAMAGE","NO_INJURE","NO_KILLED","EVENT_DESCRIPTION","PATH_START_LATITUDE","PATH_START_LONGITUDE","PATH_START_DATETIME","PATH_END_LATITUDE","PATH_END_LONGITUDE","PATH_END_DATETIME","EXT_URL","REFERENCE","IMPACTS","CREATOR_ID","REVISOR_ID","LINK_ORG","LINK_ID","DELETED"];
        TypeAtt = ["double", "string",	"string", "string",	"string", "string", "string", "double", "string", "string",	"string", "string",	"string", "string", "string", "string",	"string", "string",	"string", "double",	"double", "string",	"string", "string", "string", "string",	"string", "double", "double", "double", "double", "double",	"double", "double", "double", "double", "double", "double", "double", "double", "double", "double",	"double", "double", "double", "double",	"double", "double",	"double", "double",	"string", "double", "double", "double", "double", "double", "double", "double", "double", "double",	"double", "double", "double", "double",	"double", "double", "double", "double", "double", "double",	"double", "double", "double", "double",	"double", "double", "double", "string", "string", "string", "double", "double",	"string", "string",	"string", "string",	"string", "string",	"string", "string", "string", "string", "string", "string",	"string", "double",	"string"];
     case 'SED'
        NumVars = 51;
        DataLine = 2;
        Delimiter = ",";
        NameAtt = ["BEGIN_YEARMONTH","BEGIN_DAY","BEGIN_TIME","END_YEARMONTH","END_DAY","END_TIME","EPISODE_ID","EVENT_ID","STATE","STATE_FIPS","YEAR","MONTH_NAME","EVENT_TYPE","CZ_TYPE","CZ_FIPS","CZ_NAME","WFO","BEGIN_DATE_TIME","CZ_TIMEZONE","END_DATE_TIME","INJURIES_DIRECT","INJURIES_INDIRECT","DEATHS_DIRECT","DEATHS_INDIRECT","DAMAGE_PROPERTY","DAMAGE_CROPS","SOURCE","MAGNITUDE","MAGNITUDE_TYPE","FLOOD_CAUSE","CATEGORY","TOR_F_SCALE","TOR_LENGTH","TOR_WIDTH","TOR_OTHER_WFO","TOR_OTHER_CZ_STATE","TOR_OTHER_CZ_FIPS","TOR_OTHER_CZ_NAME","BEGIN_RANGE","BEGIN_AZIMUTH","BEGIN_LOCATION","END_RANGE","END_AZIMUTH","END_LOCATION","BEGIN_LAT","BEGIN_LON","END_LAT","END_LON","EPISODE_NARRATIVE","EVENT_NARRATIVE","DATA_SOURCE"];
        TypeAtt = ["string","string","string","string","string","string","double","double","string","double","double","string","string","string","double","string","string","string","string","string","double","double","double","double","string","string","string","double","string","string","string","string","double","double","string","string","double","string","double","string","string","double","string","string","double","double","double","double","string","string","string"];
    otherwise
        error("Not valid raw database name.")
end


%%%%%%%%%%%%%%%%%%%%%% Importing the raw csv file(s) %%%%%%%%%%%%%%%%%%%%%%

disp(" ")
disp("Step n.1 - Loading the raw data (if therequired data is split in more files, they are automatically merged into one single table)")
RawDB_Dir_temp = strcat(RawDBs_Dir, '/', NameRawDB, '/Original');
RawDB_temp = dir(RawDB_Dir_temp);
[m,~] = size(RawDB_temp);
if m < 3
    disp("No files to import.")
else
    TotRawDB_temp = []; % if the data is split in more files, they are merged in one variable
    for j = 3 : m
        RawDB_Name_temp = RawDB_temp(j).name;
        RawDB_File_temp = strcat(RawDB_Dir_temp, '/', RawDB_Name_temp);
        disp(strcat(" - Importing ", RawDB_File_temp))
        TotRawDB_temp = [TotRawDB_temp; load_RawDBs(RawDB_File_temp, NumVars, DataLine, Delimiter, NameAtt, TypeAtt)];
    end
end
[m,n] = size(TotRawDB_temp);
VarNames = TotRawDB_temp.Properties.VariableNames;

disp(" ")
disp("Step n.2 - Display some general information about the raw database")
disp(strcat(" - Number of total instances (rows): ", num2str(m)))
disp(strcat(" - Number of attributes (columns): ", num2str(n)))
disp(" - Raw Database preview (first five instances):")
disp(" ")
disp(head(TotRawDB_temp,5))


%%%%%%%%%%%%%%%%%%%%%%%% Cleaning the raw csv file %%%%%%%%%%%%%%%%%%%%%%%%

% Cleaning from attributes that might not be useful in the merged database
disp(" ")
disp("Step n.3 - Attributes to delete because not useful in the final merged database")
for i = 1 : length(Att4Del)
    disp(strcat(" - ", Att4Del{i}))
    TotRawDB_temp(:,Att4Del{i}) = [];
end
[m,n] = size(TotRawDB_temp);
VarNames = TotRawDB_temp.Properties.VariableNames;

% Cleaning from attributes that contain too many missing values
disp(" ")
disp(strcat("Step n.4 - Attributes candidate for deletion as contain more than ", num2str(MissTol), "% of missing values"))
Missing2Del = {};
for i = 1 : n
    temp = TotRawDB_temp(:,i);
    missing_temp = sum(ismissing(temp));
    perc_missing = missing_temp/m*100;
    if perc_missing >= MissTol
        disp(strcat(" - ", VarNames{i}))
        Missing2Del = [Missing2Del, VarNames{i}];
    end
end

if isempty(Missing2Del)
    disp(" - No other attributes candidate for deletion.")
else
    % Check that lat/lon attributes are not in the list of candidates for deletion
    if sum(strcmp(VarNames,LatLon_Att{1}))==1 || sum(strcmp(VarNames,LatLon_Att{2}))==1
        disp(" - 'Latitude' and 'Longitude' attributes will not be deleted.")
        Missing2Del(Missing2Del == LatLon_Att{1}) = [];
        Missing2Del(Missing2Del == LatLon_Att{2}) = [];
    end
end  

disp(" ")
disp(head(TotRawDB_temp,5))


%%%%%%%%%%%%%%%%%%%%%% Transforming the raw csv file %%%%%%%%%%%%%%%%%%%%%%

% Create the template for the final merged database
NumAtt = length(FinalAtt);
MergedDB = table('Size', [m,NumAtt], 'VariableTypes', FinalAttType, 'VariableNames', FinalAtt);

% 1st attribute
MergedDB(:,1) = array2table(repmat({NameRawDB},m,1));

% 2nd attribute
MergedDB(:,2) = TotRawDB_temp(:,'source_id');

% 3rd attribute
MergedDB(:,3) = array2table(nan(m,1));

% 8th-32nd attribute
MergedDB(:,8) = TotRawDB_temp(:,'country');
MergedDB(:,9) = TotRawDB_temp(:,'country');
MergedDB(:,10) = TotRawDB_temp(:,'country');
MergedDB(:,11) = TotRawDB_temp(:,'country');
MergedDB(:,12) = TotRawDB_temp(:,'country');
MergedDB(:,13) = TotRawDB_temp(:,'country');
MergedDB(:,14) = TotRawDB_temp(:,'country');
MergedDB(:,15) = TotRawDB_temp(:,'country');
MergedDB(:,16) = TotRawDB_temp(:,'country');
MergedDB(:,17) = TotRawDB_temp(:,'country');
MergedDB(:,18) = TotRawDB_temp(:,'country');
MergedDB(:,19) = TotRawDB_temp(:,'country');
MergedDB(:,20) = TotRawDB_temp(:,'country');
MergedDB(:,21) = TotRawDB_temp(:,'country');
MergedDB(:,23) = TotRawDB_temp(:,'country');
MergedDB(:,24) = TotRawDB_temp(:,'country');
MergedDB(:,25) = TotRawDB_temp(:,'country');
MergedDB(:,26) = TotRawDB_temp(:,'country');
MergedDB(:,27) = TotRawDB_temp(:,'country');
MergedDB(:,28) = TotRawDB_temp(:,'country');
MergedDB(:,29) = TotRawDB_temp(:,'country');
MergedDB(:,30) = TotRawDB_temp(:,'country');
MergedDB(:,31) = TotRawDB_temp(:,'country');
MergedDB(:,32) = TotRawDB_temp(:,'country');


%% LOAD THE CPC UNIFIED GAUGE-BASED ANALYSIS OF GLOBAL DAILY PRECIPITATION

disp(" ")
disp(" ")
disp("************************************************************************************")
disp("EXTRACTING THE GLOBAL DAILY PRECIPITATION FROM THE CPC UNIFIED GAUGE-BASED ANALYSIS")
disp("************************************************************************************")

[lat, lon, PrecipCPC] = GlobalPPT_CPC_extract(DateS, DateF, CPC_Dir);














































