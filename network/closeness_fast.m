% Computes the closeness centrality for every vertex: 1/sum(dist to all other nodes)
% For disconnected graphs can use: sum_over_t(2^-d(i,t)), idea Dangalchev (2006)
% INPUTs: graph representation (adjacency matrix nxn)
% OUTPUTs: vector of centralities, nx1
% Source: social networks literature
% 
% Gergana Bounova, Last updated: October 9, 2009
% new Dijkstra algorithm used by J Blocher December 2009.

function C=closeness_fast(adj)

dij = dijkstra(adj, adj);
C = 1./sum(dij,2);
