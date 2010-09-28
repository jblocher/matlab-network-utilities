% The sum of products of degrees across all edges
% Source: "Towards a Theory of Scale-Free Graphs: Definition, Properties,
% and Implications", by Li, Alderson, Doyle, Willinger
% Note: The total degree is used regardless of whether the graph is directed or not.
% INPUTs: adjacency matrix
% OUTPUTs: s-metric

function s=s_metric(adj)

[deg,indeg,outdeg]=degrees(adj);
el=adj2edgeL(adj);

s=0;
for e=1:length(el)
    s=s+deg(el(e,1))*deg(el(e,2));
end

% ALTERNATIVE ================
% [deg,indeg,outdeg]=degrees(adj);
% edges=find(adj>0);
% s=0;
% for e=1:length(edges)
%     [i,j]=ind2ij(edges(e),n,n);
%     s=s+deg(i)*deg(j);
% end