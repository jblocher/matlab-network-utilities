% Routine implementing a simple preferential attachment (B-A) model for network growth
% INPUTs: n - final number of vertices, m - # edges to attach at every step
%   %  probability a new vertex attaches to a given old vertex is proportional to the (total) vertex degree
% OUTPUTs: edge list
% NOTE: Assume undirected simple graph
% source: "The Structure and Function of Complex Networks", M.E.J. Newman
%         "Emergence of Scaling in Random Networks" B-A.
% Gergana Bounova, Last modified: March 18, 2006

function el = preferential_attachment(n,m)

% THIS INITIAL CONDITION IS ARBITRARY ======================
vertices = 2;
if not(vertices<=n & m<=vertices)
    'the number of final nodes is larger than the initial'
    ' or there are more edges to attach than nodes'
    return
end
el=[1 2 1; 2 1 1];  % add one edge for starters
% ==========================================================

while vertices < n
    vertices=vertices+1;  % add new vertex

    deg=[];             % compute nodal degrees for this iteration =======
    for v=1:vertices
        deg=[deg; v numel(find(el(:,1)==v))];
    end
    deg=sortrows(deg);  % the total degree - only works for a simple undirected graph
    
    % add "m" edges
    connected=[];
    while length(connected)<m
        ind=ceil(random_number*(vertices-1));  % pick a random old vertex
        if isempty(find(connected==ind)) & rand < deg(ind,2)/sum(deg(:,2))
            el=[el; ind vertices 1];
            el=[el; vertices ind 1]; % symmetrize
    
            connected=[connected ind];
        end
    end
end