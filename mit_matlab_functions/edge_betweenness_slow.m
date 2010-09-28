% Betweenness centrality measure: number of shortest paths running though an edge. Compute for all edges.
% Note: Valid for a general graph. Using 'number of shortest paths through an edge' definition
% INPUTS: adjacency (distances) matrix (nxn)
% OUTPUTS: edge list in which the weights are betweeness values (mx3)
%
% Gergana Bounova, October 17, 2009

function elb = edge_betweenness_slow(adj)

n=numnodes(adj);
adjb=zeros(n); % use the adjacency matrix to store the betweenness

spaths=inf(n,n);
% calculate number of shortest paths
for k=1:n-1
  adjk=adj^k;
  for i=1:n
    for j=1:n
      if adjk(i,j)>0
        spaths(i,j)=min([spaths(i,j) adjk(i,j)]);
      end
    end
  end
end

for i=1:n
    [J_st,route_st,J,route]=shortest_pathDP(adj,i,i,n);
    for j=1:n
        if i==j
            continue
        end
        [J_ji,step_ind] = min(J(:,j));
        route_ji = [j, route(step_ind,j).path];
        for k=1:length(route_ji)-1
            adjb(route_ji(k),route_ji(k+1))=adjb(route_ji(k),route_ji(k+1))+1/spaths(j,i);
        end
    end
end

elb=adj2edgeL(adjb);
elb(:,3)=elb(:,3)/nchoosek(n,2);  % divide by the total number of node pairs (paths)