function [chemGap0,chemGap1] = doubCount_joint(varargin)
%DOUBCOUNT_JOINT The conditional counts of the doublets of the two networks.
%   [D0,D1] = DOUBCOUNT_JOINT calculates the subgraph distribution over two
%   nodes for the chemical network given the presence or absence of a gap
%   junction.  D0(1) is no connections when no gap junction, D0(2) is
%   unidirectional connections when no gap junction, and D0(3) is
%   bidirectional connections when no gap junction.  D1(1) is no
%   connections when gap junction, D1(2) is unidirectional connections when
%   gap junction, and D1(3) is bidirectional connections when gap junction.
%
%   [D0,D1] = DOUBCOUNT_JOINT(C,G) calculates the conditional subgraph
%   distribution over two nodes of a directed network with adjacency
%   matrix C with respect to undirected network G.  D0(1) is no
%   connections given no connection, D0(2) is unidirectional connection
%   given no connection, and D0(3) is bidirectional connections given no
%   connection.  D1(1) is no connections given connection, D1(2) is
%   unidirectional connection given connection, and D1(3) is bidirectional
%   connections given connection.
%
%   See also DOUBCOUNT_CHEM.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

%adjacency matrices
if (nargin == 0)
    %load in the chemical and gap junction networks
    C = datareader('chem','unweighted');
    G = datareader('gap','unweighted');
elseif (nargin == 2)
    C = varargin{1};
    G = varargin{2};
else
    error('DOUBCOUNT_JOINT: incorrect number of inputs');
end

%go through each pair and determine the chem conditioned on gap
chemGap0 = zeros(1,3);
chemGap1 = zeros(1,3);

for ii = 1:length(C)
    for jj = 1:(ii-1)
        if G(ii,jj) == 0
            chemGap0(C(ii,jj)+C(jj,ii)+1) = chemGap0(C(ii,jj)+C(jj,ii)+1) + 1;
        elseif G(ii,jj) == 1
            chemGap1(C(ii,jj)+C(jj,ii)+1) = chemGap1(C(ii,jj)+C(jj,ii)+1) + 1;
        end
    end
end

%Consider the GABAergic synapses separately
if (nargin == 0)
    %label the presynaptic neurons that are GABAergic
    GABAergic = GABA;

    %restricting to pairs with presynaptic neuron GABAergic, determine the chem conditioned on gap
    GABA_chemGap0 = zeros(1,3);
    GABA_chemGap1 = zeros(1,3);

    for ii = 1:length(C)
        for jj = 1:(ii-1)
            if GABAergic(ii) && (G(ii,jj) == 0)
                GABA_chemGap0(C(ii,jj)+C(jj,ii)+1) = GABA_chemGap0(C(ii,jj)+C(jj,ii)+1) + 1;
            elseif GABAergic(ii) && (G(ii,jj) == 1)
                GABA_chemGap1(C(ii,jj)+C(jj,ii)+1) = GABA_chemGap1(C(ii,jj)+C(jj,ii)+1) + 1;
            end
        end
    end
end

%plot the conditional distributions
figure
bar(0:2,chemGap0);
title('Chemical Network Subgraphs when No Gap Junction');
xlabel('number of directed edges')
ylabel('number of (unordered) neuron pairs');

figure
bar(0:2,chemGap1);
title('Chemical Network Subgraphs when Gap Junction');
xlabel('number of directed edges')
ylabel('number of (unordered) neuron pairs');

%plot the likelihood ratios
figure
hold on
if (nargin == 0)
    plot(0:2,[(GABA_chemGap0(1)/sum(GABA_chemGap0))/(GABA_chemGap1(1)/sum(GABA_chemGap1)) (GABA_chemGap0(2)/sum(GABA_chemGap0))/(GABA_chemGap1(2)/sum(GABA_chemGap1)) (GABA_chemGap0(3)/sum(GABA_chemGap0))/(GABA_chemGap1(3)/sum(GABA_chemGap1))],'rs','MarkerFaceColor',[1 0 0])
end
plot(0:2,[(chemGap0(1)/sum(chemGap0))/(chemGap1(1)/sum(chemGap1)) (chemGap0(2)/sum(chemGap0))/(chemGap1(2)/sum(chemGap1)) (chemGap0(3)/sum(chemGap0))/(chemGap1(3)/sum(chemGap1))],'bs','MarkerFaceColor',[0 0 1])
plot([-0.5 2.5],[1 1],'k')
plot([2.2 2.4],[1/2 1/2],'go-','MarkerFaceColor',[0 1 0],'LineWidth',3)
plot([2.2 2.4],[2 2],'go','MarkerFaceColor',[0 1 0])
hold off
ylabel('Likelihood ratio')
set(gca,'YScale','log')
set(gca,'XTick', 0:2)
if (nargin == 0)
    legend('GABAergic presynaptic neuron','all neuron pairs','Location','SouthWest')
end