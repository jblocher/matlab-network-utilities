% Converts matrix coordinates to array index
% INPUTS: matrix coordinates i,j and matrix size (m,n)
% OUTPUTS: corresponding array index
% Gergana Bounova, Last Updated: October 2, 2009

function ind=ij2ind(i,j,m,n)

if i>m | j>n
  'coordinates larger than matrix size'
  return
end

ind=(j-1)*m+i;