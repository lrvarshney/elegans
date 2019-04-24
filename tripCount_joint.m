function tripCount_joint
%TRIPCOUNT_JOINT The conditional counts of the triplets of the two networks.
%   TRIPCOUNT_JOINT calculates the subgraph distribution over three
%   nodes for the chemical network given the gap junction subgraph.  
%
%   See also TRIPCOUNT_CHEM.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.

%chemical network
C = datareader('chem','unweighted');

%gap junction network
G = datareader('gap','unweighted');

subhandle = loopchoose(length(G),3); % initialization call
p = nchoosek(length(G),3);

flag = 1;
if flag
    %counts
    counts = zeros(2,p);
    for ii = 1:p
        subbs = subhandle();

        %the gap junction network motif for this subgraph
        sg_gap = G(subbs,subbs);
        counts(1,ii) = bin2dec(strcat(num2str(sg_gap(1,2)),num2str(sg_gap(1,3)),num2str(sg_gap(2,3))));

        %the chemical network motif for this subgraph
        sg_chem = C(subbs,subbs);
        counts(2,ii) = bin2dec(strcat(num2str(sg_chem(1,2)),num2str(sg_chem(1,3)),num2str(sg_chem(2,1)),num2str(sg_chem(2,3)),num2str(sg_chem(3,1)),num2str(sg_chem(3,2))));
    end
else
    load triplets_joint
end

inds_red3 = {
    [0];
    [1,2];
    [4,16];
    [8,32];
    [40];
    [5,18];
    [3];
    [12,48];
    [20];
    [10,33];
    [9,34];
    [6,17];
    [24,36];
    [41,42];
    [21,22];
    [26,37];
    [7,19];
    [44,56];
    [13,50];
    [45,58];
    [23];
    [11,35];
    [14,49];
    [28,52];
    [25,38];
    [30,53];
    [43];
    [27,39];
    [46,57];
    [29,54];
    [60];
    [15,51];
    [47,59];
    [61,62];
    [31,55];
    [63]
};

inds_red2 = {
    [0];
    [4,8];
    [1,32];
    [2,16];
    [18];
    [5,40];
    [12];
    [3,48];
    [33];
    [10,20];
    [6,24];
    [9,36];
    [17,34];
    [22,26];
    [37,41];
    [21,42];
    [13,44];
    [19,50];
    [7,56];
    [23,58];
    [45];
    [14,28];
    [11,52];
    [35,49];
    [25,38];
    [43,53];
    [30];
    [29,46];
    [27,54];
    [39,57];
    [51];
    [15,60];
    [31,62];
    [55,59];
    [47,61];
    [63]
    };

inds_red1 = {
    [0];
    [16,32];
    [2,8];
    [1,4];
    [5];
    [18,40];
    [48];
    [3,12];
    [10];
    [20,33];
    [17,36];
    [24,34];
    [6,9];
    [21,37];
    [26,42];
    [22,41];
    [50,56];
    [7,13];
    [19,44];
    [23,45];
    [58];
    [49,52];
    [28,35];
    [11,14];
    [25,38];
    [30,43];
    [53];
    [54,57];
    [29,39];
    [27,46];
    [15];
    [51,60];
    [55,61];
    [31,47];
    [59,62];
    [63]
    };

chem_gap2 = zeros(1,36);
for ii = 1:p
    %red node is in position 1
    if counts(1,ii) == 1
        for jj = 1:length(chem_gap2)
            if any(inds_red1{jj} == counts(2,ii))
                chem_gap2(jj) = chem_gap2(jj) + 1;
            end
        end
    %red node is in position 2
    elseif counts(1,ii) == 2
        for jj = 1:length(chem_gap2)
            if any(inds_red2{jj} == counts(2,ii))
                chem_gap2(jj) = chem_gap2(jj) + 1;
            end
        end
    %red node is in position 3
    elseif counts(1,ii) == 4
        for jj = 1:length(chem_gap2)
            if any(inds_red3{jj} == counts(2,ii))
                chem_gap2(jj) = chem_gap2(jj) + 1;
            end
        end
    end
end

chem_gap4 = zeros(1,36);
for ii = 1:p
    %red node is in position 3
    if counts(1,ii) == 3
        for jj = 1:length(chem_gap4)
            if any(inds_red3{jj} == counts(2,ii))
                chem_gap4(jj) = chem_gap4(jj) + 1;
            end
        end
    %red node is in position 2
    elseif counts(1,ii) == 5
        for jj = 1:length(chem_gap4)
            if any(inds_red2{jj} == counts(2,ii))
                chem_gap4(jj) = chem_gap4(jj) + 1;
            end
        end
    %red node is in position 1
    elseif counts(1,ii) == 6
        for jj = 1:length(chem_gap4)
            if any(inds_red1{jj} == counts(2,ii))
                chem_gap4(jj) = chem_gap4(jj) + 1;
            end
        end
    end
end

%plot the results
ylength = 1e4;
ybase = 6e4;
figure
hold on
bar(chem_gap2);
p = plot([27 31],[ybase (ybase + ylength*1.732050807568877)],'ko-');
p2 = plot([35],[ybase],'ro-');
hold off
h = axis;
axis([0 37 h(3) h(4)])
set(p,'LineWidth',3,'MarkerFaceColor',[0 0 0],'MarkerSize',8)
set(p2,'LineWidth',3,'MarkerFaceColor',[1 0 0],'MarkerSize',8)
set(gca,'XTick',1:2:36)

ylength = 200;
ybase = 1000;
figure
hold on
bar(chem_gap4);
p = plot([27 31 35],[ybase (ybase + ylength*1.732050807568877) ybase],'ko-');
p2 = plot([31],[ybase + ylength*1.732050807568877],'ro-');
hold off
h = axis;
axis([0 37 h(3) h(4)])
set(p,'LineWidth',3,'MarkerFaceColor',[0 0 0],'MarkerSize',8)
set(p2,'LineWidth',3,'MarkerFaceColor',[1 0 0],'MarkerSize',8)
set(gca,'XTick',1:2:36)