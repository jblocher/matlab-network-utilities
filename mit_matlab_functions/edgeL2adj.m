% Converts edge list to adjacency matrix
% INPUTS: edgelist: mx3
% OUTPUTS: adjacency matrix nxn
% Note: information about nodes is lost: indices only (i1,...in) remain
% Gergana Bounova, Last updated: October 6, 2009

function adj=edgeL2adj(el)

nodes=sort(unique([el(:,1) el(:,2)])); % get all nodes, sorted
n=numel(nodes); % number of unique nodes
adj=zeros(n);   % initialize adjacency matrix

for i=1:size(el,1) % across all edges
  adj(find(nodes==el(i,1)),find(nodes==el(i,2)))=el(i,3);
end