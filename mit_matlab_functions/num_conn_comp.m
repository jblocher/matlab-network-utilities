% Calculate the number of connected components using the Laplacian
% eigenvalues - counting the number of zeros
% INPUTS: adjacency matrix
% OUTPUTs: positive integer - number of connected components
% Gergana Bounova, Last updated: October 22, 2009

function nc=num_conn_comp(adj)

s=graph_spectrum(adj);
nc=numel(find(s<10^(-5)));   % zero eigenvalues are not really zero in matlab