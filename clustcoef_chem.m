function C = clustcoef_chem(varargin)
%CLUSTCOEF_CHEM The clustering coefficient of the chemical network strong giant component.
%   L = CLUSTCOEF_CHEM calculates the clustering coefficient of the 
%   chemical network strong giant component.
%
%   L = CLUSTCOEF_CHEM(A) calculates the clustering coefficient of the
%   strong giant component of a directed network with adjacency matrix A.
%
%   See also CLUSTCOEF_GAP.

%   Copyright 2006-2008.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2008, in preparation.

%adjacency matrix
if (nargin == 0)
    %load the chemical network
    A = datareader('chem','unweighted');
elseif (nargin == 1)
    A = varargin{1};
else
    error('CLUSTCOEF_CHEM: incorrect number of inputs');
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
