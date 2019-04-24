function Spec_both
% SPEC_BOTH Plots the eigenmodes of the combined network.
%   SPEC_BOTH Plots the eigenspectrum and eigenmodes of the combined network,
%   which consists of the gap junction network and the chemical network.

%   Copyright 2006-2009.  Dmitri B. Chklovskii, Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

%load the chemical and gap junction network adjacency matrices
[A,Neuron_ordered] = datareader('chem','weighted');
B = datareader('gap','weighted');

%load the GABAergic synapse listing
GABAergic = GABA; 

%treat GABAergic synapses in chemical network as inhibitory
A(find(GABAergic),:) = -A(find(GABAergic),:);

%get the strong giant component
[S,C] = graphconncomp(A+B);
gc = mode(C);
AA = full(A(find(C==gc),find(C==gc)));
BB = full(B(find(C==gc),find(C==gc)));

%names of neurons in giant component
labels = Neuron_ordered(find(C==gc));

%matrix associated with the linear system
L = BB - diag(sum(BB)) + AA';
n = size(L,1);

%the eigenvalues and eigenvectors of the graph 
[V,E] = eig(L);

%When dealing with directed graphs, one needs to be careful that the linear
%system is not defective.  If there are linearly dependent eigenvectors,
%then one should work with the Jordan normal form rather than the
%eigendecomposition as the correct modal decomposition.  To check this, we
%look at some condition numbers and such.

%condition number with respect to eigendecomposition
kappa = condeig(L)

%check the dimensionality of the eigenspace
sz = size(V), rk = rank(V)
k = cond(V)

%invert the eigendecomposition and make sure things worked out
LLL = V*E*inv(V);
mx = max(max(abs(LLL-L)))
su = sum(sum(abs(LLL-L)))

%plot the eigenvalues in the complex plane
figure
plot(real(diag(E)),imag(diag(E)),'k.')
xlabel('Re(\lambda)','FontSize',16)
ylabel('Im(\lambda)','FontSize',16)
set(gca,'FontSize',14);
box off

%find slow and sparse modes 
jj = find(abs(diag(E))<20 & (sum(abs(V))/sqrt(n)<0.3)');

%plot decay-sparseness scatterplot
decay = -(real(diag(E)));
sparsity = sum(abs(V))/sqrt(n);

figure
hold on
plot(decay,sparsity,'.','MarkerSize',10)
plot(decay(6),sparsity(6),'c.','MarkerSize',10)
plot(decay(jj),sparsity(jj),'r.','MarkerSize',10)
hold off
ylabel('sparsity','FontSize',16)
xlabel('-Re(\lambda)','FontSize',16)
box off
set(gca,'FontSize',14);


%plot these slow and sparse eigenvectors
figure
for k = 1:length(jj)
    subplot(length(jj),1,k)

    plot(real(V(:,jj(k))))
    set(gca,'XTick',[])
    [scrap,big] = sort(abs(real(V(:,jj(k)))),1,'descend');
    for ii = 1:max(find(scrap > 0.08))
        h = text(big(ii),real(V(big(ii),jj(k))),labels{big(ii)},'FontSize',10,'Rotation',60);
        if real(V(big(ii),jj(k))) < 0
            set(h,'Color',[1 0 0])
        end
    end
    axis([1 n -1 1])

    text(-2,1,' 1','FontSize',11)
    text(-2,-1,'-1','FontSize',11)
    line([1 3],[1 1],'Color','k')
    line([1 3],[0 0],'Color','k')
    line([1 3],[-1 -1],'Color','k')
    text(-22,0,strcat('Re(v_{',num2str(jj(k)),'})'),'FontSize',16)
    set(gca,'Visible','off')
end

%plot the sixth eigenvector
jj = 5;

figure
hh = stem(real(V(:,jj+1)));
set(hh,'Marker','none','LineWidth',1)
set(gca,'XTick',[])
[scrap,big] = sort(abs(real(V(:,jj+1))),1,'descend');

% Create text
text('String','AVBL','Position',[95 -0.8441 0],'Color',[1 0 0]);
text('String','AVBR','Position',[104 -0.2665 0],'Color',[1 0 0]);
text('String','VB08','Position',[211 0.237 0]);
text('String','DD05','Position',[229 -0.1714 0],'Color',[1 0 0]);
text('String','AS07','Position',[212 0.132 0]);
text('String','VB02','Position',[137 0.1119 0]);
text('String','VB09','Position',[216 0.095 0]);
text('String','DD01','Position',[162 -0.07871 0],'Color',[1 0 0]);
text('String','AVAR','Position',[54 -0.0744 0],'Color',[1 0 0]);

axis([1 n -0.87 0.27])
ylabel(strcat('v_{',num2str(jj+1),'}'),'FontSize',16)
set(gca,'FontSize',14);

box off
set(gca,'XColor',[1 1 1])