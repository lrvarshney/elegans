function visualize
%VISUALIZE Visualizes C. elegans wiring diagram.
%   VISUALIZE produces a visualization of the C. elegans wiring diagram
%   using spectral graph drawing techniques.

%   Copyright 2004-2009.  Dmitri B. Chklovskii, Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.


%combine the chemical and gap junction networks
A = datareader('gap','weighted') + datareader('chem','weighted');

%number of nodes
n = size(A,1);

%node labels and node class labels
[tmp,labels,class] = datareader('chem','weighted');

%symmetrize the adjacency matrix
c = full((A+A')/2);

%degree matrix
d = diag(sum(c));

%Laplacian matrix
l = d - c;

%compute the vertical coordinates
b = sum(c.*sign(full(A-A')),2);
z = pinv(l)*b;

%degree-normalized graph Laplacian
q = d^(-1/2)*l*d^(-1/2);

%coordinates in plane are eigenvectors of degree-normalized graph Laplacian
[vx,lambda] = eig(q);
x = d^(-1/2)*vx(:,2);
y = d^(-1/2)*vx(:,3);

%plot the graph
for vv = 1:2
    figure
    hold on

    %the nodes
    plot3(x,y,z,'.','Color',[0 0 0]);

    %edges (only ones that actually exist)
    [ii,jj] = find(c);
    line([x(ii)'; x(jj)'],[y(ii)'; y(jj)'],[z(ii)'; z(jj)'],'Color', [0.85 0.85 0.85],'LineWidth',0.06)

    %coloring of the nodes
    for ii = 1:n
        if (findstr(char(class(ii)),'S') > 1)
            plot3(x(ii),y(ii),z(ii),'.','Color',[1 0 0],'MarkerSize',20)
        elseif (findstr(char(class(ii)),'M') > 1)
            plot3(x(ii),y(ii),z(ii),'.','Color',[0 1 0],'MarkerSize',20)
        elseif (findstr(char(class(ii)),'I') > 1)
            plot3(x(ii),y(ii),z(ii),'.','Color',[0 0 1],'MarkerSize',20)
        end
    end

    %node labels
    text((x+2e-4)',y',z',[labels(1:n)],'FontSize',10,'FontWeight','bold');
    hold off

    xlabel('HORIZONTAL 1','FontWeight','bold','FontSize',16)
    ylabel('HORIZONTAL 2','FontWeight','bold','FontSize',16)
    zlabel('VERTICAL','FontWeight','bold','FontSize',16)

    if vv == 1
        view([360 0])
        text(-0.024,0,1.85,'SIDE VIEW','FontSize',25,'FontWeight','bold');
    else
        text(-0.024,0.047,0,'TOP VIEW','FontSize',25,'FontWeight','bold');
    end
end