% Convert an edge list of a general graph to the edge list of a simple 
% graph (no loops, no double edges) - great for quick data clean up
% INPUTS: edgelist (mx3), m - number of edges
% OUTPUTs: edge list of the corresponding simple graph
% Gergana Bounova, Last updated: October 4, 2009

function el=edgeL2simple(el)

m=length(el);  % number of edges
el(:,3)=ones(m,1);  % make all edge weights 1

ind=find(not(el(:,1)-el(:,2)==0));  % indices of the "non-self-loops"
el=el(ind,:);