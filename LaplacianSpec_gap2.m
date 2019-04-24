function eeee = LaplacianSpec_gap
%LAPLACIANSPEC_GAP Plots the eigenspectrum and eigenmodes of the Laplacian for the gap junction network.
%   LAPLACIANSPEC_GAP produces a plot of the eigenspectrum of the giant
%   component of the gap junction network as well as an image of the eigenmodes.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

%load the gap junction network adjacency matrix
[A,Neuron_ordered] = datareader('gap','weighted');

%get the giant component
[S,C] = graphconncomp(A);
gc = mode(C);
A = full(A(find(C==gc),find(C==gc)));

n = size(A,1);

%names of neurons in giant component
labels = Neuron_ordered(find(C==gc));

%the number of terminals matrix
D = diag(sum(A));

%the graph laplacian
L = D - A;

%the eigenvalues and eigenvectors of the graph Laplacian
[V,E] = eig(L);
eeee = diag(E)
%plot the eigenvalues
figure
h = plotyy(1:n,diag(E),1:n,diag(E)./10,'bar');
xlabel('n','FontSize',16)
set(get(h(1),'Ylabel'),'String','\lambda_n','FontSize',16)
set(get(h(2),'Ylabel'),'String','estimated decay constant (1/ms)','FontSize',16)
set(h(1),'Xlim',[.6 248.4],'Ylim',[0 120],'FontSize',14)
set(h(2),'Xlim',[.6 248.4],'Ylim',[0 12],'FontSize',14)

%determine the survival function of the distribution of eigenvalues
eigvallocs = sort(diag(E));
PP = (n:-1:1)./n;

%plot the survival function
figure
hold on
plot(eigvallocs,PP,'.-','MarkerSize',14,'LineWidth',3);

% %plot a semicircle for comparison
% R = eigvallocs(end-2)/2;
% c = eigvallocs(end-2)/2;
% x = linspace(0,c+R,1000);
% semicirc = (-(x-c).*sqrt(R.^2-(x-c).^2))./(pi.*R.^2) + acos((x-c)./R)./pi;
% plot(x,semicirc,'r');

%adjust the axes
set(gca,'FontSize',14);
axis([0 120 0 1])
xlabel('eigenvalue, \lambda','FontSize',16)
ylabel('eigenvalue survival function, P(\lambda)','FontSize',16)
text(17, .95,'estimated decay constant (1/ms)','FontSize',16)

%also include the time scale associated with the decay constant
ax(1) = gca;
ax(2) = axes('Position',get(ax(1),'Position'),'XAxisLocation','top','Color','none');
set(ax,'box','off')
line(eigvallocs./10,PP,'Parent',ax(2));
axis([0 12 0 1])
set(gca,'FontSize',14);
hold off

%plot the decay-sparseness scatterplot
decay = diag(E);
sparsity = sum(abs(V))/sqrt(n);

figure
hold on
plot(decay,sparsity,'.','MarkerSize',10)
plot(decay(3),sparsity(3),'g.','MarkerSize',10)
plot(decay(13),sparsity(13),'c.','MarkerSize',10)
plot(decay(234:248),sparsity(234:248),'r.','MarkerSize',10)
hold off
ylabel('sparsity','FontSize',16)
xlabel('\lambda','FontSize',16)
axis tight, a = axis; axis([a(1) 120 0 a(4)]);
box off
set(gca,'FontSize',14);

%plot some of the fast eigenvectors
figure
for jj = 0:7
    subplot(8,1,jj+1)
    plot(V(:,n-jj))
    [scrap,big] = sort(abs(V(:,n-jj)),1,'descend');
    for ii = 1:max(find(scrap > 0.08))
        h = text(big(ii),sign(V(big(ii),n-jj)),labels{big(ii)},'FontSize',8,'Rotation',40);
        if V(big(ii),n-jj) < 0
            set(h,'Color',[1 0 0])
        end
    end
    axis([1 n -1 1])

    text(-2,1,' 1','FontSize',11)
    text(-2,-1,'-1','FontSize',11)
    line([1 3],[1 1],'Color','k')
    line([1 3],[0 0],'Color','k')
    line([1 3],[-1 -1],'Color','k')
    text(-10,0,strcat('v_{',num2str(n-jj),'}'),'FontSize',14)
    set(gca,'Visible','off')
end

%plot the 246th eigenvector
jj = 245;

figure
hh = stem(V(:,jj+1));
set(hh,'Marker','none','LineWidth',1)
set(gca,'XTick',[])
text('String','AVFR','Position',[124 -0.7 0],'Color',[1 0 0]);
text('String','AVFL','Position',[129 0.75 0]);
ylabel(strcat('v_{',num2str(jj+1),'}'),'FontSize',16)
set(gca,'FontSize',14);

box off
set(gca,'XColor',[1 1 1])

%plot the third eigenvector
jj = 2;

figure
hh = stem(V(:,jj+1));
set(hh,'Marker','none','LineWidth',1)
set(gca,'XTick',[])
[scrap,big] = sort(abs(V(:,jj+1)),1,'descend');
% Create text
text('String','PHBL','Position',[237 0.4536 0]);
text('String','PHBR','Position',[235 0.4323 0]);
text('String','AVHL','Position',[79 0.3077 0]);
text('String','AVHR','Position',[80 0.286 0]);
text('String','AVFR','Position',[124 0.276 0]);
text('String','AVFL','Position',[129 0.258 0]);
text('String','VC04','Position',[187 0.204 0]);
text('String','VC05','Position',[189 0.17 0]);
text('String','ASIL','Position',[65 -0.149 0],'Color',[1 0 0]);
text('String','AIAL','Position',[95 -0.144 0],'Color',[1 0 0]);
text('String','VC03','Position',[179 0.15 0]);
text('String','ASIR','Position',[78 -0.138 0],'Color',[1 0 0]);
text('String','AWAL','Position',[63 -0.1349 0],'Color',[1 0 0]);
text('String','VC02','Position',[168 0.128 0]);
text('String','AIAR','Position',[110 -0.1228 0],'Color',[1 0 0]);
text('String','VC01','Position',[161 0.117 0]);
text('String','AWAR','Position',[71 -0.1069 0],'Color',[1 0 0]);
text('String','DD04','Position',[193 0.07797 0]);
text('String','ADFR','Position',[59 -0.0699 0],'Color',[1 0 0]);

axis([1 n -0.18 0.5])
ylabel(strcat('v_{',num2str(jj+1),'}'),'FontSize',16)
set(gca,'FontSize',14);

box off
set(gca,'XColor',[1 1 1])

%plot the thirteenth eigenvector
jj = 12;

figure
hh = stem(V(:,jj+1));
set(hh,'Marker','none','LineWidth',1)
set(gca,'XTick',[])
[scrap,big] = sort(abs(V(:,jj+1)),1,'descend');

% Create text
text('String','RMHR','Position',[90 -0.420915 0],'Color',[1 0 0]);
text('String','URXR','Position',[44 -0.333418 0],'Color',[1 0 0]);
text('String','IL2R','Position',[9 -0.288411 0],'Color',[1 0 0]);
text('String','RIPL','Position',[11 0.279375 0]);
text('String','RIPR','Position',[21 0.256 0]);
text('String','RMGR','Position',[140 -0.216514 0],'Color',[1 0 0]);
text('String','IL1VR','Position',[28 -0.175245 0],'Color',[1 0 0]);
text('String','AINR','Position',[106 0.16 0]);
text('String','ASGL','Position',[60 0.152 0]);
text('String','ALMR','Position',[178 0.1504 0]);
text('String','RMED','Position',[17 0.1437 0]);
text('String','AINL','Position',[104 0.1365 0]);
text('String','IL1R','Position',[15 -0.135 0],'Color',[1 0 0]);
text('String','AS11','Position',[216 0.135 0]);
text('String','ASGR','Position',[68 0.1242 0]);
text('String','PDA','Position',[225 0.12 0]);
text('String','AUAL','Position',[88 0.122 0]);
text('String','AIML','Position',[118 0.12 0]);
text('String','RMER','Position',[27 0.1042 0]);
text('String','AUAR','Position',[100 0.09472 0]);
text('String','PDB','Position',[223 0.09441 0]);
text('String','ADEL','Position',[132 0.08582 0]);
text('String','AS04','Position',[170 -0.08146 0],'Color',[1 0 0]);
text('String','RIR','Position',[96 -0.08122 0],'Color',[1 0 0]);
text('String','ALA','Position',[37 0.083 0]);
text('String','URXL','Position',[36 0.067 0]);
text('String','IL2L','Position',[1 0.07797 0]);
text('String','ASKR','Position',[48 -0.0779 0],'Color',[1 0 0]);
text('String','AVM','Position',[173 0.07735 0]);
text('String','AIZL','Position',[116 0.07461 0]);

axis([1 n -0.45 0.30])
ylabel(strcat('v_{',num2str(jj+1),'}'),'FontSize',16)
set(gca,'FontSize',14);

box off
set(gca,'XColor',[1 1 1])

%plot all of the eigenvectors
figure
hold on
imagesc(sign(V).*(V.^2))

cmap = [
    1.0000         0         0
    1.0000    0.0167    0.0167
    1.0000    0.0335    0.0335
    1.0000    0.0502    0.0502
    1.0000    0.0669    0.0669
    1.0000    0.0837    0.0837
    1.0000    0.1004    0.1004
    1.0000    0.1171    0.1171
    1.0000    0.1339    0.1339
    1.0000    0.1506    0.1506
    1.0000    0.1673    0.1673
    1.0000    0.1841    0.1841
    1.0000    0.2008    0.2008
    1.0000    0.2175    0.2175
    1.0000    0.2342    0.2342
    1.0000    0.2510    0.2510
    1.0000    0.2677    0.2677
    1.0000    0.2844    0.2844
    1.0000    0.3012    0.3012
    1.0000    0.3179    0.3179
    1.0000    0.3346    0.3346
    1.0000    0.3514    0.3514
    1.0000    0.3681    0.3681
    1.0000    0.3848    0.3848
    1.0000    0.4016    0.4016
    1.0000    0.4183    0.4183
    1.0000    0.4350    0.4350
    1.0000    0.4518    0.4518
    1.0000    0.4685    0.4685
    1.0000    0.4852    0.4852
    1.0000    0.5020    0.5020
    1.0000    1.0000    1.0000
    1.0000    1.0000    1.0000
    0.7529    0.7529    0.7529
    0.7278    0.7278    0.7278
    0.7027    0.7027    0.7027
    0.6776    0.6776    0.6776
    0.6525    0.6525    0.6525
    0.6275    0.6275    0.6275
    0.6024    0.6024    0.6024
    0.5773    0.5773    0.5773
    0.5522    0.5522    0.5522
    0.5271    0.5271    0.5271
    0.5020    0.5020    0.5020
    0.4769    0.4769    0.4769
    0.4518    0.4518    0.4518
    0.4267    0.4267    0.4267
    0.4016    0.4016    0.4016
    0.3765    0.3765    0.3765
    0.3514    0.3514    0.3514
    0.3263    0.3263    0.3263
    0.3012    0.3012    0.3012
    0.2761    0.2761    0.2761
    0.2510    0.2510    0.2510
    0.2259    0.2259    0.2259
    0.2008    0.2008    0.2008
    0.1757    0.1757    0.1757
    0.1506    0.1506    0.1506
    0.1255    0.1255    0.1255
    0.1004    0.1004    0.1004
    0.0753    0.0753    0.0753
    0.0502    0.0502    0.0502
    0.0251    0.0251    0.0251
    0         0         0
    ];

colormap(cmap);

%include dividing lines
for ii = 1:length(A)
    plot([0.5 length(A)+.5], [ii+.5 ii+.5],'Color',[1 1 1],'LineWidth',.2)
end
for jj = 1:length(A)
    plot([jj+.5 jj+.5],[0.5 length(A)+.5],'Color',[1 1 1],'LineWidth',.2)
end
colorbar

%axis labels
xlabel('eigenmode_n','FontSize',18)
set(gca,'YTick',[],'FontSize',16)
axis tight

XLims = get(gca,'XLim');
OFFSET = 0.01;
x = XLims(1) - OFFSET*diff(XLims);
shifter = (0:.022:.2).*diff(XLims);
for ii = 1:length(A)
    hText = text(x-shifter(mod(ii,6)+1),ii,labels{ii},'Horiz','Right');
    set(hText,'FontSize',3)
end