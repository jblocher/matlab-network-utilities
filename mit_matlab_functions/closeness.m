% Computes the closeness centrality for every vertex: 1/sum(dist to all other nodes)
% For disconnected graphs can use: sum_over_t(2^-d(i,t)), idea Dangalchev (2006)
% INPUTs: graph representation (adjacency matrix nxn)
% OUTPUTs: vector of centralities, nx1
% Source: social networks literature
% 
% Gergana Bounova, Last updated: October 9, 2009

function C=closeness(adj)

n=numnodes(adj);
C=zeros(n,1);

for i=1:n
    d=simple_dijkstra(adj,i);
    C(i)=1/sum(d);    % C(i)=sum(2.^(-d)) if disconnected, but sum w/o d(i)
end