function [a,b,c] = degDistCorr(varargin)
%DEGDISTCORR Lists correlation coefficients among degree distributions.
%   [C1,C2,C3] = DEGDISTCORR produces the correlation coefficient between
%   the gap junction degree and the chemical in-degree as C1, the gap
%   junction degree and the chemical out-degree as C2, and the chemical in-
%   and out-degree as C3.
%
%   [C1,C2,C3] = DEGDISTCORR(A,B) produces the correlation coefficient
%   between the degree of an undirected graph A and the in-degree of a
%   directed graph B as C1, the degree of A and the out-degree of B as C2,
%   and the in- and out-degrees of B as C3.
%
%   See also DEGDIST_GAP, DEGDIST_CHEM.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.


%adjacency matrices
if (nargin == 0)
    %load the gap junction and chemical networks
    A = full(datareader('gap','unweighted'));
    B = full(datareader('chem','unweighted'));
elseif (nargin == 2)
    A = varargin{1};
    B = varargin{2};
else
    error('DEGDISTCORR: incorrect number of inputs');
end

%the degree of undirected
deg = sum(A);

%the in-degree of directed
indeg = sum(B);

%the out-degree of directed
outdeg = sum(B');

%correlation between the degrees
a = corrcoef(deg,indeg);
b = corrcoef(deg,outdeg);
c = corrcoef(indeg,outdeg);