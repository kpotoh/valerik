# Microbial images

## Environment

Fight exceptions:

1. [Step-by-step installation of qiime](https://www.metagenomics.wiki/tools/16s/qiime/install/packagesnotfounderror)
2. [version of biom-format](https://github.com/biocore/biom-format/issues/839)

```bash
conda create -n qiime1 python=2.7  # create conda environment "qiime1"  
conda activate qiime1    # open "qiime1" environment

pip install numpy        # install numpy (python)
pip install biom-format==2.1.7
pip install qiime        # install qiime-1 (python)
pip install h5py         # install h5py (python) for reading .biom files
pip install matplotlib==1.4.3

print_qiime_config.py -t # test qiime-1 configuration
```

## Plan

Raw

```txt
Мне нужно филогенетическое дерево внутри клад нескольких по тому 16s  что есть хотя это будет не очень репрезентативно по крайней мере это пойдет метод максимального правдоподобия наверное пойдет но тебе лучше знать клады для которых нужны деревья : Mycobacteria нужно дерево  в пределах пробы 2 см глубиной Готландская впадина и дерево между всеми остальными пробами где они там есть и наверное еще дерево с теми ребятами которые есть в NCBI, И тоже самое наверное для Архей (4 группы у меня разных тоже будет неплохо наверное) . и для JS1…

В статьях которые я скинул samulina есть прикольные диаграммы дисковые я думал для нескольких групп микробов сделать такие если ты вдруг придумаешь как их сделать то будет круто если нет то пофиг сделаю еще столбики уебищные в первой статье там диаграммы   у Shimizu... с 111 по 137 красивые вещи особенно там анализы главных компонент и еще дерево в конце вроде оно по всем таксонам которые у него есть. Knittel мне нравиться пузырьковой диаграммой

нужен анализ главных компонент с той геологической штукой (в которых нет 4 моих образцов по глубине) и корреляции групп JS1 с глубиной. Константин Сенсей наш еще про ГЦ состав говорил но наверное его можно для глубины сделать( для каждой пробы отдельно всех в кучу , типа как отношение к кислороду…
```

1. **done** tree on OTUs
2. **unneded** [pie](https://medium.com/@kvnamipara/a-better-visualisation-of-pie-charts-by-matplotlib-935b7667d77f) chart like in the [paper](./docs/Samylina2021_Article_OnThePossibilityOfAerobicMetha.pdf)
3. **done** Relative abundance VS depth - [stackplot](https://stackoverflow.com/questions/50802556/how-to-plot-a-vertical-area-plot-with-pandas)
4. **done** [beta diversity](http://qiime.org/scripts/beta_diversity.html) analysis
5. **done** Microbial community by 16S rRNA gene [NMDS](http://qiime.org/scripts/nmds.html) (non-metric multidimensional scaling ordination)
6. Chemicals VS community composition. RDA should be chosen if the studied gradient is small, and CCA when it’s large, so that the contingency table is sparse.
7. **almost done** Global correlation plot

## Phylogenetic Tree

T.R. Iasakov et al. 2022

Sequences of the V4 hypervariable region of the 16S rRNA gene
belonging to the ANME group and reference 16S rRNA gene sequences of
the closest cultivated archaea were aligned using MUSCLE (Edgar,
2004). Phylogenetic tree of archaeal 16S rRNA of V4 hypervariable re­
gion gene sequences was inferred with RAxML software ver. 8.2.4
(Stamatakis, 2014) using the Maximum Likelihood method with
GAMMA + P-Invariant model and GTR substitution matrix. 100 boot­
straps were produced to assess confidence of the phylogenetic tree. The
phylogenetic tree was visualized using FigTree.

```bash
# Alignment
muscle -in sequences_otu.fasta -out aln_otu.fasta

# Building tree
iqtree2 -s aln_otu.fasta -m GTR+G -nt 24 -B 1000 --prefix phylo

# rooting
nw_reroot phylo.treefile > phylo.treefile.rooted
```

## Beta diversity

```bash
beta_diversity.py -i otu_table.biom -m bray_curtis -o beta_div_bray_curtis
beta_diversity.py -i otu_table.biom -m unweighted_unifrac -o beta_div_unweighted_unifrac -t phylo.treefile
beta_diversity.py -i otu_table.biom -m weighted_unifrac -o beta_div_weighted_unifrac -t phylo.treefile

weighted_unifrac
```

## NMDS

The microbial community composition differed significantly by station (Figure
24a; ANOSIM: R = 0.36, p = 0.006, 999 permutation) except between Stations H and I
(ANOSIM: R < 0.01, p= 0.17). The community composition differed also between 0-10cm
and 10-20 cm sediment depths (Figure 24b; ANOSIM: R = 0.35 p= 0.001). The surface
samples from all stations were clustered relatively closely (ANOSIM: R = 0.35, p = 0.018),
120compared to the deeper sediment samples (ANOSIM: R = 0.77, p = 0.001) (Figure 24b).
**The deeper the sediment cores, the microbial communities are more different among the
stations.** This reflects that geochemical gradients downcore shape specific niche
differentiation for microbial community.

Figure 24: Non-metric multidimensional scaling (NMDS) plot of microbial
communities based on Bray-Curtis dissimilarity for 16S rRNA gene libraries. The
community profiles from each sample; a) color represents sampling stations. Ellipses
represent 95% intervals around centroids for each sampling station. b) color
represents sediment depth.

## References

1. [Non-metric multidimensional scaling](https://mb3is.megx.net/gustame/dissimilarity-based-methods/nmds)
2. sklearn [MDS](https://scikit-learn.org/stable/modules/generated/sklearn.manifold.MDS.html) with `metric=False`
3. [Beta diversity](http://scikit-bio.org/docs/0.2.0/generated/skbio.diversity.beta.html) in python
4. [QIIME tutorial](https://twbattaglia.gitbooks.io/introduction-to-qiime/content/beta_analysis.html); looks nice
5. [biom table](https://biom-format.org/documentation/generated/biom.table.Table.html)
