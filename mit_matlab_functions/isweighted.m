% Check whether a graph is weighted, i.e not all edges are 0,1.
% INPUTS: edge list, m x 3
% OUTPUTS: Boolean variable, yes/no
% Gergana Bounova, Last updated: October 1, 2009

function S=isweighted(el)

S=false;

w=unique(el(:,3)); % unique edge weights only
if length(w)>1
    % there must be other weights than 1
    S=true;
end