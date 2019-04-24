function numDist_chem(varargin)
%NUMDIST_CHEM Plots the joint number distribution, in-number, and out-number for the chemical network.
%   NUMDIST_CHEM produces a plot of the joint in-number and out-number of 
%   the of the chemical network.  It also plots the survival function of 
%   the in-number distribution and of the out-number distribution, together 
%   with exponetial fits.
%
%   NUMDIST_CHEM(A) produces plots of the joint number distribution and 
%   survival functions of in-number and out-number for a directed network 
%   with adjacency matrix A.
%
%   See also NUMDIST_GAP.

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
    error('NUMDIST_CHEM: incorrect number of inputs');
end

%the in-number distribution
innum = sum(A);
mean_innum = mean(innum);
n_innum = histc(innum,0:max(innum));
pin = n_innum./sum(n_innum);

%the in-number survival function
for ii = 0:max(innum)
    Pin(ii+1) = sum(pin(ii+1:end));
end

%the out-number distribution
outnum = sum(A');
mean_outnum = mean(outnum);
n_outnum = histc(outnum,0:max(outnum));
pout = n_outnum./sum(n_outnum);

%the out-number survival function
for ii = 0:max(outnum)
    Pout(ii+1) = sum(pout(ii+1:end));
end

%the joint distribution
numDist = zeros(max(innum)+1,max(outnum)+1);
for ii = 1:length(A)
	numDist(innum(ii)+1,outnum(ii)+1) = numDist(innum(ii)+1,outnum(ii)+1) + 1;
end

%plot the in-number survival function
figure
hold on
plot(0:1:max(innum),Pin,'LineWidth',3);
plot(find(pin)-1,Pin(find(pin)),'.','MarkerSize',14);
hold off
xlabel('in-number','FontSize',16)
ylabel('in-number survival function','FontSize',16)

if (nargin == 0)
    %plot and annotate the mean
    hold on
    plot([mean_innum mean_innum],[1.11*.002 1.11*.002],'Marker','v','MarkerFaceColor','b')
    text(mean_innum-(0.03*275),1.5*0.002,strcat('mean=',num2str(mean_innum,3)),'FontSize',14)
    hold off

    %adjust the axis limits and axis scale
    axis([0 275 0.002 1])
    set(gca,'XScale','log','YScale','log','FontSize',14)

    %add text arrow annotations
    annotation('textarrow',[0.8616 0.8824],[0.374 0.3115],'String','AVAL','FontSize',14);
    annotation('textarrow',[0.8274 0.875],[0.1776 0.1984],'String','AVAR','FontSize',14);
end


%power law fit for tail of out-number yields parameters:
if (nargin==0)
    xmin = 34;
    alpha = 4.05;
end

%plot the out-number survival function
figure
hold on
plot(0:1:max(outnum),Pout,'LineWidth',3);
plot(find(pout)-1,Pout(find(pout)),'.','MarkerSize',14);

%plot the power law fit
if (nargin == 0)
    x = xmin:max(outnum);
    plot(x,(Pout(xmin+1))*(Hurwitz_zeta(alpha,x)./Hurwitz_zeta(alpha,xmin)),'r','linewidth',3)
end
hold off
xlabel('out-number','FontSize',16)
ylabel('out-number survival function','FontSize',16)

if (nargin == 0)
    %plot and annotate the mean
    hold on
    plot([mean_outnum mean_outnum],[1.11*.002 1.11*.002],'Marker','v','MarkerFaceColor','b')
    text(mean_outnum-(0.03*180),1.5*0.002,strcat('mean=',num2str(mean_outnum,3)),'FontSize',14)
    hold off

    %adjust the axis limits and axis scale
    axis([0 180 0.002 1])
    set(gca,'XScale','log','YScale','log','FontSize',14)
    
    %add text arrow annotations
    annotation('textarrow',[0.8408 0.8795],[0.1647 0.1944],'String','AVAR','FontSize',14);
    annotation('textarrow',[0.8542 0.869],[0.381 0.3075],'String','AVAL','FontSize',14);
end

%plot the joint degree distribution
figure
bar3(numDist)
colormap('white')
xlabel('out-number')
ylabel('in-number')
axis tight