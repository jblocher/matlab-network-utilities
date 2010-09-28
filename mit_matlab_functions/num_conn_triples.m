% Counts the number of connected triples in a graph
% INPUTs: adjacency matrix
% OUTPUTs: integer - num conn triples
% Gergana Bounova, Last updated: October 9, 2009

function c=num_conn_triples(adj)

c=0;
for i=1:length(adj)
    neigh=kneighbors(adj,i,1);
    if length(neigh)<2
        continue % handle leaves, no triple here
    end
    c=c+nchoosek(length(neigh),2);
end
c=c-2*loops3(adj); % due to the symmetry triangles repeat 3 times in the nchoosek count