% Betweenness centrality measure: number of shortest paths running though a
% vertex. Output for all vertices.
% Jesse Blocher December 2009

function btwn = betweenness_fast(adj)

% inputs: adjacency (distances) matrix N x N
% outputs: betweeness measures vector for all vertices 1 X N
% use dijkstra shortest path algorithm which produces a N x N cell array of shortest paths
% Then, use cellfun to process those paths - first, remove endpoints, 


if ~isconnected(adj)
	warning('Graph not connected in betweenness_fast. Extracting Giant Component.');
	comp = giant_component(adj);
else
	comp = adj;
end;
[dij paths] = dijkstra(comp, comp);

remove_endpoints = cellfun(@getMiddle, paths, 'UniformOutput', false);
btwn = zeros(1,length(comp));
for i=1:length(comp)
    btwn(i) = getBetweenness(i, remove_endpoints, comp);
end;


