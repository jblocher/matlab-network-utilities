% Computes clustering coefficient, based on triangle motifs count and local clustering
% C1 = num triangle loops / num connected triples
% C2 = the average local clustering, where Ci = (num triangles connected to i) / (num triples centered on i)
% Ref: M. E. J. Newman, "The structure and function of complex networks"
% Valid for directed and undirected graphs
% INPUT: adjacency matrix representation of a graph
% OUTPUT: graph average clustering coefficient and clustering coefficient
%
% Gergana Bounova, October 9, 2009

function [C1,C2,C] = clust_coeff(adj)

n = length(adj);
adj = adj>0;
[deg,indeg,outdeg] = degrees(adj);
C=zeros(n,1); % initialize clustering coefficient

% multiplication change in the clust coeff formula
if isdirected(adj)
    coeff=1;
else
    coeff=2;
end

for i=1:n
    neigh=kneighbors(adj,i,1);
    adj_s=subgraph(adj,neigh);
    edges_s=numedges(adj_s);
    if deg(i)==1 | deg(i)==0
        C(i)=0;
        continue
    end
    C(i)=coeff*edges_s/deg(i)/(deg(i)-1);
end

C1=loops3(adj)/num_conn_triples(adj);
C2=sum(C)/n;