% Convert an adjacency list to an adjacency matrix
% INPUTS: adjancency matrix: nxn
% OUTPUTS: adjacency list {n}
% Note: short lines but not very good variable space management
% Gergana Bounova, Last updated: October 6, 2009

function adj=adjL2adj(adjL)

for i=1:length(adjL)
    for j=1:length(adjL{i})
        adj(i,adjL{i}(j))=1;
    end
end

% for undirected graphs, this routine may result in non-square matrices
n=size(adj,1);
m=size(adj,2);

if not(m==n)    % add zeros to square
    if n<m      % add m-n rows
        adj=[adj; zeros(m-n,m)];
    elseif m<n  % add n-m columns
        adj=[adj, zeros(n,n-m)];
    end
end