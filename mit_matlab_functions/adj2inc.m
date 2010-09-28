% This program converts an adjacency matrix representation to an incidence
% Convert adjacency matrix to an incidence matrix
% Valid for directed/undirected, simple/not simple graph
% INPUTs: adjacency matrix, NxN, N - number of nodes
% OUTPUTs: incidence matrix: N x number of edges
% Gergana Bounova, Last Updated: October 3, 2009

function inc = adj2inc(adj)

n=numnodes(adj);
m=numedges(adj);
inc=zeros(n,m);  % initialize incidence matrix
edges=find(adj>0);

if isdirected(adj)
    for e=1:m
        [i,j]=ind2ij(edges(e),n,n);
        inc(i,e)=-1;
        inc(j,e)=1;
    end
else
    cnt=0; % counting edges
    for e=1:length(edges)
        [i,j]=ind2ij(edges(e),n,n);
        ind_sym=ij2ind(j,i,n,n);
        if ind_sym<edges(e) % already accounted for
            continue
        end
        cnt=cnt+1;
        inc(i,cnt)=1;
        inc(j,cnt)=1;
    end
end