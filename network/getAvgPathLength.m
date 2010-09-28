% Compute average path length for a network - the average shortest path
% Updated to use faster Dijkstra method from Matlab Central by Joseph Kirk.
% INPUTs: 	adj: adjacency matrix N X N
%			dij (optional): distance from each node i to each node j from a shortest path algo N x N
% OUTPUTs: scalar l which is avg path length for network
% Jesse Blocher, Dec 2009. 

function l = apl_diam_fast(adj, dij)
if nargin < 2
    dij = sparse(all_shortest_paths(adj));
end;
if ~isconnected(adj)
	%if graph is not connected distance from i to j can be Inf and blow up this calc.
	dij = removeInf(dij);
end;
n=num_vertices(adj);
l=sum(sum(dij))/(n^2-n); % sum and average across everything but the diagonal