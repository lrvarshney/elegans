function multDist_gap(varargin)
%MULTDIST_GAP Plots the multiplicity survival function for the gap junction network.
%   MULTDIST_GAP produces a plot of the survival function of the multiplicty 
%   of the gap junction network together with a power law fit.
%
%   MULTDIST_GAP(A) produces a plot of the survival function of the 
%   multiplicity of an undirected network with adjacency matrix A.
%
%   See also MULTDIST_CHEM.

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
    error('MULTDIST_GAP: incorrect number of inputs');
end

%the multiplicity
mult = zeros(1,max(max(A))+1);

for ii = 1:length(A)
    for jj = 1:length(A)
        if ii ~= jj
            mult(A(ii,jj)+1) = mult(A(ii,jj)+1) + 1;
        end
    end
end

%the multiplicity distribution
p = mult./sum(mult);

%the multiplicity distribution excluding unconnected pairs
q = p(2:end)./sum(p(2:end));
mean_mult_excluding_unconnected = sum(q.*(1:length(mult)-1));

%the survival function 
for ii = 0:length(mult)-1
    P(ii+1) = sum(p(ii+1:end));
end

%locations where the survival function takes true values
II = find(p) - 1;

%power law fit to tail yields parameters:
if (nargin == 0)
    xmin = 2;
    alpha = 2.76;
end

%plot the survival function
figure
hold on
plot(0:length(mult)-1,P,'LineWidth',3)
plot(II,P(II+1),'.','MarkerSize',14)

%plot the power law fit
if (nargin == 0)
    x = xmin:length(mult)-1;
    plot(x,(P(xmin+1))*(Hurwitz_zeta(alpha,x)./Hurwitz_zeta(alpha,xmin)),'r','linewidth',3);
end
hold off
xlabel('multiplicity','FontSize',16)
ylabel('multiplicity survival function','FontSize',16)

if (nargin == 0)
    %plot and annotate the mean with unconnected pairs excluded
    hold on
    plot([mean_mult_excluding_unconnected mean_mult_excluding_unconnected],[1.23*0.00001 1.23*0.00001],'Marker','v','MarkerFaceColor','b')
    text(mean_mult_excluding_unconnected-log10(0.07*25),2.5*0.00001,strcat('mean=',num2str(mean_mult_excluding_unconnected,3)),'FontSize',14)
    hold off

    %adjust the axis limits and axis scale
    axis([0 25 0.00001 1])
    set(gca,'XScale','log','YScale','log','FontSize',14)
    
    %add text arrow annotations
    annotation('textarrow',[0.7173 0.75],[0.4464 0.2619],'String','PVPR-DVC','FontSize',14);
    annotation('textarrow',[0.8333 0.878],[0.3968 0.2143],'String','AVFR-AVFL','FontSize',14);
end