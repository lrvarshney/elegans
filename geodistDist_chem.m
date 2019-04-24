function geodistDist_chem(varargin)
%GEODISTDIST_CHEM Plots the geodesic distance distribution for the chemical network.
%   GEODISTDIST_CHEM produces a plot of the geodesic distance distribution 
%   of the chemical network.  
%
%   GEODISTDIST_CHEM(A) produces a plot of the geodesic distance
%   distribution for a directed network with adjacency matrix A.
%
%   See also GEODISTDIST_GAP.

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
    error('GEODISTDIST_CHEM: incorrect number of inputs');
end

%get the giant component 
[S,C] = graphconncomp(A);
gc = mode(C);
Agc = A(find(C==gc),find(C==gc)); 

%geodesic distance matrix of giant component
D = graphallshortestpaths(Agc);
D = reshape(D,1,prod(size(D)));

%get rid of the zeros for the self-loops
D = D(find(D > 0));

%create the plot
edges = 0.5:(max(D)+.5);
nn = histc(D,edges);
stem(nn,'Marker','none','LineWidth',10)
a = axis; axis([min(edges) max(edges) a(3) a(4)]);
xlabel('geodesic distance','FontSize',16)
ylabel('number of (ordered) neuron pairs','FontSize',16)
set(gca,'FontSize',14);
box off