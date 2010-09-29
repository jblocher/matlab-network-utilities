function L = laplacian(A)
% NLAPLACIAN Compute the normalized Laplacian matrix for a graph.
%
% L = nlaplacian(A) computes the weighted normalized Laplacian matrix for a 
% symmetric adjacency matrix A.
%
% If A has unit weights, then the Laplacian is unweighted. 
%

% 
% David Gleich
% October 29th, 2005
%

%
% History
%
% 10 May 2007 
% Fixed documentation about the code to talk about the normalized Laplacian.
%

d = sparse(sum(A,2));

L = diag(d) - A;
Dhalf = diag(sparse(1./sqrt(d)));
L = Dhalf*(L*Dhalf);

