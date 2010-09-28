% Using the matrix symmetry condition. For other data structures, convert
% to matrix and use issymmetric, or write your own ...
% INPUTS: adjacency matrix
% OUTPUTS: boolean variable
% Gergana Bounova, Last updated: October 1, 2009

function S=isdirected(adj)

S=not(issymmetric(adj));