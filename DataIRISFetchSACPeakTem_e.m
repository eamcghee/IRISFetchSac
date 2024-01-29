clear
close all
clc

% Goal: download sac files in format compatible with template_extract_e.m
% Save to (ex): '/Users/em/PROJECTS/PEAKTEM/DATA/DR01_HHE_--_2015_065.sac'
% File naming convention goal: DR01_HHE_--_2015_065.sac
% Example date related to 065 in name above: 3/16/2015

% To do: change dates (ln 26-27), find output in /DATA folder
% Took about 47 seconds

folderPath = ['/Users/em/PROJECTS/PEAKTEM/DATA/'];

% Metadata for naming file
netcode ='XH'; % set manually in fetch line to reduce fetch time
stacode ='DR01'; % set manually in fetch line to reduce fetch time
%chancode ='HHZ'; % set manually in fetch line to reduce fetch time
%chancode ='HHN'; % set manually in fetch line to reduce fetch time
%chancode ='HHE'; % set manually in fetch line to reduce fetch time
dashcode ='--'; % set manually in fetch line to reduce fetch time

% note: data_starttime_day,data_endtime_day will be set manually below, but
% variable name used in fetch line instead of manual entry.

data_starttime_day = '2015-01-02 00:00:00';%First day of sequence yyyy-mm-dd hr:mi:se
data_endtime_day = '2015-01-03 00:00:00';%First day of sequence
data_starttime_num = datenum(data_starttime_day);%First day datenum
data_endtime_num = datenum(data_endtime_day);%First day datenum

ndays = data_endtime_num - data_starttime_num;
spd = 1;%segments per day
ovlp = 1; %percent of overlap between days (to not miss events at the boundaries of the data segments

%extracting date format to use in file naming
%write code to set date to julian day for year 
% example 3/16/2015 = 065

% this section was written by chat gpt 3.5 on 26 Jan 2024
% Convert the string to a datetime object
datetimeObj = datetime(data_starttime_day, 'InputFormat', 'yyyy-MM-dd HH:mm:ss');

% Extract date only and convert back to string
data_starttime_day_notime = datestr(datetimeObj, 'yyyy-mm-dd');

% Extract year only
data_starttime_year = datestr(datetimeObj, 'yyyy');

% Convert the string to a datetime object
datetimeObj = datetime(data_starttime_day_notime, 'InputFormat', 'yyyy-MM-dd');

% Calculate the Julian date (number of days elapsed in the year (doy))
jdate = datenum(datetimeObj) - datenum(datetime(datetimeObj.Year, 1, 1)) + 1;

% Convert to a string with leading zeros (so 65 becomes 065, for ex.)
jdatee = sprintf('%03d', jdate);

% Display the result
disp(['Original date without time: ', data_starttime_day_notime]);
disp(['Julian date: ', num2str(jdate)]);

%end chat code writing here.

data_starttime_num=datenum(data_starttime_day);%First day datenum
nsegments=round((ndays+1)*spd*(1/(1-(ovlp/100))));

javaaddpath('IRIS-WS-2.0.19.jar'); %Java addpath for enabling IRIS Web Services Calls

%'/Users/em/PROJECTS/PEAKTEM/DATA/DR01_--_2015_065.sac'
%wf_filename produces: DR01_--_2015_075.mat
wf_filename=[stacode,'_',dashcode,'_',data_starttime_year,'_',jdatee,'.sac'];
fullpath = fullfile(['/Users/em/PROJECTS/PEAKTEM/DATA/',wf_filename]);  % Get the full path of the file

% reminders, double check...
% netcode='XH';
% stacode='DR01';
% chancode='HHZ';
% %chancode='HHN';
% %chancode='HHE';
% dashcode='--';

%ex: irisFetch.SACfiles('IU','ANMO','*','*Z','2010-02-27 06:30:00','2010-02-27 07:30:00','/example/directory/')
irisFetch.SACfiles('XH','DR01','--','HHZ',data_starttime_day,data_endtime_day,'/Users/em/PROJECTS/PEAKTEM/DATA/');
irisFetch.SACfiles('XH','DR01','--','HHE',data_starttime_day,data_endtime_day,'/Users/em/PROJECTS/PEAKTEM/DATA/');
irisFetch.SACfiles('XH','DR01','--','HHN',data_starttime_day,data_endtime_day,'/Users/em/PROJECTS/PEAKTEM/DATA/');

% note: ideally, the above three lines would look like the three lines below, but it took 10x longer to download data when I tried that, 
 % so because the netcode, stacode, and components don't change until I move on to the next station, I typed them in the lines instead 
 % of using variables, except for the date info, so there was a single point of failure for that/less error. 

%irisFetch.SACfiles(netcode,stacode,'--',chancode,data_starttime_day,data_endtime_day,'/Users/em/PROJECTS/PEAKTEM/DATA/');
%irisFetch.SACfiles(netcode,stacode,'--',chancode,data_starttime_day,data_endtime_day,'/Users/em/PROJECTS/PEAKTEM/DATA/');
%irisFetch.SACfiles(netcode,stacode,'--',chancode,data_starttime_day,data_endtime_day,'/Users/em/PROJECTS/PEAKTEM/DATA/');

% FOR EACH COMPONENT// file name change written by chat gpt 3.5 on 26 Jan 2024
% Issue: extracted info loops save file to current instead of /DATA

% FILE NAME CHANGE FOR HHZ
% Original file name

% Original filename template
originalFileNameTemplate1 = 'DATA/XH.DR01..HHZ.2015.%03d.00.00.00.SAC';

% Create the filename with the current jdatee value
originalFileName1 = strrep(originalFileNameTemplate1, '%03d', jdatee);

disp(['Original filename: ', originalFileName1]);

% Extracting relevant information using regular expressions
expression = 'XH\.(\w+)\.\.(\w+)\.(\d{4})\.(\d{3})\.(\d{2})\.(\d{2})\.(\d{2})\.SAC';
tokens = regexp(originalFileName1, expression, 'tokens');

% Rearrange extracted information
if ~isempty(tokens)
    network = tokens{1}{2};
    station = tokens{1}{1};
    year = tokens{1}{3};
    doy = tokens{1}{4};

    % Forming the new file name
    newFileName1 = sprintf('%s_%s_--_%s_%s.sac', station, network, year, doy);

    % Rename the file
    movefile(originalFileName1, newFileName1);

    disp('File renamed successfully.');
else
    disp('Failed to extract information from the filename.');
end

% FILE NAME CHANGE FOR HHE

% Original filename template
originalFileNameTemplate2 = 'DATA/XH.DR01..HHE.2015.%03d.00.00.00.SAC';

% Create the filename with the current jdatee value
originalFileName2 = strrep(originalFileNameTemplate2, '%03d', jdatee);

disp(['Original filename: ', originalFileName2]);

% Extracting relevant information using regular expressions
expression = 'XH\.(\w+)\.\.(\w+)\.(\d{4})\.(\d{3})\.(\d{2})\.(\d{2})\.(\d{2})\.SAC';
tokens = regexp(originalFileName2, expression, 'tokens');

% Rearrange extracted information
if ~isempty(tokens)
    network = tokens{1}{2};
    station = tokens{1}{1};
    year = tokens{1}{3};
    doy = tokens{1}{4};

    % Forming the new file name
    newFileName2 = sprintf('%s_%s_--_%s_%s.sac', station, network, year, doy);

    % Rename the file
    movefile(originalFileName2, newFileName2);

    disp('File renamed successfully.');
else
    disp('Failed to extract information from the filename.');
end

% FILE NAME CHANGE FOR HHN

% Original filename template
originalFileNameTemplate3 = 'DATA/XH.DR01..HHN.2015.%03d.00.00.00.SAC';

% Create the filename with the current jdatee value
originalFileName3 = strrep(originalFileNameTemplate3, '%03d', jdatee);

disp(['Filename: ', originalFileName3]);

% Extracting relevant information using regular expressions
expression = 'XH\.(\w+)\.\.(\w+)\.(\d{4})\.(\d{3})\.(\d{2})\.(\d{2})\.(\d{2})\.SAC';
tokens = regexp(originalFileName3 ...
    , expression, 'tokens');

% Rearrange extracted information
if ~isempty(tokens)
    network = tokens{1}{2};
    station = tokens{1}{1};
    year = tokens{1}{3};
    doy = tokens{1}{4};

    % Forming the new file name
    newFileName3 = sprintf('%s_%s_--_%s_%s.sac', station, network, year, doy);

    % Rename the file
    movefile(originalFileName3, newFileName3);

    disp('File renamed successfully.');
else
    disp('Failed to extract information from the filename.');
end

% MOVES ALL FILES TO /DATA
% Folder paths
sourceFolderPath = '/Users/em/PROJECTS/PEAKTEM/';
destinationFolderPath = '/Users/em/PROJECTS/PEAKTEM/DATA/';

% List files in the source folder
files = dir(fullfile(sourceFolderPath, 'DR01*'));

% Loop through the files and move them to the destination folder
for i = 1:length(files)
    % Current file name
    currentFileName = files(i).name;
    
    % Full paths for source and destination
    sourceFilePath = fullfile(sourceFolderPath, currentFileName);
    destinationFilePath = fullfile(destinationFolderPath, currentFileName);
    
    % Move the file
    movefile(sourceFilePath, destinationFilePath);
    
    fprintf('File %s moved to %s\n', currentFileName, destinationFolderPath);
end

%%

% %%
% for l=1:length(chancode)
% mysac_nw=irisFetch.SACfiles(netcode,stacode,'--',chancode(l),data_starttime_day,data_endtime_day,fullpath);
% if ~isempty(mysac_nw)
%     nsegs=length(mysac_nw);
%     if nsegs > 1 % if multiple traces returned then merge them
%     mysac_nw=merge_trace(mysac_nw,nsegs,'nan');
%     merged_trace=merge_trace(mysac_nw,nsegs,'zeros');
%     end
% end
% 
% % DAYLONG_3C{l}=mytrace_nw;
% DAYLONG_3C(it,l)=mysac_nw;
% end
% %%
% DL=DAYLONG_3C(it,:);
% save(fullpath, 'DL');

%%reference for sac

% 
%       function SACfiles(network, station, location, channel, startDate, endDate, writeDirectory, varargin)
%          % irisFetch.SACfiles(network, station, location, channel, startDate, endDate, writeDirectory,...)
%          %   As with irisFetch.Traces, but waveform data will be written out as SAC files
%          %   to a directory specified by 'writeDirectory'
%          %
%          %   The 'writeDirectory' parameter is mandatory. If 'writeDirectory' does not exist, then
%          %   it will be created.
%          %
%          %   NOTE: unlike the Traces method, no structures will be saved in your MATLAB workspace
%          %   if this method is used.
%          %
%          %   see irisFetch.Traces for more information on specifying channel identifier inputs
% 
%          irisFetch.Traces(network, station, location, channel, startDate, endDate, ['WRITESAC:', writeDirectory], 'ASJAVA', varargin{:});
%       end

%%

% %%
% %convert string to num for use in the iris webcall 
% 
% % Your string
% data_starttime_day = '2015-03-04 00:00:00';
% 
% % Convert string to datetime
% dt = datetime(data_starttime_day, 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
% 
% % Convert datetime to numeric value (serial date number)
% numericValue = datenum(dt);
% 
% disp(['Numeric value:', num2str(numericValue)]);

% movefile newFileName1 DATA
% movefile newFileName2 DATA
% movefile newFileName3 DATA

%movefile DR01_HHZ_--_2015_075.sac DATA
%movefile DR01_HHE_--_2015_075.sac DATA
%movefile DR01_HHN_--_2015_075.sac DATA