% Check if a graph is Eulerian, i.e. it has an Eulerian circuit
% "A connected undirected graph is Eulerian if and only if every graph vertex has an even degree."
% "A connected directed graph is Eulerian if and only if every graph vertex has equal in- and out- degree."
% INPUTS: adjacency matrix
% OUTPUTS: Boolean variable
% Gergana Bounova, Last Updated: October 2, 2009


function S=iseulerian(adj)

S=false;

[degs,indeg,outdeg]=degrees(adj);
odd=find(mod(degs,2)==1);

if not(isdirected(adj)) & isconnected(adj) & isempty(odd) % if connected and all degrees are even
  S=true;
  return
elseif isdirected(adj) & isconnected(adj) & indeg==outdeg % connected and in-degrees equal out-degrees
  S=true;
  return
elseif isconnected(adj) & numel(odd)==2
  fprintf('there is an Eulerian trail from node %2i to node %2i\n',odd(1),odd(2));
  return
end