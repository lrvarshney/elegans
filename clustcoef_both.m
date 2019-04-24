function C = clustcoef_both
%CLUSTCOEF_BOTH The clustering coefficient of the combined gap junction and chemical network.
%   L = CLUSTCOEF_CHEM calculates the clustering coefficient of the 
%   strong giant component of the combined gap junction and chemical network.
%
%   See also CLUSTCOEF_CHEM, CLUSTCOEF_GAP.

%   Copyright 2006-2008.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2008, in preparation.

%adjacency matrix
A = datareader('gap','unweighted') + datareader('chem','unweighted') > 0;

%clustering coefficient
C = clustcoef_chem(A);