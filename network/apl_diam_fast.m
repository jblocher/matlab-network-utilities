% Compute average path length for a network - the average shortest path
% AND Diameter - minimizes use of Dijkstra method.
% Updated to use faster Dijkstra method from Matlab Central by Joseph Kirk.
% INPUTS: adjL - matrix of weights/distances between nodes
% OUTPUTS: average path length: the average of the shortest paths between every two edges
% Note: works for directed/undirected networks

% The longest shortest path between any two nodes nodes in the network
% INPUTS: adjacency matrix, adj
% OUTPUTS: network diameter, diam
% Jesse Blocher, Dec 2009. 


function [l diam] = apl_diam_fast(adj)
if ~isconnected(adj)
	error('Adjacency matrix not connected for computation of path length and diameter');
end;
n=numnodes(adj);
dij = dijkstra(adj, adj);
diam = max(max(dij));
l=sum(sum(dij))/(n^2-n); % sum and average across everything but the diagonal