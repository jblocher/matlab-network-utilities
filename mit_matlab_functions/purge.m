% Removes a subset from a set, but preserves order of elements
% Similar to setdiff - which reorders the elements
% INPUTs: original set A, subset to remove B
% OUTPUTs: new purged set Anew
% Gergana Bounova, Last updated: October 12, 2009

function Anew = purge(A,B)

Anew = [];
for a=1:numel(A)
    % remove element B(b)
    if isempty(find(B==A(a)))
        Anew=[Anew, A(a)];
    end
end