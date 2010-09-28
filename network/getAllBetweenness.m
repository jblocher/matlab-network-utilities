% Betweenness centrality measure: number of shortest paths running though a
% vertex. Output for all vertices.
% Jesse Blocher December 2009

function btwn = getAllBetweenness(adj, conn_comp, paths)

% inputs: adjacency (distances) matrix N x N
% outputs: betweeness measures vector for all vertices 1 X N
% use dijkstra shortest path algorithm which produces a N x N cell array of shortest paths
% Then, use cellfun to process those paths - first, remove endpoints, 


if ~isconnected(adj)
	warning('Graph not connected in getAllBetweenness. Extracting Giant Component. All others set to 0');
	comp = getGiantComponent(adj, conn_comp);
else
	comp = adj;
end;
% if these are supplied use them (it's faster) else compute them
if nargin < 3
    [dij paths] = dijkstra(comp, comp);
    clear dij;
end;
if nargin < 2
	conn_comp = find_conn_comp(adj);
end;

remove_endpoints = cellfun(@getMiddle, paths, 'UniformOutput', false);
allnodes = [remove_endpoints{:}]; %removes diagonal i to i self-loops and endpoints
btwn = histc(allnodes, 1:length(adj));
if issymmetric(adj)
    %remove double-counting
    btwn = btwn/2;
end;
