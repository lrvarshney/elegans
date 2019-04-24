function layers_i(network)
%LAYERS Visualize adjacency matrix of C. elegans network.
%   LAYERS(N) produces a visualization of the adjacency matrix of either 
%   the gap junction network or the chemical network, depending on N in
%   {'gap','chem'}.
%
%   See also LAYERS, LAYERCONN.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

%adjacency matrix, node labels and node class labels
[A,labels,class] = datareader(network,'unweighted');

n = length(A);

%determine the category of neuron
sen = [];
int = [];
mot = [];

for ii = 1:n
    if (findstr(char(class(ii)),'S') > 1)
        sen = [sen ii];
    elseif (findstr(char(class(ii)),'M') > 1)
        mot = [mot ii];
    elseif (findstr(char(class(ii)),'I') > 1)
        int = [int ii];
    end
end

%reshape matrix so partitioned by category, anteroposterior order within
AA = [A(sen,sen) A(sen,int) A(sen,mot); 
      A(int,sen) A(int,int) A(int,mot);
      A(mot,sen) A(mot,int) A(mot,mot)];

%plot the partitioned matrix
figure
hold on
spy(AA,'.')
plot([0 n+1],[length(sen)+.5 length(sen)+.5],'k')
plot([length(sen)+.5 length(sen)+.5],[0 n+1],'k')
plot([length(sen)+length(int)+.5 length(sen)+length(int)+.5],[0 n+1],'k')
plot([0 n+1],[length(sen)+length(int)+.5 length(sen)+length(int)+.5],'k')
plot([0 0],[0 n+1],'k')
plot([n+1 n+1],[0 n+1],'k')
plot([0 n+1],[0 0],'k')
plot([0 n+1],[n+1 n+1],'k')
hold off
axis off