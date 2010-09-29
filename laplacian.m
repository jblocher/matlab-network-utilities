function L = laplacian(A)
% LAPLACIAN Compute the Laplacian matrix for a graph.
%
% L = laplacian(A) computes the weighted Laplacian matrix for a symmetric
% adjenceny matrix A.
%
% If A has unit weights, then the Laplacian is unweighted. 
%

% 
% David Gleich
% October 29th, 2005
%

L = diag(sum(A,2)) - A;