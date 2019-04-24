%SPECTRAL_BOTH.

%   Copyright 2006-2009.  Lav R. Varshney
%
%   This software is provided without warranty.

%   Related article:
%
%   L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B.
%   Chklovskii, "Structural properties of the Caenorhabditis elegans
%   neuronal network," 2009, in preparation.


%gap junction network
Gg = datareader('gap','weighted');
[index_ig,index_jg] = ind2sub(size(Gg),find(triu(Gg))); 

%chemical network
Gc = datareader('chem','weighted');
[index_ic,index_jc] = ind2sub(size(Gc),find(Gc)); 

%the GABAergic synapse listing
GABAergic = GABA;

%treat GABAergic synapses in chemical network as inhibitory
Gc(find(GABAergic),:) = -Gc(find(GABAergic),:);

%get the strong giant component
[S,C] = graphconncomp(Gc+Gg);
gc = mode(C);
AA = full(Gc(find(C==gc),find(C==gc)));
BB = full(Gg(find(C==gc),find(C==gc)));

%matrix associated with the linear system
L_orig = BB - diag(sum(BB)) + AA';

%gap junction ensemble parameters
p_g = 0.01;

%chemical ensemble parameters
p_c = 0.005;

%size of ensemble
nnn = 100;

for ii = 1:nnn
    %%%GAP
    %consider the upper triangle only
    GammaWg = full(triu(Gg));
    
    %go through each actual synaptic contact in the upper triangle;
    %with probability p, move it to some random place in the upper triangle
    for index = 1:length(index_ig)
        %amount to reduce
        reduc = sum(rand(1,Gg(index_ig(index),index_jg(index)))<p_g);
 
        %reduce this one by reduc
        GammaWg(index_ig(index),index_jg(index)) = GammaWg(index_ig(index),index_jg(index)) - reduc;

        %add on reduc elsewhere in the upper triangle
        for kk = 1:reduc
            loc = ceil(length(Gg)*rand(1,2));
            %can use min/max to force upper triangle because both
            %permutations are equiprobable in an iid random vector
            GammaWg(min(loc),max(loc)) = GammaWg(min(loc),max(loc)) + 1;
        end        
    end

    %symmetrize it
    GammaWg = triu(GammaWg) + triu(GammaWg)';
    

    %%%CHEM
    GammaWc = full(Gc);

    %go through each actual synaptic contact;
    %with probability p, move it to some random place
    for index = 1:length(index_ic)
        %amount to reduce
        reduc = sum(rand(1,Gc(index_ic(index),index_jc(index)))<p_c);
 
        %reduce this one by reduc
        GammaWc(index_ic(index),index_jc(index)) = GammaWc(index_ic(index),index_jc(index)) - reduc;

        %add on reduc elsewhere
        loc_i = ceil(length(Gc)*rand(1,reduc));
        loc_j = ceil(length(Gc)*rand(1,reduc));
        for loc_index = 1:length(loc_i)
            GammaWc(loc_i(loc_index),loc_j(loc_index)) = GammaWc(loc_i(loc_index),loc_j(loc_index)) + 1;
        end
    end

    %(GABAergic synapses in chemical network are already marked as inhibitory)
    
    %get the strong giant component for the original graph
    AA = full(GammaWc(find(C==gc),find(C==gc)));
    BB = full(GammaWg(find(C==gc),find(C==gc)));

    %matrix of edited graph associated with the linear system
    L = BB - diag(sum(BB)) + AA';

    %the eigenvalues and eigenvectors of the edited graph
    [V,E] = eig(L);
    eigenvalues{ii} = diag(E);

    %compute the spectral norm of the additive change matrix
    epsilon(ii) = norm(L-L_orig);
end

%mean and standard deviation of the spectral norm of additive change matrix
mean(epsilon)
std(epsilon)

%epsilon for pseudospectrum calculations
radius = 4;

%use the eigtool to look at the pseudospectrum
opts.npts=200;
opts.levels=[log10(radius)]; %choose the epsilon
opts.ax=[-130 36 -22 22];
opts.proj_lev=Inf;
opts.colour=1;
opts.thick_lines=0;
opts.scale_equal=0;
opts.grid=0;
opts.dim=0;
opts.no_ews=1;
opts.no_psa=0;
opts.fov=0;
opts.colourbar=0;
opts.imag_axis=0;
opts.unit_circle=0;
opts.direct=1;
opts.print_plot=1;

%plot the pseudospectrum
eigtool(L_orig,opts);

%the eigenvalues and eigenvectors of the original graph
[V,E] = eig(L_orig);

%plot epsilon disks around original spectrum
hold on
for ii = 1:length(E)
    rectangle('Position',[real(E(ii,ii))-radius,imag(E(ii,ii))-radius,radius*2,radius*2],'Curvature',[1,1],'FaceColor',[.8 1 1],'EdgeColor',[.8 1 1]);
end

%plot the eigenvalues for the perturbed matrices in the complex plane
for jj = 1:nnn
    Ep = eigenvalues{jj};
    plot(real(Ep),imag(Ep),'b.')
end

%plot the eigenvalues for the original matrix in the complex plane
plot(real(diag(E)),imag(diag(E)),'r.')


%Now consider the case where send_joints are treated as only partials
%chemical network
load A_sendjoint

%the GABAergic synapse listing
GABAergic = GABA;

%treat GABAergic synapses in send_joint chemical network as inhibitory
Ac(find(GABAergic),:) = -Ac(find(GABAergic),:);

%get the strong giant component
[S,C] = graphconncomp(Ac+Gg);
gc = mode(C);
AA_sendjoint = full(Ac(find(C==gc),find(C==gc)));
BB = full(Gg(find(C==gc),find(C==gc)));

%matrix associated with the linear system
L_sendjoint = BB - diag(sum(BB)) + AA_sendjoint';

%the eigenvalues and eigenvectors of the send_joint graph
[V_sendjoint,E_sendjoint] = eig(L_sendjoint);

%plot the eigenvalues for the original matrix in the complex plane
plot(real(diag(E_sendjoint)),imag(diag(E_sendjoint)),'g.','MarkerSize',3)


%%%

hold off

xlabel('Re(\lambda)','FontSize',12)
ylabel('Im(\lambda)','FontSize',12)
set(gca,'FontSize',10);