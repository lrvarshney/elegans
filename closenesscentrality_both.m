function closenesscentrality_both

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

%adjacency matrix
A = datareader('gap','unweighted') + datareader('chem','unweighted') > 0;
[tmp,Neuron_ordered] = datareader('gap','unweighted');

%produce list
closenesscentrality_chem(A,Neuron_ordered);