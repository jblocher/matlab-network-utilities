% The vector corresponding to the second smallest eigenvalue of the Laplacian matrix
% INPUTs: adjacency matrix (nxn)
% OUTPUTs: fiedler vector (nx1)

function fv=fiedler_vector(adj)

L=laplacian_matrix(adj);
[V,D]=eig(L);

[ds,Y]=sort(diag(D));
fv=V(:,Y(2));