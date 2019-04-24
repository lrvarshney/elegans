function degDist_gap(varargin)
%DEGDIST_GAP Plots the degree distribution survival function for the gap junction network.
%   DEGDIST_GAP produces a plot of the survival function of the degree 
%   distribution of the gap junction network together with a stretch
%   exponetial fit.
%
%   DEGDIST_GAP(A) produces a plot of the survival function of an 
%   undirected network with adjacency matrix A.
%
%   See also DEGDIST_CHEM.

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
    A = full(datareader('gap','unweighted'));
elseif (nargin == 1)
    A = varargin{1};
else
    error('DEGDIST_GAP: incorrect number of inputs');
end

%the degree distribution
deg = sum(A);
mean_deg = mean(deg);
n_deg = histc(deg,0:1:max(deg));
p = n_deg./sum(n_deg);

%the survival function 
for ii = 0:max(deg)
    P(ii+1) = sum(p(ii+1:end));
end

%locations where the survival function takes true values
II = find(n_deg);

%power law fit to tail yields parameters
if (nargin == 0)
    xmin = 4;
    alpha = 3.14;
end

%plot the survival function
figure
hold on
plot(0:1:max(deg),P,'LineWidth',3);
plot(II-1,P(II),'.','MarkerSize',14);

%plot the power law fit
if (nargin == 0)
    x = xmin:max(deg);
    plot(x,(P(xmin+1))*(Hurwitz_zeta(alpha,x)./Hurwitz_zeta(alpha,xmin)),'r','linewidth',3)
end
hold off
xlabel('degree','FontSize',16)
ylabel('degree survival function','FontSize',16)

if (nargin == 0)
    %plot and annotate the mean
    hold on
    plot([mean_deg mean_deg],[1.11*.002 1.11*.002],'Marker','v','MarkerFaceColor','b')
    text(mean_deg-(0.025*42),1.5*0.002,strcat('mean=',num2str(mean_deg,3)),'FontSize',14)
    hold off
    
    %adjust the axis limits and axis scale
    axis([0 42 0.002 1])
    set(gca,'XScale','log','YScale','log','FontSize',14);
    
    %add text arrow annotations
    annotation('textarrow',[0.8676 0.8943],[0.5794 0.2222],'String','AVAL','FontSize',14);
    annotation('textarrow',[0.8036 0.8601],[0.6815 0.3135],'String','AVAR','FontSize',14);
    annotation('textarrow',[0.7798 0.8259],[0.5218 0.3671],'String','AVBR','FontSize',14);
    annotation('textarrow',[0.7515 0.7857],[0.4702 0.3929],'String','AVBL','FontSize',14);
    annotation('textarrow',[0.6563 0.6815],[0.376 0.4226],'String','RIBL/R','FontSize',14);
    annotation('textarrow',[0.5298 0.6726],[0.3869 0.4603],'String','AVKL/RIGL','FontSize',14);
end