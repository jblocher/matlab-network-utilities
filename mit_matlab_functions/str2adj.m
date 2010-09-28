% Converts a string graph representation to an adjacency matrix
% Note: The string nomenclature is arbitrary
% INPUTs: string variable of the format: .i1.j1.k1,.i2.j2.k2,....
% OUTPUTs: adjacency matrix, nxn
% Valid for a general graph
% Gergana Bounova, October 6, 2009

function adj = str2adj(str)

commas=find(str==',');
n=length(commas); % number of nodes
adj=zeros(n); % initialize adjacency matrix

% Extract the neighbors of the first node only
neigh=str(1:commas(1)-1);
dots=find(neigh=='.');
for d=1:length(dots)-1
    adj(1,str2num(neigh(dots(d)+1:dots(d+1)-1)))=1;
end
adj(1,str2num(neigh(dots(length(dots))+1:length(neigh))))=1;

% Extract the neighbors of the remaining 2:n nodes
for i=2:n
    neigh=str(commas(i-1)+1:commas(i)-1)
    dots=find(neigh=='.');
    for d=1:length(dots)-1
        adj(i,str2num(neigh(dots(d)+1:dots(d+1)-1)))=1;
    end
    adj(i,str2num(neigh(dots(length(dots))+1:length(neigh))))=1;
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