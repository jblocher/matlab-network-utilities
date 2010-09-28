% Computes the average degree of neighboring nodes for every vertex
% INPUTs: adjacency matrix
% OUTPUTs: average neighbor degree vector nx1
% Gergana Bounova, Last updated: October 8, 2009

function ave_n_deg=ave_neighbor_deg(adj)

n=numnodes(adj);
ave_n_deg=zeros(1,n);
[deg,indeg,outdeg]=degrees(adj);

for i=1:n
  neigh=kneighbors(adj,i,1);
  if isempty(neigh)
      ave_n_deg(i)=0;
  else
      ave_n_deg(i)=sum(deg(neigh))/length(neigh);
  end
end