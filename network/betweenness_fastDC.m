% Betweenness centrality measure: number of shortest paths running though a
% vertex. Output for all vertices.
% Jesse Blocher December 2009
% Added Distributed Computing to see if it speeds up

%function btwn = betweenness_fastDC(adj)

% inputs: adjacency (distances) matrix N x N
% outputs: betweeness measures vector for all vertices 1 X N
% use dijkstra shortest path algorithm which produces a N x N cell array of shortest paths
% Then, use cellfun to process those paths - first, remove endpoints, 

%{
if ~isconnected(adj)
	warning('Graph not connected in betweenness_fast. Extracting Giant Component.');
	comp = giant_component(adj);
else
	comp = adj;
end;
%}
[dij paths] = dijkstra(comp, comp);
remove_endpoints = cellfun(@getMiddle, paths, 'UniformOutput', false);

%btwn = zeros(1,length(comp));
jm = findResource('scheduler','configuration','local');
job1 = createJob(jm, ...
		'FileDependencies', {'findNode.m','removeDiagonal.m','getBetweenness.m'} ...
		);

for i=1:length(comp)
   createTask(job1, @getBetweenness, 1, {i, remove_endpoints, comp});
end;
submit(job1);
waitForState(job1)
btwn = getAllOutputArguments(job1);
%destroy(job1);

