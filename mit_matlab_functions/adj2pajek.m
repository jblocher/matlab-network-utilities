% Converts an adjacency matrix representation to a Pajek .net read format
% INPUT: an adjacency matrix, nxn, a filename, string format, node coordinates (optional)
% OUTPUT: text format of Pajek readable .net file in the same directory
% EXAMPLE
% *Vertices    4
%        1 "v1"                                     0.1000    0.5000    0.5000
%        2 "v2"                                     0.1000    0.4975    0.5000
%        3 "v3"                                     0.1000    0.4950    0.5000
%        4 "v4"                                     0.1001    0.4925    0.5000
% *Edges
%       14       31 1 
%       46       51 1 
%       51       60 1 
% Gergana Bounova, October 7, 2009

% Note: to add node names, add one additional input variable, the list of
% names, indexed 1 through n, either vector or cell.

function []=adj2pajek(adj,filename,x,y,z)

n = numnodes(adj); % number of nodes 
fid = fopen(filename,'wt','native');

fprintf(fid,'*Vertices  %6i\n',n);
if nargin <=2  % no coordinates specified - select random x,y,z
  for i=1:n
    fprintf(fid,'     %3i %s                     %1.4f    %1.4f   %1.4f\n',i,strcat('"v',num2str(i),'"'),rand,rand,0);
  end
elseif nargin >2 & nargin < 5  % 2D only, z is unspecified, put everything in one plane.
  for i=1:n
    fprintf(fid,'     %3i %s                     %1.4f    %1.4f   %1.4f\n',i,strcat('"v',num2str(i),'"'),x(i),y(i),0);
  end
else % 3D coords
  for i=1:n
    fprintf(fid,'     %3i %s                     %1.4f    %1.4f   %1.4f\n',i,strcat('"v',num2str(i),'"'),x(i),y(i),z(i));
  end
end

fprintf(fid,'*Edges\n');
edges=find(adj>0);
for e=1:length(edges)
    [i,j]=ind2ij(edges(e),n,n);
    fprintf(fid,'    %4i   %4i   %2i\n',i,j,adj(i,j));
end

fclose(fid)