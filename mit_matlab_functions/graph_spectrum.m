% The eigenvalues of the Laplacian of the graph
% INPUTs: adjacency matrix
% OUTPUTs: laplacian eigenvalues, sorted

function s=graph_spectrum(adj)

L=laplacian_matrix(adj);
[v,D]=eig(L);
s=sort(diag(D));