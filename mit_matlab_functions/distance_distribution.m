% The number of pairs of nodes at a distance x, divided by the total number of pairs n(n-1)
% Source: Mahadevan et al, "Systematic Topology Analysis and Generation Using Degree Correlations"
% INPUTS: adjacency matrix, (nxn)
% OUTPUTS: distribution vector ((n-1)x1): {k_i} where k_i is the # of pairs at a distance i, normalized

function ddist=distance_distribution(adj)

n=numnodes(adj);

dij=[];
for i=1:n
    d=simple_dijkstra(adj,i);
    dij=[dij; d];
end

for i=1:n-1
    ddist(i)=length(find(dij==i));
end
ddist=ddist/n/(n-1);