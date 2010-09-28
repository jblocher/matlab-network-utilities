% Checks whether a graph is simple (no self-loops, no multiple edges)
% INPUTs: adj - adjacency matrix
% OUTPUTs: S - a Boolean variable
% Gergana Bounova, Last updated: October 1, 2009

function S = issimple(adj)

S=true;

% check for self-loops
sl=selfloops(adj);
if sl>0
    S=false;
    return
end

% check for double edges
me=multiedges(adj);
if me>0
    S=false;
    return
end