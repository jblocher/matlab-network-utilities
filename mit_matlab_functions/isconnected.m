% Determine if a graph is connected:
% works by finding a zero eigenvalue and if the corresponding eigenvector
% has 0s, then a sum of non-zero number of rows/columns of the adjacency is
% 0 hence the degrees of these nodes are 0 and the graph is disconnected
% INPUTS: adjacency matrix
% OUTPUTS: Boolean variable {0,1}
% Courtesy of Dr. Daniel Whitney, (idea by Ed Schneiderman) circa 2006

function S = isconnected(adj)

n = length(adj);
x = zeros(n,1);
x(1)=1;

while 1
     y = x;
     x = adj*x + x;
     x = x>0;
     if x==y
         break
     end
end

if sum(x)<n
     S = false;
else
     S = true;
end


% Alternative 0 ==========================================================
% If the algebraic connectivity is > 0 then the graph is connected
% a=algebraic_connectivity(adj), if a>0, then return true

% Alternative 1 ==========================================================
% Uses the fact that multiplying the adj matrix to itself k times give the
% number of ways to get from i to j in k steps. If the end of the
% multiplication in the sum of all matrices there are 0 entries then the
% graph is disconnected. Computationally intensive, but can be sped up by
% the fact that in practice the diameter is very short compared to n, so it
% will terminate in order of 5 steps.
% function S=isconnected(el):
%     
%     S=false;
%     
%     adj=edgeL2adj(el);
%     n=numnodes(adj); % number of nodes
%     adjn=zeros(n);
% 
%     adji=adj;
%     for i=1:n
%         adjn=adjn+adji;
%         adji=adji*adj;
% 
%         if length(find(adjn==0))==0
%             S=true;
%             return
%         end
%     end

% Alternative 2 ==========================================================
% Find all connected components, if their number is 1, the graph is
% connected. Use find_conn_comp(adj)