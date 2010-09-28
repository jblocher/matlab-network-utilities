% The Laplacian matrix of a graph (the difference b/w the degree and the
% adjacency matrices) - note: this is the normalized Laplacian
% INPUTS: adjacency matrix
% OUTPUTs: Laplacian matrix

function L=laplacian_matrix(adj)

[deg,indeg,outdeg]=degrees(adj);
L=diag(deg)-adj;


% NORMALIZED Laplacian =============

% n=numnodes(adj);
% [deg,indeg,outdeg]=degrees(adj);

% L=zeros(n);
% edges=find(adj>0);
% 
% for e=1:length(edges)
%     [ii,jj]=ind2ij(edges(e),n,n);
%     if ii==jj
%         L(ii,ii)=1;
%         continue
%     end
%     L(ii,jj)=-1/sqrt(deg(ii)*deg(jj));
% end