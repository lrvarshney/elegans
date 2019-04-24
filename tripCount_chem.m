function tripletcount = tripCount_chem(varargin)
%TRIPCOUNT_CHEM The counts of the triplets of the chemical network.
%   T = TRIPCOUNT_CHEM calculates the subgraph distribution over three nodes 
%   for the chemical network.  
%
%   T = TRIPCOUNT_CHEM(A) calculates the subgraph distribution over three 
%   nodes of a directed network with adjacency matrix A.
%
%   See also DOUBCOUNT_CHEM.

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
    %load the chemical network
    A = datareader('chem','unweighted');
elseif (nargin == 1)
    A = varargin{1};
else
    error('TRIPCOUNT_CHEM: incorrect number of inputs');
end

D = (1-A).*(1-A)'; D = D - D.*eye(size(D));
U = A.*(1-A)';
B = A.*A';

tripletcount(1) = 1/6*sum(sum(D.*(D^2)));
tripletcount(2) = sum(sum(U.*(D^2)));
tripletcount(3) = 1/2*sum(sum(B.*(D^2)));
tripletcount(4) = 1/2*sum(sum(D.*(U'*U)));
tripletcount(5) = 1/2*sum(sum(D.*(U*U')));
tripletcount(6) = sum(sum(D.*(U^2)));
tripletcount(7) = sum(sum(D.*(U*B)));
tripletcount(8) = sum(sum(D.*(U'*B)));
tripletcount(9) = 1/2*sum(sum(D.*(B^2)));
tripletcount(10) = sum(sum(U.*(U^2)));
tripletcount(11) = 1/3*sum(sum(U'.*(U^2)));
tripletcount(12) = 1/2*sum(sum(B.*(U'*U)));
tripletcount(13) = sum(sum(B.*(U^2)));
tripletcount(14) = 1/2*sum(sum(B.*(U*U')));
tripletcount(15) = sum(sum(U.*(B^2)));
tripletcount(16) = 1/6*sum(sum(B.*(B^2)));