function bt = getBetweenness(i, remove_endpoints ,comp)
% Computes the betweenness of node i in cell array remove_endpoints derived from component comp
% Inputs:
% i is node i
% remove_endpoints is cell array of paths from i to j
% comp is connected component which generated remove_endpoints
% Outputs: bt is an integer count of every shortest path node is on.
% Note: This is not very fast.
disp(strcat('Computing betweenness for i:', num2str(i)));
btwn_chk = cellfun(@findNode, remove_endpoints, num2cell(i*ones(size(comp,1),size(comp,2))) );
bt = sum(sum(removeDiagonal(btwn_chk)))/2;
if issymmetric(comp)
    bt = bt/2; %this is to remove double counting
end;