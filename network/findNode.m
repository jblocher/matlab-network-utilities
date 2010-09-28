function boolHere = findNode(vec, num)
%A cellarray find function to determine if a node is in a path for
%betwenness calculation
% input: vector vec is any vector
%		 num is a number to be found in the vector
% output: boolean T/F if it is there or not
% J Blocher December 2009
boolHere = ~isempty(find(vec == num, 1));