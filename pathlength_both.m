function L = pathlength_both
%PATHLENGTH_BOTH The characteristic path length of the combined gap junction and chemical network.
%   L = PATHLENGTH_BOTH calculates the characteristic path length of the 
%   strong giant component of the combined gap junction and chemical network.
%
%   See also PATHLENGTH_CHEM, PATHLENGTH_GAP, GRAPHALLSHORTESTPATHS.

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

%characteristic path length
L = pathlength_chem(A);