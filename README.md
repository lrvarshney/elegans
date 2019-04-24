<h1>Structural Properties of the <i>Caenorhabditis elegans</i> Neuronal Network</h1>
<h2>Lav R. Varshney, Beth L. Chen, Eric Paniagua, David H. Hall, and Dmitri B. Chklovskii</h2>

<h3>Abstract</h3>
<p>
Despite recent interest in reconstructing neuronal networks, complete wiring diagrams on the level of 
individual synapses remain scarce and the insights into function they can provide remain unclear. 
Even for <i>Caenorhabditis elegans</i>, whose neuronal network is relatively small and stereotypical 
from animal to animal, published wiring diagrams are neither accurate nor complete and self-consistent. 
Using materials from White <i>et al.</i> and new electron micrographs we assemble whole, self-consistent 
gap junction and chemical synapse networks of hermaphrodite <i>C. elegans</i>. We propose a method to 
visualize the wiring diagram, which reflects network signal flow. We calculate statistical and topological 
properties of the network, such as degree distributions, synaptic multiplicities, and small-world properties, 
that help in understanding network signal propagation. We identify neurons that may play central roles in 
information processing, and network motifs that could serve as functional modules of the network. We explore 
propagation of neuronal activity in response to sensory or artificial stimulation using linear systems theory 
and find several activity patterns that could serve as substrates of previously described behaviors. Finally, 
we analyze the interaction between the gap junction and the chemical synapse networks. Since several statistical 
properties of the <i>C. elegans</i> network, such as multiplicity and motif distributions are similar to 
those found in mammalian neocortex, they likely point to general principles of neuronal networks. The wiring 
diagram reported here can help in understanding the mechanistic basis of behavior by generating predictions 
about future experiments involving genetic perturbations, laser ablations, or monitoring propagation of neuronal 
activity in response to stimulation.
</p>

<h3>Reference</h3>
<p>
L. R. Varshney, B. L. Chen, E. Paniagua, D. H. Hall, and D. B. Chklovskii, "Structural
properties of the <i>Caenorhabditis elegans</i> neuronal network," <i>PLoS Computational Biology</i>,
vol. 7, no. 2, e1001066, Feb. 2011.  http://dx.doi.org/10.1371/journal.pcbi.1001066
</p>


<h3>Data</h3>
<p>
Here you can find the <i>C. elegans</i> connectivity data.  See also <a href="http://www.wormatlas.org/">WormAtlas</a>.
</p>

<table border="2">
<tr><th>C. elegans Connectivity Data</th></tr>
<tr>
  <td> Adjacency matrices and neuron labels</td>
  <td> ConnOrdered_040903.mat</td>
</tr>
<tr>
  <td> Neuron class labels</td>
  <td> NeuronTypeOrdered_040903.mat</td>
</tr>
<tr>
  <td> Chemical synapse adjacency matrix under alternate send_joint quantitation</td>
  <td> A_sendjoint.mat</td>
</tr>
</table>


<h3>Code</h3>
<p>
Here you can find the code to compute several graph functionals and to reproduce figures and tables from the paper.  
If you use this code in your research and publications, please also put a reference to this paper.  Thank you!
</p>
<p>
These files were developed with <a href="http://www.mathworks.com/products/matlab/">Matlab</a> Version 7.4.0 (R2007a) 
on Microsoft Windows XP (Version 2002).  Some use the Bioinformatics Toolbox 3.1.
</p>

<table border="2">
<tr><th>Data Reading Utilities</th></tr>
<tr>
  <td> Data reader </td>
  <td> general </td>
  <td> datareader.m</td>
</tr>
<tr>
  <td> Listing of neurons with GABAergic synapses </td>
  <td> general </td>
  <td> GABA.m</td>
</tr>
<tr><th>Mathematical Utilities</th></tr>
<tr>
  <td> Hurwitz zeta function </td>
  <td> general </td>
  <td> Hurwitz_zeta.m</td>
</tr>


<tr><th>Three Layer Architecture</th></tr>
<tr>
  <td> Partitioning and visualization of adjacency matrices </td>
  <td> Figure 1</td>
  <td> layers.m, layers_i.m </td>
</tr>
<tr>
  <td> Total connectivity weight between different categories of neurons </td>
  <td> Tables S2, S4</td>
  <td> layerconn.m</td>
</tr>

<tr><th>Visualization</th></tr>
<tr>
  <td> Visualization of C. elegans wiring diagram </td>
  <td> Figure 2 </td>
  <td> visualize.m</td>
</tr>

<tr><th>Connected Components</th></tr>
<tr>
  <td> Connected components of an undirected graph (gap junction)</td>
  <td> Table S1</td>
  <td> conncomp_gap.m</td>
</tr>
<tr>
  <td> Connected components of a directed graph (chemical)</td>
  <td> Table S5</td>
  <td> conncomp_chem.m</td>
</tr>
<tr>
  <td> Connected components of combined network</td>
  <td> </td>
  <td> conncomp_both.m</td>
</tr>


<tr><th>Degree Distribution</th></tr>
<tr>
  <td> Degree distribution of an undirected graph (gap junction) </td>
  <td> Figure 3(a)</td>
  <td> degDist_gap.m</td>
</tr>
<tr>
  <td> Degree distribution of a directed graph (chemical) </td>
  <td> Figures 6(a), 6(b), 6(c)</td>
  <td> degDist_chem.m</td>
</tr>
<tr>
  <td> Correlations among degree sequences </td>
  <td> </td>
  <td> degDistCorr.m</td>
</tr>
<tr>
  <td> Degree distribution of combined network </td>
  <td> Figure S4</td>
  <td> degDist_both.m</td>
</tr>

<tr><th>Multiplicity Distribution</th></tr>
<tr>
  <td> Multiplicity distribution of an undirected graph (gap junction) </td>
  <td> Figure 3(b)</td>
  <td> multDist_gap.m</td>
</tr>
<tr>
  <td> Multiplicity distribution of a directed graph (chemical) </td>
  <td> Figure 6(d)</td>
  <td> multDist_chem.m</td>
</tr>

<tr><th>Number Distribution</th></tr>
<tr>
  <td> Number distribution of an undirected graph (gap junction) </td>
  <td> Figure 3(c)</td>
  <td> numDist_gap.m</td>
</tr>
<tr>
  <td> Number distribution of a directed graph (chemical) </td>
  <td> Figures 6(e), 6(f)</td>
  <td> numDist_chem.m</td>
</tr>


<tr><th>Small World Characteristics</th></tr>
<tr>
  <td> Geodesic distance distribution of an undirected graph (gap junction) </td>
  <td> Figure S1(a)</td>
  <td> geodistDist_gap.m</td>
</tr>
<tr>
  <td> Geodesic distance distribution of a directed graph (chemical) </td>
  <td> Figure S1(b)</td>
  <td> geodistDist_chem.m</td>
</tr>
<tr>
  <td> Geodesic distance distribution of combined network </td>
  <td> Figure S1(c)</td>
  <td> geodistDist_both.m</td>
</tr>
<tr>
  <td> Closeness centrality of an undirected graph (gap junction) </td>
  <td> </td>
  <td> closenesscentrality_gap.m</td>
</tr>
<tr>
  <td> Closeness centrality of a directed graph (chemical) </td>
  <td> </td>
  <td> closenesscentrality_chem.m</td>
</tr>
<tr>
  <td> Closeness centrality of combined network </td>
  <td> </td>
  <td> closenesscentrality_both.m</td>
</tr>
<tr>
  <td> Characteristic path length of an undirected graph (gap junction) </td>
  <td> Table S3</td>
  <td> pathlength_gap.m</td>
</tr>
<tr>
  <td> Characteristic path length of a directed graph (chemical) </td>
  <td> </td>
  <td> pathlength_chem.m</td>
</tr>
<tr>
  <td> Characteristic path length of combined network </td>
  <td> </td>
  <td> pathlength_both.m</td>
</tr>
<tr>
  <td> Clustering coefficient of an undirected graph (gap junction) </td>
  <td> Table S3</td>
  <td> clustcoef_gap.m</td>
</tr>
<tr>
  <td> Clustering coefficient of a directed graph (chemical) </td>
  <td> </td>
  <td> clustcoef_chem.m</td>
</tr>
<tr>
  <td> Clustering coefficient of combined network </td>
  <td> </td>
  <td> clustcoef_both.m</td>
</tr>

<tr><th>Linear Systems Analysis</th></tr>
<tr>
  <td> Spectral properties for gap junction network </td>
  <td> Figures 4, S2, S3</td>
  <td> LaplacianSpec_gap.m</td>
</tr>
<tr>
  <td> Spectral properties for combined network </td>
  <td> Figure 8</td>
  <td> Spec_both.m</td>
</tr>


<tr><th>Motifs</th></tr>
<tr>
  <td> Doublet counts of a directed network (chemical) </td>
  <td> Figure 7(a)</td>
  <td> doubCount_chem.m</td>
</tr>
<tr>
  <td> Triplet counts of an undirected network (gap junction) </td>
  <td> Figure 5(a)</td>
  <td> tripCount_gap.m</td>
</tr>
<tr>
  <td> Triplet counts of a directed network (chemical) </td>
  <td> Figure 7(b)</td>
  <td> tripCount_chem.m</td>
</tr>
<tr>
  <td> Conditional doublet counts of a directed network given an undirected network (chemical given gap junction) </td>
  <td> Figure 9(a)</td>
  <td> doubCount_joint.m</td>
</tr>
<tr>
  <td> Conditional triplet counts of chemical network given gap junction network</td>
  <td> Figure 9(b)</td>
  <td> tripCount_joint.m, loopchoose.m</td>
</tr>

<tr><th>Robustness</th></tr>
<tr>
  <td> Characteristic path length vitality of gap junction network </td>
  <td> </td>
  <td> pathlengthVitality_gap.m</td>
</tr>
<tr>
  <td> Robustness characterization of gap junction network </td>
  <td> Table S6</td>
  <td> robustness_gap.m</td>
</tr>
<tr>
  <td> Robustness characterization of chemical network </td>
  <td> Table S7</td>
  <td> robustness_chem.m</td>
</tr>
<tr>
  <td> Robustness characterization of linear systems analysis for combined network </td>
  <td> Figure 10</td>
  <td> spectral_both.m</td>
</tr>
</table>


<h6>Last Updated 2011</h6>
