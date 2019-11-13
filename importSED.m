function SED = importSED(filename)


%% Setup of input handling and import options
dataLines = [2, Inf];
opts = delimitedTextImportOptions("NumVariables", 51);


%% Import the data

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["BEGIN_YEARMONTH", "BEGIN_DAY", "BEGIN_TIME", "END_YEARMONTH", "END_DAY", "END_TIME", "EPISODE_ID", "EVENT_ID", "STATE", "STATE_FIPS", "YEAR", "MONTH_NAME", "EVENT_TYPE", "CZ_TYPE", "CZ_FIPS", "CZ_NAME", "WFO", "BEGIN_DATE_TIME", "CZ_TIMEZONE", "END_DATE_TIME", "INJURIES_DIRECT", "INJURIES_INDIRECT", "DEATHS_DIRECT", "DEATHS_INDIRECT", "DAMAGE_PROPERTY", "DAMAGE_CROPS", "SOURCE", "MAGNITUDE", "MAGNITUDE_TYPE", "FLOOD_CAUSE", "CATEGORY", "TOR_F_SCALE", "TOR_LENGTH", "TOR_WIDTH", "TOR_OTHER_WFO", "TOR_OTHER_CZ_STATE", "TOR_OTHER_CZ_FIPS", "TOR_OTHER_CZ_NAME", "BEGIN_RANGE", "BEGIN_AZIMUTH", "BEGIN_LOCATION", "END_RANGE", "END_AZIMUTH", "END_LOCATION", "BEGIN_LAT", "BEGIN_LON", "END_LAT", "END_LON", "EPISODE_NARRATIVE", "EVENT_NARRATIVE", "DATA_SOURCE"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "string", "double", "double", "string", "string", "string", "double", "string", "string", "datetime", "string", "datetime", "double", "double", "double", "double", "double", "double", "string", "double", "string", "string", "string", "string", "double", "double", "string", "string", "string", "string", "double", "string", "string", "double", "string", "string", "double", "double", "double", "double", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["STATE", "MONTH_NAME", "EVENT_TYPE", "CZ_TYPE", "CZ_NAME", "WFO", "CZ_TIMEZONE", "SOURCE", "MAGNITUDE_TYPE", "FLOOD_CAUSE", "CATEGORY", "TOR_F_SCALE", "TOR_OTHER_WFO", "TOR_OTHER_CZ_STATE", "TOR_OTHER_CZ_FIPS", "TOR_OTHER_CZ_NAME", "BEGIN_AZIMUTH", "BEGIN_LOCATION", "END_AZIMUTH", "END_LOCATION", "EPISODE_NARRATIVE", "EVENT_NARRATIVE", "DATA_SOURCE"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["STATE", "MONTH_NAME", "EVENT_TYPE", "CZ_TYPE", "CZ_NAME", "WFO", "CZ_TIMEZONE", "SOURCE", "MAGNITUDE_TYPE", "FLOOD_CAUSE", "CATEGORY", "TOR_F_SCALE", "TOR_OTHER_WFO", "TOR_OTHER_CZ_STATE", "TOR_OTHER_CZ_FIPS", "TOR_OTHER_CZ_NAME", "BEGIN_AZIMUTH", "BEGIN_LOCATION", "END_AZIMUTH", "END_LOCATION", "EPISODE_NARRATIVE", "EVENT_NARRATIVE", "DATA_SOURCE"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "BEGIN_DATE_TIME", "InputFormat", "dd-MMM-yy HH:mm:ss");
opts = setvaropts(opts, "END_DATE_TIME", "InputFormat", "dd-MMM-yy HH:mm:ss");
opts = setvaropts(opts, ["DAMAGE_PROPERTY", "DAMAGE_CROPS"], "TrimNonNumeric", true);
opts = setvaropts(opts, ["DAMAGE_PROPERTY", "DAMAGE_CROPS"], "ThousandsSeparator", ",");

% Import the data
SED = readtable(filename, opts);