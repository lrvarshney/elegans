function numDist_gap(varargin)
%NUMDIST_GAP Plots the number distribution survival function for the gap junction network.
%   NUMDIST_GAP produces a plot of the survival function of the number 
%   distribution of the gap junction network together with a stretch
%   exponetial fit.
%
%   NUMDIST_GAP(A) produces a plot of the survival function of the number 
%   distribution of an undirected network with adjacency matrix A.
%
%   See also NUMDIST_CHEM.

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
    %load the gap junction network
    A = full(datareader('gap','weighted'));
elseif (nargin == 1)
    A = varargin{1};
else
    error('NUMDIST_GAP: incorrect number of inputs');
end

%the number distribution
num = sum(A);
mean_num = mean(num);
n_num = histc(num,0:1:max(num));
p = n_num./sum(n_num);

%the survival function 
for ii = 0:max(num)
    P(ii+1) = sum(p(ii+1:end));
end

%locations where the survival function takes true values
II = find(n_num);

%power law fit to tail yielded the following parameters
if (nargin==0)
    xmin = 6;
    alpha = 2.53;
end

%plot the survival function
figure
hold on
plot(0:1:max(num),P,'LineWidth',3);
plot(II-1,P(II),'.','MarkerSize',14);

%plot the power law fit
if (nargin == 0)
    x = xmin:max(num);
    plot(x,(P(xmin+1))*(Hurwitz_zeta(alpha,x)./Hurwitz_zeta(alpha,xmin)),'r','LineWidth',3)
end
hold off
xlabel('number of terminals','FontSize',16)
ylabel('number of terminals survival function','FontSize',16)

if (nargin == 0)
    %plot and annotate the mean
    hold on
    plot([mean_num mean_num],[1.1*0.001 1.1*0.001],'Marker','v','MarkerFaceColor','b')
    text(mean_num-(0.02*120),1.55*0.001,strcat('mean=',num2str(mean_num,3)),'FontSize',14)
    hold off
    
    %adjust the axis limits and axis scale
    axis([0 120 0.001 1])
    set(gca,'XScale','log','YScale','log','FontSize',14);

    %add text arrow annotations
    annotation('textarrow',[0.8795 0.8929],[0.4861 0.2897],'String','AVAL','FontSize',14);
    annotation('textarrow',[0.8185 0.8467],[0.5615 0.371],'String','AVAR','FontSize',14);
    annotation('textarrow',[0.7768 0.75],[0.5 0.4147],'String','AVBR','FontSize',14);
    annotation('textarrow',[0.7143 0.7277],[0.5992 0.4504],'String','AVBL','FontSize',14);
end