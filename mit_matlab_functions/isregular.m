% Checks whether a graph is regular, i.e. every node has the same degree.
% Defined for unweighted graphs only.
% INPUTS: adjacency matrix nxn
% OUTPUTS: Boolean, yes/no
% Gergana Bounova, Last updated: October 1, 2009

function S=isregular(adj)

S=true;

adj=adj>0; % remove weights
degs=sum(adj);
for i=1:length(adj)
    if not(degs(i)==degs(1))
        S=false;
        return
    end
end