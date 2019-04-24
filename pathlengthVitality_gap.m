function pathlengthVitality_gap
%PATHLENGTHVITALITY_GAP Characteristic path length vitality of gap junction network.
%   PATHLENGTHVITALITY_GAP Computes and plots the characteristic path
%   length vitality for all graphs within one edge insertion/deletion of
%   the gap junction network.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

%the adjacency matrix
G = datareader('gap','unweighted');

%determine the base characteristic path length for the graph
omG = pathlength_gap;

%now go through and try all inclusions and exclusions
zz = 1;
difference = zeros(1,length(G)*(length(G)-1));
for ii = 1:length(G)
    for jj = 1:length(G)
        if ii == jj
        else
            %flip one edge
            Gamma = G;
            Gamma(ii,jj) = ~Gamma(ii,jj);
            Gamma(jj,ii) = ~Gamma(jj,ii);
            
            %compute the path length for this
            omGamma = pathlength_gap(Gamma);
            
            difference(zz) = omGamma - omG;
            zz = zz + 1;
        end
    end
end

%plot the results
figure
h = stem(sort(abs(difference)),'-');
set(h,'Marker','none')
ylabel('|L(G) - L(\Gamma)|')
xlabel('\Gamma')
set(gca,'XTick',[0 279*278])
set(gca,'XTickLabel',['0    ';'77562'])
axis([0 78000 0 0.145])