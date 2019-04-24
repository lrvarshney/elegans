%ROBUSTNESS_CHEM.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.


%chemical network
G = datareader('chem','weighted');

%actual synapses
[index_i,index_j] = ind2sub(size(G),find(G)); 

%AY's chemical network
load connectivity_AY

%edit distance of AY
dedit = sum(sum(abs(Achem_AY-G)))

%ensemble parameters
p = 0.05;

%size of ensemble
nnn = 1000;

for ii = 1:nnn
    GammaW = full(G);

    %go through each actual synaptic contact;
    %with probability p, move it to some random place
    for index = 1:length(index_i)
        %amount to reduce
        reduc = sum(rand(1,G(index_i(index),index_j(index)))<p);
 
        %reduce this one by reduc
        GammaW(index_i(index),index_j(index)) = GammaW(index_i(index),index_j(index)) - reduc;

        %add on reduc elsewhere
        loc_i = ceil(length(G)*rand(1,reduc));
        loc_j = ceil(length(G)*rand(1,reduc));
        for loc_index = 1:length(loc_i)
            GammaW(loc_i(loc_index),loc_j(loc_index)) = GammaW(loc_i(loc_index),loc_j(loc_index)) + 1;
        end
    end
    
    %edited graph (unweighted)
    Gamma = sparse(GammaW>0);

    %edit distance
    dedit(ii) = sum(sum(abs(GammaW-G)));

    %size of weak giant component
    [S,C] = graphconncomp(Gamma,'weak',true);
    gc = mode(C);
    swgc(ii) = length(find(C==gc));

    %size of strong giant component
    [S,C] = graphconncomp(Gamma);
    gc = mode(C);
    ssgc(ii) = length(find(C==gc));

    %path length of chemical network giant component
    L(ii) = pathlength_chem(Gamma);

    %clustering coefficient of chemical network giant component
    CC(ii) = clustcoef_chem(Gamma);
end

fprintf(strcat('d\t\t',num2str(mean(dedit)),'\t',num2str(std(dedit)),'\n'));
fprintf(strcat('swgc\t',num2str(mean(swgc)),'\t',num2str(std(swgc)),'\n'));
fprintf(strcat('ssgc\t',num2str(mean(ssgc)),'\t',num2str(std(ssgc)),'\n'));
fprintf(strcat('L\t\t',num2str(mean(L)),'\t',num2str(std(L)),'\n'));
fprintf(strcat('CC\t\t',num2str(mean(CC)),'\t',num2str(std(CC)),'\n'));
fprintf('\n');