function degDist_chem(varargin)
%DEGDIST_CHEM Plots the joint degree distribution, in-degree and out-degree for the chemical network.
%   DEGDIST_CHEM produces a plot of the joint distribution of the in-degree
%   and out-degree of the chemical network.  It also plots the survival 
%   function of the in-degree distribution and of the out-degree 
%   distribution, together with exponetial fits.
%
%   DEGDIST_CHEM(A) produces plots of the joint degree distribution and 
%   survival functions of in-degree and out-degree for a directed network 
%   with adjacency matrix A.
%
%   See also DEGDIST_GAP.

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
    A = full(datareader('chem','unweighted'));
elseif (nargin == 1)
    A = varargin{1};
else
    error('DEGDIST_CHEM: incorrect number of inputs');
end


%the in-degree marginal distribution
indeg = sum(A);
mean_indeg = mean(indeg);
n_indeg = histc(indeg,0:1:max(indeg));
pin = n_indeg./sum(n_indeg);

%the in-degree survival function
for ii = 0:max(indeg)
    Pin(ii+1) = sum(pin(ii+1:end));
end

%the out-degree marginal distribution
outdeg = sum(A');
mean_outdeg = mean(outdeg);
n_outdeg = histc(outdeg,0:1:max(outdeg));
pout = n_outdeg./sum(n_outdeg);

%the out-degree survival function
for ii = 0:max(outdeg)
    Pout(ii+1) = sum(pout(ii+1:end));
end

%the joint distribution
degDist = zeros(max(indeg)+1,max(outdeg)+1);
for ii = 1:length(A)
	degDist(indeg(ii)+1,outdeg(ii)+1) = degDist(indeg(ii)+1,outdeg(ii)+1) + 1;
end

%power law fit to tail of in-degree yields parameters
if (nargin == 0)
    xmin = 11;
    alpha = 3.17;
end

%plot the in-degree survival function
figure
hold on
plot(0:1:max(indeg),Pin,'LineWidth',3);
plot(find(pin)-1,Pin(find(pin)),'.','MarkerSize',14);

%plot the power law fit
if (nargin == 0)
    x = xmin:max(indeg);
    plot(x,(Pin(xmin+1))*(Hurwitz_zeta(alpha,x)./Hurwitz_zeta(alpha,xmin)),'r','linewidth',3)
end
hold off
xlabel('in-degree','FontSize',16)
ylabel('in-degree survival function','FontSize',16)

if (nargin == 0)
    %plot and annotate the mean
    hold on
    plot([mean_indeg mean_indeg],[1.11*.002 1.11*.002],'Marker','v','MarkerFaceColor','b')
    text(mean_indeg-(1.05),1.5*0.002,strcat('mean=',num2str(mean_indeg,3)),'FontSize',14)
    hold off
    
    %adjust the axis limits and axis scale
    axis([0 54 0.002 1])
    set(gca,'XScale','log','YScale','log','FontSize',14)
end

%power law fit to tail of out-degree yields parameters
if (nargin == 0)
    xmin = 14;
    alpha = 4.22;
end

%plot the out-degree survival function
figure
hold on
plot(0:1:max(outdeg),Pout,'LineWidth',3);
plot(find(pout)-1,Pout(find(pout)),'.','MarkerSize',14);

%plot the power law fit
if (nargin == 0)
    x = xmin:max(outdeg);
    plot(x,(Pout(xmin+1))*(Hurwitz_zeta(alpha,x)./Hurwitz_zeta(alpha,xmin)),'r','linewidth',3)
end
hold off
xlabel('out-degree','FontSize',16)
ylabel('out-degree survival function','FontSize',16)

if (nargin == 0)
    %plot and annotate the mean
    hold on
    plot([mean_outdeg mean_outdeg],[1.1*.002 1.1*.002],'Marker','v','MarkerFaceColor','b')
    text(mean_outdeg-1.05,1.5*0.002,strcat('mean=',num2str(mean_outdeg,3)),'FontSize',14)
    hold off
    
    %adjust the axis limits and axis scale
    axis([0 50 0.002 1])
    set(gca,'XScale','log','YScale','log','FontSize',14)
end

%plot the joint degree distribution
figure
bar3(degDist)
colormap('white')
xlabel('out-degree')
ylabel('in-degree')
axis tight

%label neurons with large degree
if (nargin == 0)
    text(52,49,0,'AVAR','FontSize',10,'FontWeight','bold','Color',[1 0 0]);
    text(38,55,0,'AVAL','FontSize',10,'FontWeight','bold','Color',[1 0 0]);
    text(22,41,0.1,'AVBL','FontSize',10,'FontWeight','bold','Color',[1 0 0]);
    text(33,30,0.1,'PVCL','FontSize',10,'FontWeight','bold','Color',[1 0 0]);
end