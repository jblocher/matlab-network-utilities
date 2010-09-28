function out = seconds2human(secs)
%SECONDS2HUMAN( seconds )   Converts the given number of seconds into a 
%                           human-readable string.
%
%   str = SECONDS2HUMAN(seconds) returns a human-readable string from a
%   given (usually large) amount of seconds. For example, 
%
%       str = seconds2human(1463456.3)
%
%   returns the string [str], equal to
%
%       '2 weeks, 2 days, 22 hours, 30 minutes, 56 seconds.'
%
%   The input may be an Nx1-vector, in which case the output is an
%   Nx1 cell array of the corresponding strings. 
%
%   SECONDS2HUMAN defines one month as an "average" month, which means that
%   the string 'month' indicates 30.471 days. 


%   Author: Rody P.S. Oldenhuis
%   Delft University of Technology
%   E-mail: oldenhuis@dds.nl
%   Last edited 18/Feb/2009.

    % define some intuitive variables
    Seconds   = round(1                 );
    Minutes   = round(60     * Seconds  ); 
    Hours     = round(60     * Minutes  );
    Days      = round(24     * Hours    ); 
    Weeks     = round(7      * Days     ); 
    Months    = round(30.471 * Days     );
    Years     = round(365.26 * Days     );
    Centuries = round(100    * Years    );
    Millennia = round(10     * Centuries);

    % put these into an array, and define associated strings
    units   = [Millennia, Centuries, Years, Months, Weeks, ...
               Days, Hours, Minutes, Seconds];
    singles = {'millennium'; 'century'; 'year'; 'month'; ...
               'week'; 'day'; 'hour'; 'minute'; 'second'};
    plurals = {'millennia' ; 'centuries'; 'years'; 'months'; ...
               'weeks'; 'days'; 'hours'; 'minutes'; 'seconds'};

    % cut off all decimals from the given number of seconds
    secs = round(secs);

    % pre-allocate appropriate output-type
    numstrings = size(secs, 1);    
    if (numstrings > 1) 
        out = cell(numstrings, 1);   
    end
    
    % build (all) output string(s)    
    for j = 1:numstrings
        
        % initialize nested loop       
        string = [];
        secsj  = secs(j, 1);
        
        % build string for j-th amount of seconds
        for i = 1:length(units)
            amount = fix(secsj/units(i));
            if amount > 0
                
                % append (single or plural) unit of time to string
                if (amount > 1)
                    string = [string, num2str(amount), ' ', plurals{i}];%#ok
                else
                    string = [string, num2str(amount), ' ', singles{i}];%#ok
                end
                
                % determine whether the ending should be a period (.) or a comma (,)
                if rem(secsj, units(i))
                    ending = ', ';
                else
                    ending = '.';
                end
                
                % append string 
                string = [string, ending];%#ok
                
            end
            
            % subtract this step from given amount of seconds
            secsj = secsj - amount*units(i);
        end
        
        % insert in output cell, or set output string
        if (numstrings > 1)
            out{j} = string;
        else
            out = string;
        end        
    end
end
%{
Copyright (c) 2009, Rody Oldenhuis
All rights reserved.

Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are 
met:

    * Redistributions of source code must retain the above copyright 
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright 
      notice, this list of conditions and the following disclaimer in 
      the documentation and/or other materials provided with the distribution
      
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
POSSIBILITY OF SUCH DAMAGE.

%}