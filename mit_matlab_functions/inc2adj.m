% Converts an incidence matrix representation to an adjacency
% matrix representation for an arbitrary graph
% INPUTs: incidence matrix, nxm
% OUTPUTs: adjacency matrix, nxn
% Formula, source: mathworld.wolfram.com: ADJ=dual(INC*INC'-2I)
% Using this formula here causes infinite recursion
% Gergana Bounova, October 5, 2009

function adj = inc2adj(inc)

n = size(inc,1); % number of nodes
m = size(inc,2); % number of edges
adj = zeros(n);  % initialize adjacency matrix

if isempty(find(inc==-1))      % undirected graph
    for e=1:m
        ind=find(inc(:,e)==1);
        if length(ind)==2
            adj(ind(1),ind(2))=1;
            adj(ind(2),ind(1))=1;
        elseif length(ind)==1  % selfloop
            adj(ind,ind)=1;
        else
            'invalid incidence matrix'
            return
        end
    end
    return
else                           % directed graph
    for e=1:m
        ind1=find(inc(:,e)==1);
        indm1=find(inc(:,e)==-1);
        if isempty(indm1) & length(ind1)==1  % selfloop
            adj(ind1,ind1)=1;
        elseif length(indm1)==1 & length(ind1)==1
            adj(indm1,ind1)=1;
        else
            'invalid incidence matrix'
            return
        end
    end
end