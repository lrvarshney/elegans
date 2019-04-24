function conncomp_gap(varargin)
%CONNCOMP_GAP Lists the connected components for the gap junction network.
%   CONNCOMP_GAP produces a listing of the connected components of the gap
%   junction network.
%
%   CONNCOMP_GAP(A,L) produces a listing of connected components of an 
%   undirected network with adjacency matrix A and node labels L.
%
%   See also GRAPHCONNCOMP, CONNCOMP_CHEM.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

if (nargin == 0)
    %load the gap junction network
    [A,labels] = datareader('gap','unweighted');
elseif (nargin == 2)
    A = varargin{1};
    labels = varargin{2};
else
    error('CONNCOMP_GAP: incorrect number of inputs');
end

%compute connected components
[S,C] = graphconncomp(A);

%list the giant component
gc = mode(C);
giantcomp = find(C == gc);

disp('Giant Component')
for ii = 1:length(giantcomp)
    disp(labels(giantcomp(ii)));
end

%list the smaller components
n = hist(C,S);
zz = 2;
for ii = 1:S
    if (n(ii) > 1 ) && (ii ~= gc)
        disp(strcat('Component ',num2str(zz)));
        component = find(C == ii);
        for jj = 1:n(ii)
            disp(labels(component(jj)));
        end
        zz = zz + 1;
    end
end

%list the unconnected neurons
disp('Unconnected')
for ii = 1:S
    if (n(ii) == 1)
        component = find(C == ii);
        disp(labels(component));
    end
end
