function closenesscentrality_gap
%CLOSENESSCENTRALITY_GAP Closeness centrality for the gap junction network.
%   CLOSENESSCENTRALITY_GAP lists the closeness centrality ranking of the 
%   gap junction network.  
%
%   See also CLOSENESSCENTRALITY_CHEM.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

%load the gap junction network adjacency matrix
[A,Neuron_ordered] = datareader('gap','unweighted');

%get the giant component
[S,C] = graphconncomp(A);
gc = mode(C);
Agc = A(find(C==gc),find(C==gc));

%names of neurons in giant component
labels = Neuron_ordered(find(C==gc));

%geodesic distance matrix of giant component
D = graphallshortestpaths(Agc);

%compute the normalized closeness for each node in giant component
close = zeros(1,length(D));
for ii = 1:length(D)
    close(ii) = sum(D(ii,:))./(length(D)-1);
end

%list the neurons in order of normalized closeness centrality
[yy,iii] = sort(close);
for ii = 1:length(iii)
    fprintf('%s  \t  %0.4g\n',labels{iii(ii)},1./close(iii(ii)));
end

%degree centrality for the giant component
deg = sum(Agc);
[zz,jjj] = sort(1./deg);

%compare the normalized closeness centrality to the degree centrality
deg_close_corr = corrcoef(deg,1./close)