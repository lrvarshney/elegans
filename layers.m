function layers
%LAYERS Visualize adjacency matrix of C. elegans network.
%   LAYERS produces a visualization of the adjacency matrices the
%   gap junction network and the chemical network.
%
%   See also LAYERS_I, LAYERCONN.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.


%adjacency matrix, node labels and node class labels for chemical network
[A,labels,class] = datareader('chem','weighted');

%number of nodes
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


%adjacency matrix for gap junction network
B = datareader('gap','unweighted');

%reshape matrix so partitioned by category, anteroposterior order within
BB = [B(sen,sen) B(sen,int) B(sen,mot);
    B(int,sen) B(int,int) B(int,mot);
    B(mot,sen) B(mot,int) B(mot,mot)];


%plot the partitioned matrices
figure
hold on
spy(AA,'r.',2)

%chemical network
for ii = 1:length(AA)
    for jj = 1:length(AA)
        if AA(ii,jj)
            %small markers for weak connections
            if AA(ii,jj) < 5
                plot(jj,ii,'r.','MarkerSize',5,'Color',[1 0 0]);
            %large markers for strong connections
            else
                plot(jj,ii,'r.','MarkerSize',9,'Color',[1 0 0]);
            end
        end
    end
end

%gap junction network
for ii = 1:length(BB)
    for jj = 1:length(BB)
        if BB(ii,jj)
            plot(jj,ii,'o','MarkerSize',3,'Color',[.6 .6 .95]);
        end
    end
end

%divisions between categories
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

%labels
text(0,-5,'       Sensory Neurons               Interneurons                    Motor Neurons','FontSize',14)
text(-5,250,'Motor Neurons                    Interneurons              Sensory Neurons','Rotation',90,'FontSize',14);