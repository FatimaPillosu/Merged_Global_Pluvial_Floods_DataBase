function RawFL = load_RawDBs(filename, NumVars, DataLine, Delimiter, NameVars, TypeVars)

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", NumVars);

% Specify range and delimiter
opts.DataLines = [DataLine, Inf];
opts.Delimiter = Delimiter;

% Specify column names and types
opts.VariableNames = NameVars;
opts.VariableTypes = TypeVars;

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

%% Import the data
RawFL = readtable(filename, opts);

end