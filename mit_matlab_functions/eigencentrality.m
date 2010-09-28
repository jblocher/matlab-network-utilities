% The ith component of the eigenvector corresponding to the greatest 
% eigenvalue gives the centrality score of the ith node in the network.
% INPUTs: adjacency matrix
% OUTPUTs: eigen(-centrality) vector
% Gergana Bounova, Last Updated: October 14, 2009
%TODO: rename so this is my own file J Blocher Dec 2009
function x=eigencentrality(adj)
if issparse(adj)
    [V,D]=eigs(adj);
else
    [V,D]=eig(adj);
end
[max_eig,ind]=max(diag(D));
x=V(:,ind);