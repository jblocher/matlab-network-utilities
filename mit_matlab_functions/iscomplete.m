% Checks whether a (sub)graph is complete, i.e. whether every node is
% linked to every other node. Only makes sense for unweighted graphs.
% INPUTS: adjacency matrix, adj, nxn
% OUTPUTS: Boolean variable, true/false
% Gergana Bounova, Last Updated: October 1, 2009

function S=iscomplete(adj)

S=false; % default

adj=adj>0;  % remove weights
n=numnodes(adj);

if sum(adj)==ones(1,n)*(n-1) | sum(adj)==ones(1,n)*n % or w/ n selfloops
    S=true;
end