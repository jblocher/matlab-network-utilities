function [S V] = quickCorr(A)
%Computes a correlation matrix using SVD, so very fast.
% [S V] = quickCorr(A)
% A is input matrix, will compute correlations of the columns of A
%
% S is the diagonal matrix with eigenvalues on the diagonal
% V is the eigenvector matrix
% compute corr = V*S*S*V';

Anorm = A-repmat(mean(A,1),[size(A,1),1]);

Anorm=Anorm./repmat(sqrt(sum(Anorm.^2,1)),[size(A,1),1]);

[U,S,V]=svd(Anorm,'econ');