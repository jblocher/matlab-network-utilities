function dij_finite = removeInf(dij_inf)
%removes inf values from distance matrix

dij_finite = dij_inf.*(dij_inf < inf);
%that multiplied 0*inf = NaN, so set NaN = 0;
dij_finite(isnan(dij_finite)) = 0;
