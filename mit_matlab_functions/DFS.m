% Implementation of depth-first-search of a graph
% INPUTs: adjacency list, node index
% OUTPUTs: DFS tree

function Tc=DFS(adjL,i0)

discovered=[i0];
stack=[i0];
T=cell(length(adjL),1);

while not(isempty(stack))
    j=stack(length(stack)); stack=stack(1:length(stack)-1); % pop the back
    neigh=adjL{j};
    for nn=1:length(neigh)
        if isempty(find(discovered==neigh(nn)))
            T{neigh(nn)}=j;                     % re-assign the parent
            discovered=[discovered, neigh(nn)];
            stack=[stack, neigh(nn)];
        end
    end
end

% convert tree from parent to children's oriented tree
Tc=cell(length(T),1);
for t=1:length(T)
    if not(isempty(T{t}))
        Tc{T{t}}=[Tc{T{t}}, t];
    end
end
