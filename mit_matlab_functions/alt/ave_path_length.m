% Compute average path length for a network - the average shortest path
% INPUTS: adjL - matrix of weights/distances between nodes
% OUTPUTS: average path length: the average of the shortest paths between every two edges
% Note: works for directed/undirected networks
% Gergana Bounova, December 8, 2005

function l = ave_path_length(adj)

n=numnodes(adj);
if isconnected(adj) %this is faster if it is connected - added by JB
    dij = zeros(size(adj,1),size(adj,2));
else
    dij=[];
end;
for i=1:n
    d=simple_dijkstra(adj,i);
    dij=[dij; d];
end

l=sum(sum(dij))/(n^2-n); % sum and average across everything but the diagonal