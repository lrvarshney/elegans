function closenesscentrality_chem(varargin)
%CLOSENESSCENTRALITY_CHEM Closeness centrality for the chemical network.
%   CLOSENESSCENTRALITY_CHEM lists the closeness centrality ranking of the 
%   chemical network.  
%
%   See also CLOSENESSCENTRALITY_GAP.

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
    [A,Neuron_ordered] = datareader('chem','unweighted');
elseif (nargin == 2)
    A = varargin{1};
    Neuron_ordered = varargin{2};
else
	error('CLOSENESSCENTRALITY_CHEM: incorrect number of inputs');
end

%get the giant component 
[S,C] = graphconncomp(A);
gc = mode(C);
Agc = A(find(C==gc),find(C==gc)); 

%names of neurons in giant component
labels = Neuron_ordered(find(C==gc));

%geodesic distance matrix of giant component
D = graphallshortestpaths(Agc);

%compute the normalized in-closeness for each node in giant component
inclose = zeros(1,length(D));
for ii = 1:length(D)
    inclose(ii) = sum(D(:,ii))./(length(D)-1);
end

%list the neurons in order of normalized in-closeness centrality
[yy,iii] = sort(inclose);
disp('IN-CLOSENESS')
for ii = 1:length(iii)
    fprintf('%s  \t  %0.4g\n',labels{iii(ii)},1./inclose(iii(ii)));
end

%compute the normalized out-closeness for each node in giant component
outclose = zeros(1,length(D));
for ii = 1:length(D)
    outclose(ii) = sum(D(ii,:))./(length(D)-1);
end

%list the neurons in order of normalized out-closeness centrality
[zz,jjj] = sort(outclose);
disp(' ')
disp('OUT-CLOSENESS')
for ii = 1:length(jjj)
    fprintf('%s  \t  %0.4g\n',labels{jjj(ii)},1./outclose(jjj(ii)));
end

%correlation between in- and out-
inclose_outclose = corrcoef(1./inclose,1./outclose)