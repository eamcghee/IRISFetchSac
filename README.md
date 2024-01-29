Lines 1-94 are for fetching, probably all you need if you're retrieving sac files for your own project. 
Lines 95-217 are for re-naming the file so that it's seamlessly functional with the file naming conventions of Step 2- Matched Filtering of the Ross Ice Shelf Catalog 2014-2016 Code. 

libraries/functions/files needed to operate: 

1. ## .jar file. 
IRIS-WS-2.0.19.jar for Line 67: javaaddpath('IRIS-WS-2.0.19.jar'); %Java addpath for enabling IRIS Web Services Calls

To download, use this website: https://ds.iris.edu/ds/nodes/dmc/software/downloads/iris-ws/2-0-19/
Half-way down the page, it says: Download // The current release is available in the following forms: // A jar file with dependencies: IRIS-WS-2.0.19.jar (MATLAB users, choose this)
Download the .jar file so you can use it with this code. 

2. ## irisFetch tool/library.
irisFetch is the IRIS webcall used in Lines 83 to 85: 
irisFetch.SACfiles('XH','DR01','--','HHZ',data_starttime_day,data_endtime_day,'/Users/em/PROJECTS/PEAKTEM/DATA/');
irisFetch.SACfiles('XH','DR01','--','HHE',data_starttime_day,data_endtime_day,'/Users/em/PROJECTS/PEAKTEM/DATA/');
irisFetch.SACfiles('XH','DR01','--','HHN',data_starttime_day,data_endtime_day,'/Users/em/PROJECTS/PEAKTEM/DATA/');

To download, use this website: https://ds.iris.edu/ds/nodes/dmc/software/downloads/irisfetch.m/#:~:text=The%20Matlab%20library%20IRISFETCH%20allows,metadata%2C%20and%20time%20series%20data.

Info//This is from the readme file from # irisFetch-matlab: 
##Summary
The MATLAB file irisFetch.m provides an interface for access to data stored within the IRIS-DMC as well as other data centers that implement FDSN web services.
##Description
The file irisFetch.m provides a collection of routines that allow access to:
* seismic trace data, containing information similar to a basic SAC file
* station metadata, providing details down to the instrument response level
* event parameters, including magnitudes and locations of earthquakes

