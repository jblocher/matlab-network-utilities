% Computes the closeness centrality for every vertex: 1/sum(dist to all other nodes)
% if second arg, dij, is not included, it is computed by a (slow) dijkstra algorithm.
% INPUTs: 	adj: adjacency matrix N X N
%			dij (optional): distance from each node i to each node j from a shortest path algo N x N
% OUTPUTs: vector of centralities, N x 1
% Source: Moody notes
% 
% J. Blocher updated December 2009
function C=getAllCloseness(adj, dij)

if nargin < 2
    dij = sparse(all_shortest_paths(adj));
end

C = 1./sum(dij,2);
