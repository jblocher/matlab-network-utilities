% This program extracts an adjacency matrix from a pajek text (.net) file
% INPUT .net text filename, n - number of nodes in the graph
% OUTPUT: adjacency matrix, nxn, n - # nodes
% Note: It is much easier to read the edge list from text so this routine
% uses pajek2edgeL.m
% Gergana Bounova, October 7, 2009

function adj = pajek2adj(filename,n)

el=pajek2edgeL(filename,n);
adj=edgeL2adj(el);