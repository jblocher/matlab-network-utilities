% Symmetrize a non-symmetric matrix
% INPUTS: a matrix - nxn
% OUTPUT: corresponding symmetric matrix - nxn
% ASSUMPTION: This works for an adjacency matrix - if an edge exists in one
% direction, it will be placed in the other as well. For matrices in which
% mat(i,j)/=mat(j,i), it will pick the larger (nonzero) value to symmetrize
% - which may not be the desired effect in general.
% Gergana Bounova, Last Updated: October 1, 2009

function [adj_sym]=symmetrize(adj)

adj_sym=max(adj,transpose(adj));