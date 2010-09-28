% test script for Louvain to profile the matlab code

profile on;
profile('-memory','on');
setpref('profiler','showJitLines',1);
A = erdrey(1000);
COMTY = cluster_jl_orientT(A);
p = profile('info');
save nwstats_1000prof p;
profile off;