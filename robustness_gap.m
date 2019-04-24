%ROBUSTNESS_GAP.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.


%gap junction network
G = datareader('gap','weighted');

%actual synapses in upper triangle
[index_i,index_j] = ind2sub(size(G),find(triu(G)));

%AY's gap junction network
load connectivity_AY

%edit distance of AY
dedit = sum(sum(triu(abs(Agap_AY-G))))

%ensemble parameter
p = 0.1;

%size of ensemble
nnn = 1000;

for ii = 1:nnn
    %consider the upper triangle only
    GammaW = full(triu(G));
    
    %go through each actual synaptic contact in the upper triangle;
    %with probability p, move it to some random place in the upper triangle
    for index = 1:length(index_i)
        %amount to reduce
        reduc = sum(rand(1,G(index_i(index),index_j(index)))<p);
 
        %reduce this one by reduc
        GammaW(index_i(index),index_j(index)) = GammaW(index_i(index),index_j(index)) - reduc;

        %add on reduc elsewhere in the upper triangle
        for kk = 1:reduc
            loc = ceil(length(G)*rand(1,2));
            %can use min/max to force upper triangle because both
            %permutations are equiprobable in an iid random vector
            GammaW(min(loc),max(loc)) = GammaW(min(loc),max(loc)) + 1;
        end        
    end

    %symmetrize it
    GammaW = triu(GammaW) + triu(GammaW)';
    
    %edited graph (unweighted)
    Gamma = sparse(GammaW>0);

    %edit distance
    dedit(ii) = sum(sum(triu(abs(GammaW-G))));

    %size of giant component
    [S,C] = graphconncomp(Gamma);
    gc = mode(C);
    sgc(ii) = length(find(C==gc));

    %path length of gap junction network giant component
    L(ii) = pathlength_gap(Gamma);

    %clustering coefficient of gap junction network giant component
    CC(ii) = clustcoef_gap(Gamma);
end

fprintf(strcat('d\t\t',num2str(mean(dedit)),'\t',num2str(std(dedit)),'\n'));
fprintf(strcat('sgc\t\t',num2str(mean(sgc)),'\t',num2str(std(sgc)),'\n'));
fprintf(strcat('L\t\t',num2str(mean(L)),'\t',num2str(std(L)),'\n'));
fprintf(strcat('CC\t\t',num2str(mean(CC)),'\t',num2str(std(CC)),'\n'));
fprintf('\n');