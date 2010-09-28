% Random number generator between 1 and n, using the computer clock
% INPUTS - upper bound on random number, if not given returns number between 0 and 1
% OUTPUTS - random number between 1 and n (0 and 1 default)
% Gergana Bounova, October 24, 2005

function rn = random_number(n)

for m=1:10
    tic;
    for i=1:ceil(rand*100)
        (2*rand)^ceil(rand*100);
    end
    rnum(m) = toc;
end

ind=ceil(rand*length(rnum));
if nargin<1
    rn=rnum(ind)/max(rnum);
else
    rn = rnum(ind)*n/max(rnum);
end