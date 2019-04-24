function L = pathlength_chem(varargin)
%PATHLENGTH_CHEM The characteristic path length of the chemical network strong giant component.
%   L = PATHLENGTH_CHEM calculates the characteristic path length of the 
%   chemical network strong giant component.
%
%   L = PATHLENGTH_CHEM(A) calculates the characteristic path length of the
%   strong giant component of a directed network with adjacency matrix A.
%
%   See also PATHLENGTH_GAP, GRAPHALLSHORTESTPATHS.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

%adjacency matrix
if (nargin == 0)
    %load the chemical network
    A = datareader('chem','unweighted');
elseif (nargin == 1)
    A = varargin{1};
else
    error('PATHLENGTH_CHEM: incorrect number of inputs');
end

%get the giant component 
[S,C] = graphconncomp(A);
gc = mode(C);
Agc = A(find(C==gc),find(C==gc)); 

%geodesic distance matrix of giant component
D = graphallshortestpaths(Agc);

%characteristic path length
L = sum(sum(D))/(length(Agc)-1)/length(Agc);
