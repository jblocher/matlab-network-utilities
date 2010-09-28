% Compute the rich club metric for a graph
% INPUTs: adjacency matrix, nxn, k - threshold number of links
% OUTPUTs: rich club metric
% Source: Colizza, Flammini, Serrano, Vespignani, "Detecting rich-club
% ordering in complex networks", Nature Physics, vol 2, Feb 2006
% Gergana Bounova, Last updated: October 16, 2009

function phi=rich_club_metric(adj,k)

[deg,indeg,outdeg]=degrees(adj);

Nk=find(deg>k);       % find the nodes with degree > k

adjk=subgraph(adj,Nk);
Ek=numedges(adjk);    % find the # of edges among nodes with deg > k

phi=2*Ek/length(Nk)/(length(Nk)-1);