function C = clustcoef_gap(varargin)
%CLUSTCOEF_GAP The clustering coefficient of the gap junction network giant component.
%   L = CLUSTCOEF_GAP calculates the clustering coefficient of the gap
%   junction network giant component.
%
%   L = CLUSTCOEF_GAP(A) calculates the clustering coefficient of the
%   giant component of an undirected network with adjacency matrix A.
%
%   See also CLUSTCOEF_CHEM.

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
    %load the gap junction network
    A = datareader('gap','unweighted');
elseif (nargin == 1)
    A = varargin{1};
else
    error('CLUSTCOEF_GAP: incorrect number of inputs');
end

%get the giant component 
[S,C] = graphconncomp(A);
gc = mode(C);
Agc = full(A(find(C==gc),find(C==gc)));

%go through each vertex and find its clustering coefficient
C = 0;

for ii = 1:length(Agc)
    Nii = find(Agc(ii,:));
    subg = Agc(Nii,Nii);
    Cii = sum(sum(subg))/max((length(Nii))*(length(Nii)-1),1);
    C = C + Cii;
end

C = C/length(Agc);
