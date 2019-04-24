function [A,B] = layerconn(network)
%LAYERCONN Compute connectivity between categories of nodes in network.
%   [A,B] = LAYERCONN(N) computes the total weight of connection between 
%   and among categories of neurons.  Either the gap junction network or 
%   the chemical network are used, depending on N in {'gap','chem'}.
%   Output A is counts, whereas B is as fractions.
%
%   See also LAYERS, LAYERS_I.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

%adjacency matrix, node labels and node class labels
[M,labels,class] = datareader(network,'weighted');

n = length(M);

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

A = [sum(sum(M(sen,sen))) sum(sum(M(sen,int))) sum(sum(M(sen,mot)));
     sum(sum(M(int,sen))) sum(sum(M(int,int))) sum(sum(M(int,mot)));
     sum(sum(M(mot,sen))) sum(sum(M(mot,int))) sum(sum(M(mot,mot)))];
A = full(A);

B = A./kron(sum(A')',ones(1,3));
