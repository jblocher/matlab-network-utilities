% Check whether a graph is a tree
% Source: "Intro to Graph Theory" by Bela Bollobas
% INPUTS: adjacency matrix
% OUTPUTS: Boolean variable
% Gergana Bounova, Last Updated: June 19, 2007

function S=istree(adj)

S=false;

if isconnected(adj) & numedges(adj)==numnodes(adj)-1
  S=true;
end