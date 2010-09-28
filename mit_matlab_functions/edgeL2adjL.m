% Converts an edgelist to an adjacency list
% INPUTS: edgelist, (mx3)
% OUTPUTS: adjacency list
% Gergana Bounova, Last updated: October 13, 2006

function adjL = edgeL2adjL(el)

nodes = unique([el(:,1)' el(:,2)']);
n = numel(nodes); % number of nodes
adjL=cell(n,1);

for e=1:length(el)
    adjL{el(e,1)}=[adjL{el(e,1)},el(e,2)];
end