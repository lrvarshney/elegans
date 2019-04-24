function tripletcount = tripCount_gap(varargin)
%TRIPCOUNT_GAP The counts of the triplets of the gap junction network.
%   T = TRIPCOUNT_GAP calculates the subgraph distribution over three nodes 
%   for the gap junction network.  
%
%   T = TRIPCOUNT_GAP(A) calculates the subgraph distribution over three 
%   nodes of an undirected network with adjacency matrix A.
%
%   See also TRIPCOUNT_CHEM.

%   Copyright 2006-2009.
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

%adjacency matrix
if (nargin == 0)
    %load the gap junction network
    A = datareader('gap','unweighted');
elseif (nargin == 1)
    A = varargin{1};
else
    error('TRIPCOUNT_GAP: incorrect number of inputs');
end

D = (1-A).*(1-A)'; D = D - D.*eye(size(D));
U = A.*(1-A)';
B = A.*A';

tripletcount(1) = 1/6*sum(sum(D.*(D^2)));  %zero edges
tripletcount(2) = 1/2*sum(sum(B.*(D^2)));  %one edge
tripletcount(3) = 1/2*sum(sum(D.*(B^2)));  %two edges
tripletcount(4) = 1/6*sum(sum(B.*(B^2)));  %three edges