function geodistDist_both
%GEODISTDIST_BOTH Plots the geodesic distance distribution for the combined gap junction and chemical network.
%   GEODISTDIST_BOTH produces a plot of the geodesic distance distribution 
%   of the combined gap junction and chemical network.  
%
%   See also GEODISTDIST_CHEM, GEODISTDIST_GAP.

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

%produce plot
geodistDist_chem(A);