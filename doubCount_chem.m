function doubletcount = doubCount_chem(varargin)
%DOUBCOUNT_CHEM The counts of the doublets of the chemical network.
%   D = DOUBCOUNT_CHEM calculates the subgraph distribution over two nodes 
%   for the chemical network.  D(1) is no connections, D(2) is
%   uni-directional connections, and D(3) is bi-directional connections.
%
%   D = DOUBCOUNT_CHEM(A) calculates the subgraph distribution over two 
%   nodes of a directed network with adjacency matrix A.  D(1) is no 
%   connections, D(2) is uni-directional connections, and D(3) is 
%   bi-directional connections.
%
%   See also DOUBCOUNT_JOINT.

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
    error('DOUBCOUNT_CHEM: incorrect number of inputs');
end

D = (1-A).*(1-A)'; D = D - D.*eye(size(D));
U = A.*(1-A)';
B = A.*A';

doubletcount(1) = 1/2*sum(sum(D));  % = 1/2*trace(D^2);  unconnected
doubletcount(2) = sum(sum(U));      % = trace(U*U');     unidirectional
doubletcount(3) = 1/2*sum(sum(B));  % = 1/2*trace(B^2);  bidirectional