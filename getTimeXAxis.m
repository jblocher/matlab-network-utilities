function yearq = getTimeXAxis(startYr,Nyr)
% getTimeXAxis returns a vector of X Axis labels with time/qtr pairs
%  
%  Parameters:
%  start is the start year
%  N is the number of quarters desired starting 1Q1980
%  
%  Returns:
%  CellArray of labels of length N

yr = startYr:startYr+ceil(Nyr/4);
qtr = [3 6 9 12]; 

yrlist = repmat(yr,1,4);
sorted_yrlist = sort(yrlist);
qtrlist = repmat(qtr,1,length(yr));
datev = [sorted_yrlist' qtrlist' ones(length(qtrlist),4)];
dates = datestr(datev);

yearq = cellstr(dates(1:Nyr,:));