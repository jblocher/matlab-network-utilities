function adj_r = removeDiagonal(adj)
%sets the diagonal of a N x N adjacency matrix equal to all 0

adj_r = (eye(size(adj)) == 0).*adj;