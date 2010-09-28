% Extracts giant component from a network
% INPUTS: 	adjacency matrix, adj
%			optional comps, cell array of components from find_conn_comp
% OUTPUTS: giant comp matrix and node indeces
% J Blocher December 2009

function [GC,gc_nodes] = getGiantComponent(adj, ci, sizes)
% updated using Matlab BGL
if nargin < 2
	[ci sizes] = components(adj);
end;
[maxL,ind_max]=max(sizes);
gc_nodes=find(ci == ind_max)';
%this is Bounova - pretty trivial, though
GC=subgraph(adj,gc_nodes);