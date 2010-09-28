tic;
n=numnodes(adj_final);

dij=[];
    
for i=1:n
    d=simple_dijkstra(adj_final,i);
    diam = max(d);
    dij=[dij; d];
end
t = toc;
elapsed(t);


tic;
dij2 = zeros(n,n);
for i=1:n
    d2=simple_dijkstra(adj_final,i);
    diam2 = max(d2);
    dij2(i,:) = d2;
end

t2 = toc;
elapsed(t2);
%%
tic;
[costs ,paths] = dijkstra(adj_final, adj_final);
t3 = toc;
elapsed(t3);