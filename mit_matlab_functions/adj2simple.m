% Convert an adjacency matrix of a general graph to the adjacency matrix of
% a simple graph (no loops, no double edges) - great for quick data clean up
% INPUTS: adjacency matrix
% OUTPUTs: adjacency matrix of the corresponding simple graph
% Gergana Bounova, Last updated: October 4, 2009

function adj=adj2simple(adj)

adj=adj>0;% make all edges weight 1

% clear the diagonal (selfloops)
ind=find(diag(adj)==1);
for i=1:length(ind)
    adj(ind(i),ind(i))=0;
end