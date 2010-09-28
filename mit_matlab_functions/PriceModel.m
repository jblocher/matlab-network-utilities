% Routine implementing the Price model for network growth
% INPUTs: n - final number of vertices
%   p_k - fraction of vertices with degree k
%   probability a new vertex attaches to any of the degree-k vertices is 
%   (k+1)p_k/(m+1), where m - mean number of new citations per vertex
% OUTPUTs: adjacency matrix, directed
% source: "The Structure and Function of Complex Networks", M.E.J. Newman
% Gergana Bounova, Last modified: March 18, 2006

function adj = PriceModel(n)

adj = zeros(n);
adj(1,1) = 1; 
vertices = 1;

while vertices < n
    % attach new vertex 
    vertices = vertices + 1;
    adj(vertices,vertices) = 1; 
    
    [deg,indeg,outdeg] = degrees(adj); % get indegree values
    m = 0; % mean in-degree (per vertex)
    for k=1:vertices
      pk(k) = numel(find(indeg==k))/vertices;
      m = m + pk(k)*k;
    end
    
    for i=1:vertices
        if rand < (i+1)*pk(i)/(m+1)
            adj(vertices,i)=adj(vertices,i)+1; % add a link
        end
    end

end
adj=adj-diag(diag(adj));  % remove 1s along the diagonal