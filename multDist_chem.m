function multDist_chem(varargin)
%MULTDIST_CHEM Plots the multiplicity survival function for the chemical network.
%   MULTDIST_CHEM produces a plot of the survival function of the multiplicty 
%   of the chemical network together with a stretched exponential fit.
%
%   MULTDIST_CHEM(A) produces a plot of the survival function of the 
%   multiplicity of a directed network with adjacency matrix A.
%
%   See also MULTDIST_GAP.

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
    %load the chemical network
    A = full(datareader('chem','weighted'));
elseif (nargin == 1)
    A = varargin{1};
else
    error('MULTDIST_CHEM: incorrect number of inputs');
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

%the multiplicity distribution with unconnected pairs excluded
q = p(2:end)./sum(p(2:end));
mean_mult_excluding_unconnected = sum(q.*(1:length(mult)-1));

%the survival function 
for ii = 0:length(mult)-1
    P(ii+1) = sum(p(ii+1:end));
end

%locations where the survival function takes true values
II = find(p) - 1;

%stretched exponential fit yields the parameters:
if (nargin == 0)
	xmin = 1;
    beta = 0.36;
    gamma = 0.47;
end

%plot the survival function
figure
hold on
plot(0:length(mult)-1,P,'LineWidth',3)
plot(II,P(II+1),'.','MarkerSize',14)

%plot the stretched exponential fit
if (nargin == 0)
    x = xmin:length(mult)-1;
    plot(x,(P(xmin+1)).*exp(-(x/beta).^gamma+(xmin/beta).^gamma),'r','linewidth',3)
end
hold off
xlabel('multiplicity','FontSize',16)
ylabel('multiplicity survival function','FontSize',16)

if (nargin == 0)
    %plot and annotate the mean with unconnected pairs excluded
    hold on
    plot([mean_mult_excluding_unconnected mean_mult_excluding_unconnected],[1.2*0.00001 1.2*0.00001],'Marker','v','MarkerFaceColor','b')
    text(mean_mult_excluding_unconnected-(0.07*38),2*0.00001,strcat('mean=',num2str(mean_mult_excluding_unconnected,3)),'FontSize',14)
    hold off

    %annotate text labels
    annotation('textarrow',[0.817 0.881],[0.3671 0.1528],'FontSize',14,'String','VB03-DD02');
    annotation('textarrow',[0.7932 0.8408],[0.3075 0.2024],'FontSize',14,'String','PDER-DVA');
    
    %adjust the axis limits and axis scale    
    axis([0 38 0.00001 1])
    set(gca,'YScale','log','FontSize',14)
end