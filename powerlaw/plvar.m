function [alpha, xmin, n]=plvar(x, varargin)
% PLVAR estimates the uncertainty in the estimated power-law parameters.
%    Source: http://www.santafe.edu/~aaronc/powerlaws/
% 
%    PLVAR(x) takes a vector of observations x and returns estimated
%    uncertainties in the estimated power-law parameters, based on the
%    nonparametric approach described in Clauset, Shalizi, Newman (2007). 
%    PLVAR automatically detects whether x is composed of real or integer
%    values, and applies the appropriate method. For discrete data, if
%    min(x) > 1000, PLVAR uses the continuous approximation, which is 
%    a reliable in this regime.
%   
%    The fitting procedure works as follows:
%    1) For each possible choice of x_min, we estimate alpha via the 
%       method of maximum likelihood, and calculate the Kolmogorov-Smirnov
%       goodness-of-fit statistic D.
%    2) We then select as our estimate of x_min, the value that gives the
%       minimum value D over all values of x_min.
%
%    Note that this procedure gives no estimate of the uncertainty of the 
%    fitted parameters, nor of the validity of the fit.
%
%    Example:
%       x = (1-rand(10000,1)).^(-1/(2.5-1));
%       [alpha, xmin, ntail] = plvar(x);
%
%    For more information, try 'type plvar'
%
%    See also PLFIT, PLPVA

% Version 1.0   (2007 May)
% Version 1.0.2 (2007 September)
% Version 1.0.3 (2007 September)
% Version 1.0.4 (2008 January)
% Version 1.0.5 (2008 March)
% Version 1.0.6 (2008 April)
% Version 1.0.7 (2009 October)
% Copyright (C) 2008-2009 Aaron Clauset (Santa Fe Institute)
% Distributed under GPL 2.0
% http://www.gnu.org/copyleft/gpl.html
% PLVAR comes with ABSOLUTELY NO WARRANTY
% 
% Notes:
% 
% 1. In order to implement the integer-based methods in Matlab, the numeric
%    maximization of the log-likelihood function was used. This requires
%    that we specify the range of scaling parameters considered. We set
%    this range to be [1.50 : 0.01 : 3.50] by default. This vector can be
%    set by the user like so,
%    
%       a = plvar(x,'range',[1.001:0.001:5.001]);
%    
% 2. PLVAR can be told to limit the range of values considered as estimates
%    for xmin in three ways. First, it can be instructed to sample these
%    possible values like so,
%    
%       a = plfit(x,'sample',100);
%    
%    which uses 100 uniformly distributed values on the sorted list of
%    unique values in the data set. Second, it can simply omit all
%    candidates above a hard limit, like so
%    
%       a = plfit(x,'limit',3.4);
%    
%    Finally, it can be forced to use a fixed value, like so
%    
%       a = plfit(x,'xmin',3.4);
%    
%    In the case of discrete data, it rounds the limit to the nearest
%    integer.
% 
% 3. The default number of nonparametric repetitions of the fitting
% procedure is 1000. This number can be changed like so
%    
%       a = plvar(x,'reps',10000);
%    
% 4. To silence the textual output to the screen, do this
%    
%       p = plvar(x,'silent');
% 
% 

vec    = [];
sample = [];
limit  = [];
xminx  = [];
Bt     = [];
quiet  = false;
persistent rand_state;

% parse command-line parameters; trap for bad input
i=1; 
while i<=length(varargin), 
  argok = 1; 
  if ischar(varargin{i}), 
    switch varargin{i},
        case 'range',        vec    = varargin{i+1}; i = i + 1;
        case 'sample',       sample = varargin{i+1}; i = i + 1;
        case 'limit',        limit  = varargin{i+1}; i = i + 1;
        case 'xmin',         xminx   = varargin{i+1}; i = i + 1;
        case 'reps',         Bt     = varargin{i+1}; i = i + 1;
        case 'silent',       quiet  = true;    i = i + 1;
        otherwise, argok=0; 
    end
  end
  if ~argok, 
    disp(['(PLVAR) Ignoring invalid argument #' num2str(i+1)]); 
  end
  i = i+1; 
end
if ~isempty(vec) && (~isvector(vec) || min(vec)<=1),
	fprintf('(PLVAR) Error: ''range'' argument must contain a vector; using default.\n');
    vec = [];
end;
if ~isempty(sample) && (~isscalar(sample) || sample<2),
	fprintf('(PLVAR) Error: ''sample'' argument must be a positive integer > 1; using default.\n');
    sample = [];
end;
if ~isempty(limit) && (~isscalar(limit) || limit<1),
	fprintf('(PLVAR) Error: ''limit'' argument must be a positive value >= 1; using default.\n');
    limit = [];
end;
if ~isempty(Bt) && (~isscalar(Bt) || Bt<2),
	fprintf('(PLVAR) Error: ''reps'' argument must be a positive value > 1; using default.\n');
    Bt = [];
end;
if ~isempty(xminx) && (~isscalar(xminx) || xminx>=max(x)),
	fprintf('(PLVAR) Error: ''xmin'' argument must be a positive value < max(x); using default behavior.\n');
    xminx = [];
end;

% reshape input vector
x = reshape(x,numel(x),1);

% select method (discrete or continuous) for fitting
if     isempty(setdiff(x,floor(x))), f_dattype = 'INTS';
elseif isreal(x),    f_dattype = 'REAL';
else                 f_dattype = 'UNKN';
end;
if strcmp(f_dattype,'INTS') && min(x) > 1000 && length(x)>100,
    f_dattype = 'REAL';
end;
if isempty(rand_state)
    rand_state = cputime;
    rand('twister',sum(100*clock));
end;
if isempty(Bt), Bt = 1000; end;
N   = length(x);
bof = zeros(Bt,3);

if ~quiet,
    fprintf('Power-law Distribution, parameter error calculation\n');
    fprintf('   Copyright 2007-2009 Aaron Clauset\n');
    fprintf('   Warning: This can be a slow calculation; please be patient.\n');
    fprintf('   n    = %i\n   reps = %i\n',N,length(bof));
end;
tic;

% estimate xmin and alpha, accordingly
switch f_dattype,
    
    case 'REAL',
        
        for B=1:size(bof,1)
            y = x(ceil(N*rand(N,1)));   % bootstrap resample

            ymins = unique(y);
            ymins = ymins(1:end-1);
            if ~isempty(xminx),
                ymins = ymins(find(ymins>=xminx,1,'first'));
            end;
            if ~isempty(limit),
                ymins(ymins>limit) = [];
            end;
            if ~isempty(sample),
                ymins = ymins(unique(round(linspace(1,length(ymins),sample))));
            end;
            dat   = zeros(size(ymins));
            z     = sort(y);
            for xm=1:length(ymins)
                xmin = ymins(xm);
                z    = z(z>=xmin); 
                n    = length(z);
                % estimate alpha using direct MLE
                a    = n ./ sum( log(z./xmin) );
                % compute KS statistic
                cx   = (0:n-1)'./n;
                cf   = 1-(xmin./z).^a;
                dat(xm) = max( abs(cf-cx) );
            end;
            ymin  = ymins(find(dat<=min(dat),1,'first'));
            z     = y(y>=ymin);
            n     = length(z); 
            alpha = 1 + n ./ sum( log(z./ymin) );
            % store distribution of estimated parameter values
            bof(B,:) = [n ymin alpha];
            if ~quiet && B>1,
                fprintf('[%i]\tntail = %3.1f (%3.1f)\txmin = %3.1f (%3.1f)\talpha = %6.4f (%6.4f)\t[%4.2fm]\n',B,mean(bof(1:B,1)),std(bof(1:B,1)),mean(bof(1:B,2)),std(bof(1:B,2)),mean(bof(1:B,3)),std(bof(1:B,3)),toc/60);
            end;
        end;
        n     = std(bof(:,1));
        xmin  = std(bof(:,2));
        alpha = std(bof(:,3));
        
    case 'INTS',
        
        if isempty(vec),
            vec  = (1.50:0.01:3.50);    % covers range of most practical 
        end;                            % scaling parameters
        zvec = zeta(vec);

        for B=1:size(bof,1)
            y = x(ceil(N*rand(N,1)));   % bootstrap resample

            ymins = unique(y);
            ymins = ymins(1:end-1);
            if ~isempty(xminx),
                ymins = ymins(find(ymins>=xminx,1,'first'));
            end;
            if ~isempty(limit),
                limit = round(limit);
                ymins(ymins>limit) = [];
            end;
            if ~isempty(sample),
                ymins = ymins(unique(round(linspace(1,length(ymins),sample))));
            end;
            ymax  = max(y);
            dat   = zeros(length(ymins),2);
            z     = y;
            for xm=1:length(ymins)
                xmin = ymins(xm);
                z    = z(z>=xmin);
                n    = length(z);
                % estimate alpha via direct maximization of likelihood function
                try
                    % vectorized version of numerical calculation
                    zdiff = sum( repmat((1:xmin-1)',1,length(vec)).^-repmat(vec,xmin-1,1) ,1);
                    L = -vec.*sum(log(z)) - n.*log(zvec - zdiff);
                catch
                    % iterative version (more memory efficient, but slower)
                    L       = -Inf*ones(size(vec));
                    slogz   = sum(log(z));
                    xminvec = (1:xmin-1);
                    for k=1:length(vec)
                        L(k) = -vec(k)*slogz - n*log(zvec(k) - sum(xminvec.^-vec(k)));
                    end;
                end;
                [Y,I] = max(L);
                % compute KS statistic
                fit = cumsum((((xmin:ymax).^-vec(I)))./ (zvec(I) - sum((1:xmin-1).^-vec(I))));
                cdi = cumsum(hist(z,xmin:ymax)./n);
                dat(xm,:) = [max(abs( fit - cdi )) vec(I)];
            end
            [D,I] = min(dat(:,1));
            ymin  = ymins(I);
            n     = sum(y>=ymin);
            alpha = dat(I,2);
            % store distribution of estimated parameter values
            bof(B,:) = [n ymin alpha];
            if ~quiet && B>1,
                fprintf('[%i]\tntail = %3.1f (%3.1f)\txmin = %3.1f (%3.1f)\talpha = %6.4f (%6.4f)\t[%4.2fm]\n',B,mean(bof(1:B,1)),std(bof(1:B,1)),mean(bof(1:B,2)),std(bof(1:B,2)),mean(bof(1:B,3)),std(bof(1:B,3)),toc/60);
            end;
        end;
        n     = std(bof(:,1));
        xmin  = std(bof(:,2));
        alpha = std(bof(:,3));
        
    otherwise,
        fprintf('(PLVAR) Error: x must contain only reals or only integers.\n');
        alpha = [];
        xmin  = [];
        n     = [];
        return;
end;

