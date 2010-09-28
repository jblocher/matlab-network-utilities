% Converts index to (i,j) entry in a (ixj) matrix
% INPUTS: index, and matrix size (m,n)
% OUTPUTS: i,j coordinates of ind
% Gergana Bounova, Last Updated: January 13, 2007


function [i,j]=ind2ij(ind,m,n)

if ind>m*n
  'index bigger than matrix size'
  return
end

if mod(ind,m)==0
  i=m;
  j=ind/m;
elseif mod(ind,m)>0
  i=mod(ind,m);
  j=1+(ind-i)/m;
end