function degDist_both
%DEGDIST_BOTH Plots the joint degree distribution, in-degree and out-degree for the combined network.
%   DEGDIST_CHEM produces a plot of the joint distribution of the in-degree
%   and out-degree of the combined gap junction and chemical network.  It 
%   also plots the survival function of the in-degree distribution and of 
%   the out-degree distribution, together with exponetial fits.
%
%   See also DEGDIST_CHEM, DEGDIST_GAP.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

%adjacency matrix
A = full(datareader('gap','unweighted') + datareader('chem','unweighted') > 0);

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

%power law fit to tail of in-degree yields parameters:
II = find(pin)-1;
xmin = 14;
alpha = 3.24;

%plot the in-degree survival function
figure
hold on
plot(0:1:max(indeg),Pin,'LineWidth',3);
plot(II,Pin(II+1),'.','MarkerSize',14);

%plot the power law fit
x = xmin:max(indeg);
plot(x,(Pin(xmin+1))*(Hurwitz_zeta(alpha,x)./Hurwitz_zeta(alpha,xmin)),'r','linewidth',3)
hold off
xlabel('in-degree','FontSize',14)
ylabel('in-degree survival function','FontSize',14)

%plot and annotate the mean
hold on
plot([mean_indeg mean_indeg],[1.11*.002 1.11*.002],'Marker','v','MarkerFaceColor','b')
text(mean_indeg-1.05,1.5*0.002,strcat('mean=',num2str(mean_indeg,3)),'FontSize',12)
hold off

%add text arrow annotations
annotation('textarrow',[0.5676 0.9],[0.2594 0.21],'String','AVAL','FontSize',14);
annotation('textarrow',[0.75 0.894],[0.2815 0.2915],'String','AVAR','FontSize',14);
annotation('textarrow',[0.85 0.859],[0.5218 0.3671],'String','AVBL/R','FontSize',14);

%adjust the axis limits and axis scale
axis([0 84 0.002 1])
set(gca,'XScale','log','YScale','log','FontSize',12)

%power law fit to tail of out-degree yields parameters:
xmin = 16;
alpha = 4.07;

%plot the out-degree survival function
figure
hold on
plot(0:1:max(outdeg),Pout,'LineWidth',3);
plot(find(pout)-1,Pout(find(pout)),'.','MarkerSize',14);

%plot the power law fit
x = xmin:max(outdeg);
plot(x,(Pout(xmin+1))*(Hurwitz_zeta(alpha,x)./Hurwitz_zeta(alpha,xmin)),'r','linewidth',3)
hold off
xlabel('out-degree','FontSize',14)
ylabel('out-degree survival function','FontSize',14)

%plot and annotate the mean
hold on
plot([mean_outdeg mean_outdeg],[1.11*.002 1.11*.002],'Marker','v','MarkerFaceColor','b')
text(mean_outdeg-1.05,1.5*0.002,strcat('mean=',num2str(mean_outdeg,3)),'FontSize',12)
hold off

%add text arrow annotations
annotation('textarrow',[0.5676 0.89],[0.2594 0.21],'String','AVAR','FontSize',14);
annotation('textarrow',[0.75 0.87],[0.2815 0.2915],'String','AVAL','FontSize',14);
annotation('textarrow',[0.85 0.84],[0.5218 0.3671],'String','AVBL/R','FontSize',14);

%adjust the axis limits and axis scale
axis([0 58 0.002 1])
set(gca,'XScale','log','YScale','log','FontSize',12)

%plot the joint degree distribution
figure
bar3(degDist)
colormap('white')
xlabel('out-degree')
ylabel('in-degree')
axis tight